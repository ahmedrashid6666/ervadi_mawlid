import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Generates a nicely designed, shareable PDF for a single Baith.
///
/// Important: the PDF package's built-in bidirectional/Arabic text engine
/// (package:bidi) crashes on some of these verses, so ALL script text
/// (Arabic verses, titles and Malayalam translations) is rendered to images
/// using Flutter's own text engine, which shapes Arabic and Malayalam
/// correctly. Only plain Latin/ASCII text uses the PDF text widgets.
///
/// Design:
///  * App-matching green / amber palette (Amiri typeface for Arabic).
///  * Verses alternate right / left, mirroring the in-app couplet layout.
///  * A faint centred logo + "ERVADI MAWLID" watermark on every page.
///  * A footer on every page with a clickable "Download Ervadi App" button
///    linking to the Play Store, plus a closing call-to-action card.
class BaithPdf {
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=in.mawlid.ervadi';

  // Palette – matches the app theme (assets.dart / theme.dart).
  static final PdfColor green = PdfColor.fromInt(0xFF074425);
  static final PdfColor greenLight = PdfColor.fromInt(0xFF096637);
  static final PdfColor amber = PdfColor.fromInt(0xFFFFC107);
  static final PdfColor cream = PdfColor.fromInt(0xFFFCF8EF);
  static final PdfColor cardBorder = PdfColor.fromInt(0xFFE7DEC7);

  // Flutter-side colours used when rasterising text.
  static const ui.Color _inkGreen = ui.Color(0xFF0E3B22);
  static const ui.Color _white = ui.Color(0xFFFFFFFF);
  static const ui.Color _malayalamInk = ui.Color(0xFF1B4332);

  /// Shows a styled bottom sheet letting the user pick the PDF variant.
  static void showShareSheet(
    BuildContext context, {
    required String title,
    required List<String> lines,
    required List<String> translations,
    required int index,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (ctx) => _ShareSheet(
        title: title,
        lines: lines,
        translations: translations,
        index: index,
      ),
    );
  }

