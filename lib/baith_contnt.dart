import 'dart:async';
import 'package:ervadi/module/translations.dart';
import 'package:flutter/material.dart';
import 'package:ervadi/tab_bar_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'module/assets.dart';

class BaithContnt extends StatefulWidget {
  bool isDarkTheme;
  bool transbutton;
  List<String> baithTxt;
  List<String> baithTxtTrans;
  final String selectedLanguage;
  final ValueNotifier<bool> showTranslationNotifier;

  final int baithIndex;
  Function(double) onChanged;
  BaithContnt(
      {Key? key,
      this.isDarkTheme = true,
      required this.baithTxt,
      required this.baithTxtTrans,
      required this.selectedLanguage,
      required this.transbutton,
      required this.showTranslationNotifier,
      required this.baithIndex,
      required this.onChanged})
      : super(key: key);

  @override
  State<BaithContnt> createState() => _BaithContntState();
}

class _BaithContntState extends State<BaithContnt> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  Timer? _resumeTimer;
  double _scrollSpeed = 0.0; // pixels per tick; 0 = stopped
  bool _userInteracting = false; // true while the user is dragging manually

  @override
  void initState() {
    _loadSpeed();
    _restoreScrollPosition();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      tabsBarPage.saveScrollPosition(
          widget.baithIndex, _scrollController.offset);
    }
  }

  Future<void> _restoreScrollPosition() async {
    final offset = await tabsBarPage.loadScrollPosition(widget.baithIndex);
    if (offset > 0 && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(offset);
        }
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Pauses auto-scroll while the user drags, and resumes it after they let go.
  bool _handleUserScroll(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      // User physically grabbed the list.
      _userInteracting = true;
      _resumeTimer?.cancel();
    } else if (notification is ScrollEndNotification && _userInteracting) {
      // User released; resume after a short pause (also lets any fling settle).
      _scheduleResume();
    }
    return false;
  }

  void _scheduleResume() {
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      // If the list is still coasting from a fling, wait a bit more.
      if (_scrollController.hasClients &&
          _scrollController.position.isScrollingNotifier.value) {
        _scheduleResume();
        return;
      }
      _userInteracting = false;
      if (_scrollSpeed > 0) _startAutoScroll();
    });
  }

  Future<void> _loadSpeed() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSpeed = prefs.getDouble('scroll_speed') ?? 0.0;
    setState(() => _scrollSpeed = savedSpeed);

    if (savedSpeed > 0) {
      _startAutoScroll();
    }
  }

  Future<void> _saveSpeed(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('scroll_speed', value);
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_scrollSpeed <= 0) return;
    // ~60fps ticks with tiny jumpTo steps: smooth, and never fights a manual
    // drag (jumpTo has no running animation to collide with the gesture).
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 16), (t) {
      if (!_scrollController.hasClients) return;
      // Don't fight the user while they're dragging manually or flinging.
      if (_userInteracting) return;
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      if (current >= max) {
        t.cancel();
        return;
      }
      final step = _scrollSpeed * 0.32; // pixels per frame; matches old speed
      _scrollController.jumpTo((current + step).clamp(0.0, max));
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  // Safe translation lookup: prevents RangeError when the selected
  // language list is shorter than the baith text (some baiths have more
  // lines than there are translations). Returns '' when out of range.
  String _trans(int index) {
    // Only the first baith (Muraadi) has translations; the rest have none,
    // so we never show another baith's translation, and blanks are hidden.
    if (widget.baithIndex != 0) return '';
    final list = TranslationData.getTranslation(widget.selectedLanguage);
    if (index < 0 || index >= list.length) return '';
    final t = list[index];
    return t.trim().isEmpty ? '' : t;
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSize>(context);

    // Each card holds one couplet: the first hemistich sits to the right,
    // the second to the left — one right/left pair = one box.
    final int coupletCount = (widget.baithTxt.length / 2).ceil();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Row(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleUserScroll,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 6, bottom: 75),
                physics: const BouncingScrollPhysics(),
                itemCount: coupletCount,
                itemBuilder: (context, group) {
                  final int i = group * 2;
                  final bool highlight = group == 0; // opening refrain couplet
                  final String lineA = widget.baithTxt[i];
                  final String? lineB = (i + 1 < widget.baithTxt.length)
                      ? widget.baithTxt[i + 1]
                      : null;

                  final Color textColor = highlight
                      ? white
                      : Theme.of(context).primaryColorDark;

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    clipBehavior: Clip.antiAlias,
                    decoration: highlight
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: white.withOpacity(0.15),
                              width: 1,
                            ),
                          )
                        : BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _hemistich(lineA,
                              alignEnd: true,
                              color: textColor,
                              fontSize: fontSize.fontSize),
                          _translation(i,
                              alignEnd: true, highlight: highlight),
                          if (lineB != null) ...[
                            const SizedBox(height: 10),
                            _hemistich(lineB,
                                alignEnd: false,
                                color: textColor,
                                fontSize: fontSize.fontSize),
                            _translation(i + 1,
                                alignEnd: false, highlight: highlight),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Right-side vertical slider with fixed width
          Container(
            width: 40, // adjust width as needed
            color: Colors.transparent, // optional
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_upward,
                  size: 14,
                  color: white,
                ),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _scrollSpeed,
                      min: 0,
                      max: 12,
                      divisions: 24,
                      onChanged: (val) {
                        setState(() => _scrollSpeed = val);
                        _saveSpeed(val);
                        if (val > 0) {
                          _startAutoScroll();
                        } else {
                          _stopAutoScroll();
                        }
                        try {
                          widget.onChanged(val);
                        } catch (_) {}
                      },
                    ),
                  ),
                ),
                const Icon(Icons.arrow_downward, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // One hemistich line, aligned right (first half) or left (second half).
  Widget _hemistich(String text,
      {required bool alignEnd,
      required Color color,
      required double fontSize}) {
    return Align(
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        text,
        textAlign: alignEnd ? TextAlign.right : TextAlign.left,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'Amiri',
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }

  // Translation for a given line, shown only when the toggle is ON and a
  // translation exists. White inside the green (highlighted) box.
  Widget _translation(int index,
      {required bool alignEnd, required bool highlight}) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.showTranslationNotifier,
      builder: (context, showTranslation, child) {
        final t = _trans(index);
        if (!showTranslation || t.isEmpty) return const SizedBox();
        return Align(
          alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              t,
              textDirection: TextDirection.ltr,
              textAlign: alignEnd ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: highlight
                    ? Colors.white70
                    : Theme.of(context).primaryColorDark,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