  /// Builds the PDF bytes.
  static Future<Uint8List> buildPdf({
    required String title,
    required List<String> lines,
    required List<String> translations,
    required int index,
    required bool withTranslation,
  }) async {
    // --- Logo (rasterised via flutter_svg; the PDF SVG parser is fragile) ---
    pw.ImageProvider? logoWhite;
    pw.ImageProvider? logoGreen;
    try {
      final logoSvg =
          await rootBundle.loadString('assets/img/ervadimoulid.svg');
      final whitePng = await _svgToPng(_recolorSvg(logoSvg, '#ffffff'), 320);
      final greenPng = await _svgToPng(_recolorSvg(logoSvg, '#0a3f24'), 760);
      if (whitePng != null) logoWhite = pw.MemoryImage(whitePng);
      if (greenPng != null) logoGreen = pw.MemoryImage(greenPng);
    } catch (_) {/* fall back to text header */}

    // --- Title images (Arabic, rendered by Flutter engine) ---
    final titleImg = await _renderImage(
      text: title,
      fontFamily: 'Amiri',
      fontSize: 64,
      color: _white,
      fontWeight: ui.FontWeight.bold,
      align: ui.TextAlign.center,
      direction: ui.TextDirection.rtl,
      maxWidth: 1500,
    );
    final titleSmallImg = await _renderImage(
      text: title,
      fontFamily: 'Amiri',
      fontSize: 40,
      color: _white,
      fontWeight: ui.FontWeight.bold,
      align: ui.TextAlign.center,
      direction: ui.TextDirection.rtl,
      maxWidth: 1200,
    );

    // --- Verse images (Arabic) ---
    final verseImgs = <_Img?>[];
    for (var i = 0; i < lines.length; i++) {
      final highlight = i < 2;
      verseImgs.add(await _renderImage(
        text: lines[i],
        fontFamily: 'Amiri',
        fontSize: 52,
        color: highlight ? _white : _inkGreen,
        fontWeight: ui.FontWeight.bold,
        align: ui.TextAlign.center,
        direction: ui.TextDirection.rtl,
        maxWidth: 1600,
      ));
    }

    // --- Translation images (Malayalam) ---
    final transImgs = List<_Img?>.filled(lines.length, null);
    if (withTranslation) {
      for (var i = 0; i < lines.length; i++) {
        final t = i < translations.length ? translations[i] : '';
        if (t.trim().isNotEmpty) {
          transImgs[i] = await _renderImage(
            text: t,
            fontFamily: null, // system fallback shapes Malayalam
            fontSize: 40,
            // White inside the green (highlighted) opening couplet.
            color: i < 2 ? _white : _malayalamInk,
            align: ui.TextAlign.left,
            direction: ui.TextDirection.ltr,
            maxWidth: 1180,
          );
        }
      }
    }

    final doc = pw.Document(
      title: 'Ervadi Mawlid — Baith ${index + 1}',
      author: 'Ervadi Mawlid',
      creator: 'Ervadi Mawlid App',
    );

    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(30, 30, 30, 26),
      buildBackground: (ctx) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          alignment: pw.Alignment.center,
          children: [
            pw.Container(color: cream),
            if (logoGreen != null)
              pw.Opacity(opacity: 0.05, child: pw.Image(logoGreen, width: 360)),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 250),
              child: pw.Opacity(
                opacity: 0.07,
                child: pw.Text(
                  'ERVADI MAWLID',
                  style: pw.TextStyle(
                    fontSize: 26,
                    letterSpacing: 6,
                    color: green,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        header: (ctx) => ctx.pageNumber == 1
            ? pw.SizedBox()
            : _continuationHeader(titleSmallImg, logoWhite),
        footer: _footer,
        build: (ctx) => [
          _banner(titleImg, index, logoWhite),
          pw.SizedBox(height: 18),
          ..._verses(lines, verseImgs, transImgs),
          pw.SizedBox(height: 18),
          _closingCta(),
        ],
      ),
    );

    return doc.save();
  }

  static String _recolorSvg(String svg, String hex) => svg
      .replaceAll(RegExp(r'<\?xml.*?\?>', dotAll: true), '')
      .replaceAll(RegExp(r'<!DOCTYPE.*?>', dotAll: true), '')
      .replaceAll('#000000', hex)
      .replaceAll('#000', hex)
      .replaceAll('fill="black"', 'fill="$hex"')
      .trim();

  /// Rasterises an SVG string to PNG bytes at the given pixel [width].
  static Future<Uint8List?> _svgToPng(String rawSvg, int width) async {
    try {
      final PictureInfo info =
          await vg.loadPicture(SvgStringLoader(rawSvg), null);
      final ui.Size size = info.size;
      if (size.width <= 0 || size.height <= 0) {
        info.picture.dispose();
        return null;
      }
      final double scale = width / size.width;
      final int outW = width;
      final int outH = (size.height * scale).ceil();
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder);
      canvas.scale(scale);
      canvas.drawPicture(info.picture);
      final ui.Image image =
          await recorder.endRecording().toImage(outW, outH);
      info.picture.dispose();
      final bd = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      return bd?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  // ---- PDF building blocks --------------------------------------------------

  static pw.Widget _banner(_Img? titleImg, int index, pw.ImageProvider? logo) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [greenLight, green],
          begin: pw.Alignment.topLeft,
          end: pw.Alignment.bottomRight,
        ),
        borderRadius: pw.BorderRadius.circular(18),
      ),
      child: pw.Column(
        children: [
          if (logo != null) pw.Image(logo, width: 150),
          pw.SizedBox(height: 10),
          pw.Text(
            'ERVADI MAWLID',
            style: pw.TextStyle(
              fontSize: 10,
              letterSpacing: 4,
              color: amber,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 14),
          pw.Container(width: 70, height: 2, color: amber),
          pw.SizedBox(height: 14),
          if (titleImg != null)
            _pdfImage(titleImg, targetPt: 26, maxW: 460)
          else
            pw.Text('Baith ${index + 1}',
                style: pw.TextStyle(fontSize: 22, color: PdfColors.white)),
          pw.SizedBox(height: 8),
          pw.Text(
            'Baith ${index + 1}',
            style: pw.TextStyle(
                fontSize: 11, color: PdfColor.fromInt(0xCCFFFFFF)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _continuationHeader(
      _Img? titleSmall, pw.ImageProvider? logo) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: pw.BoxDecoration(
        gradient: pw.LinearGradient(colors: [greenLight, green]),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          if (logo != null)
            pw.Image(logo, width: 74)
          else
            pw.Text('ERVADI MAWLID',
                style: pw.TextStyle(
                    fontSize: 9, color: amber, letterSpacing: 2)),
          if (titleSmall != null)
            _pdfImage(titleSmall, targetPt: 13, maxW: 240),
        ],
      ),
    );
  }

  static List<pw.Widget> _verses(
    List<String> lines,
    List<_Img?> verseImgs,
    List<_Img?> transImgs,
  ) {
    final widgets = <pw.Widget>[];
    // One card = one couplet: first hemistich to the right, second to the
    // left. A right/left pair is a single group (one box).
    for (var i = 0; i < lines.length; i += 2) {
      final bool highlight = i < 2; // opening refrain couplet
      final kids = <pw.Widget>[];

      void addHemistich(int idx, pw.Alignment vAlign) {
        final verse = verseImgs[idx];
        if (verse != null) {
          kids.add(_pdfImage(verse, targetPt: 17, maxW: 480, align: vAlign));
        } else {
          kids.add(pw.Align(alignment: vAlign, child: pw.Text(lines[idx])));
        }
        final trans = transImgs[idx];
        if (trans != null) {
          kids.add(pw.SizedBox(height: 6));
          kids.add(pw.Divider(
            height: 1,
            thickness: 0.6,
            color: highlight ? PdfColor.fromInt(0x55FFFFFF) : cardBorder,
          ));
          kids.add(pw.SizedBox(height: 6));
          kids.add(_pdfImage(trans, targetPt: 12.5, maxW: 500, align: vAlign));
        }
      }

      addHemistich(i, pw.Alignment.centerRight);
      if (i + 1 < lines.length) {
        kids.add(pw.SizedBox(height: 10));
        addHemistich(i + 1, pw.Alignment.centerLeft);
      }

      widgets.add(
        pw.Container(
          width: double.infinity,
          margin: const pw.EdgeInsets.symmetric(vertical: 5),
          padding: const pw.EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: pw.BoxDecoration(
            color: highlight ? null : PdfColors.white,
            gradient: highlight
                ? pw.LinearGradient(
                    colors: [greenLight, green],
                    begin: pw.Alignment.topLeft,
                    end: pw.Alignment.bottomRight,
                  )
                : null,
            borderRadius: pw.BorderRadius.circular(14),
            border:
                highlight ? null : pw.Border.all(color: cardBorder, width: 0.8),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: kids,
          ),
        ),
      );
    }
    return widgets;
  }

  static pw.Widget _closingCta() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFF3EEDD),
        borderRadius: pw.BorderRadius.circular(14),
        border: pw.Border.all(color: cardBorder, width: 0.8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'Get the full Ervadi Mawlid experience',
            style: pw.TextStyle(
                fontSize: 13, color: green, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Audio recitation, translations, dargah info and more.',
            style: pw.TextStyle(
                fontSize: 9, color: PdfColor.fromInt(0xFF6B6B6B)),
          ),
          pw.SizedBox(height: 12),
          pw.UrlLink(
            destination: playStoreUrl,
            child: pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 22),
              decoration: pw.BoxDecoration(
                gradient: pw.LinearGradient(colors: [greenLight, green]),
                borderRadius: pw.BorderRadius.circular(24),
              ),
              child: pw.Text(
                'Download Ervadi App',
                style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _footer(pw.Context ctx) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 6),
        pw.Divider(thickness: 0.5, color: cardBorder),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'Ervadi Mawlid   -   Page ${ctx.pageNumber} of ${ctx.pagesCount}',
              style: pw.TextStyle(
                  fontSize: 8, color: PdfColor.fromInt(0xFF8A8A8A)),
            ),
            pw.UrlLink(
              destination: playStoreUrl,
              child: pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(colors: [greenLight, green]),
                  borderRadius: pw.BorderRadius.circular(20),
                ),
                child: pw.Text(
                  'Download Ervadi App',
                  style: pw.TextStyle(
                      fontSize: 8.5,
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Places a rendered text image in the PDF, scaled so the text is about
  /// [targetPt] points tall, clamped to [maxW] points wide, preserving aspect.
  static pw.Widget _pdfImage(
    _Img im, {
    required double targetPt,
    required double maxW,
    pw.Alignment align = pw.Alignment.center,
  }) {
    double dispW = im.w * (targetPt / im.renderPx);
    if (dispW > maxW) dispW = maxW;
    final double dispH = dispW * (im.h / im.w);
    return pw.Align(
      alignment: align,
      child: pw.Image(pw.MemoryImage(im.bytes), width: dispW, height: dispH),
    );
  }

  /// Renders text to a tightly-cropped transparent PNG using Flutter's text
  /// engine (correct shaping for Arabic and Malayalam). Returns null if empty.
  static Future<_Img?> _renderImage({
    required String text,
    required String? fontFamily,
    required double fontSize,
    required ui.Color color,
    ui.FontWeight fontWeight = ui.FontWeight.normal,
    ui.TextAlign align = ui.TextAlign.left,
    ui.TextDirection direction = ui.TextDirection.ltr,
    double maxWidth = 1400,
    double lineHeight = 1.4,
  }) async {
    if (text.trim().isEmpty) return null;
    try {
      const double pad = 8;
      ui.Paragraph build() {
        final b = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: align,
          textDirection: direction,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ))
          ..pushStyle(ui.TextStyle(
            color: color,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: lineHeight,
          ))
          ..addText(text);
        return b.build();
      }

      final measured = build()
        ..layout(ui.ParagraphConstraints(width: maxWidth));
      double tightW = measured.longestLine;
      if (tightW <= 0) tightW = measured.maxIntrinsicWidth;
      tightW = tightW.clamp(1.0, maxWidth);

      final paragraph = build()
        ..layout(ui.ParagraphConstraints(width: tightW + 1));

      final double w = tightW + pad * 2;
      final double h = paragraph.height + pad * 2;

      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder, ui.Rect.fromLTWH(0, 0, w, h));
      canvas.drawParagraph(paragraph, const ui.Offset(pad, pad));
      final picture = recorder.endRecording();
      final image = await picture.toImage(w.ceil(), h.ceil());
      final bd = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      picture.dispose();
      if (bd == null) return null;
      return _Img(
        bytes: bd.buffer.asUint8List(),
        w: w,
        h: h,
        renderPx: fontSize,
      );
    } catch (_) {
      return null;
    }
  }
}

class _Img {
  final Uint8List bytes;
  final double w;
  final double h;
  final double renderPx; // font size (px) used when rendering
  _Img({
    required this.bytes,
    required this.w,
    required this.h,
    required this.renderPx,
  });
}

/// The "Share as PDF" bottom sheet. Manages a per-button loading state so a
/// small spinner shows inside the tapped button while the PDF is generated.
class _ShareSheet extends StatefulWidget {
  final String title;
  final List<String> lines;
  final List<String> translations;
  final int index;

  const _ShareSheet({
    required this.title,
    required this.lines,
    required this.translations,
    required this.index,
  });

  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> {
  int? _loading; // id of the button currently generating; null when idle

  Future<void> _run(bool withTranslation, int id) async {
    if (_loading != null) return;
    setState(() => _loading = id);
    try {
      final bytes = await BaithPdf.buildPdf(
        title: widget.title,
        lines: widget.lines,
        translations: widget.translations,
        index: widget.index,
        withTranslation: withTranslation,
      );
      final suffix = withTranslation ? '_with_translation' : '';
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'ervadi_baith_${widget.index + 1}$suffix.pdf',
      );
      if (mounted) Navigator.of(context).pop();
    } catch (e, s) {
      debugPrint('BaithPdf error: $e\n$s');
      if (!mounted) return;
      setState(() => _loading = null);
      showDialog(
        context: context,
        builder: (dCtx) => AlertDialog(
          title: const Text('Could not create PDF'),
          content: SingleChildScrollView(child: SelectableText('$e\n\n$s')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dCtx).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTranslation =
        widget.translations.any((t) => t.trim().isNotEmpty);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF096637), Color(0xFF074425)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.picture_as_pdf_rounded,
                    color: Color(0xFFFFC107), size: 22),
                SizedBox(width: 8),
                Text('Share Baith as PDF',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            if (hasTranslation) ...[
              _button(
                id: 0,
                icon: Icons.translate_rounded,
                label: 'Download with Translation',
                filled: true,
                onTap: () => _run(true, 0),
              ),
              const SizedBox(height: 12),
              _button(
                id: 1,
                icon: Icons.text_fields_rounded,
                label: 'Download without Translation',
                filled: false,
                onTap: () => _run(false, 1),
              ),
            ] else
              _button(
                id: 2,
                icon: Icons.download_rounded,
                label: 'Download PDF',
                filled: true,
                onTap: () => _run(false, 2),
              ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    required int id,
    required IconData icon,
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    final bool isLoading = _loading == id;
    final bool anyLoading = _loading != null;
    final Color fg = filled ? const Color(0xFF074425) : Colors.white;
    return Opacity(
      opacity: anyLoading && !isLoading ? 0.5 : 1,
      child: Material(
        color: filled ? const Color(0xFFFFC107) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: anyLoading ? null : onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: filled
                  ? null
                  : Border.all(color: Colors.white54, width: 1.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(fg),
                        )
                      : Icon(icon, color: fg, size: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  isLoading ? 'Preparing…' : label,
                  style: TextStyle(
                      color: fg, fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
