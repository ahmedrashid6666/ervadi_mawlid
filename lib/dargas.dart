import 'package:ervadi/module/assets.dart';
import 'package:flutter/material.dart';
import 'module/open_url.dart';

class Darga {
  final String name;
  final String location;
  final String distance;
  final int graves;
  final String details;
  final List<String> graveNames;
  final List<String> images; // Gallery of local asset photos (swipeable)
  final String? imageAsset; // Legacy single asset (optional fallback)
  final String? imageUrl; // Legacy network image (optional fallback)
  final String? mapUrl;

  Darga({
    required this.name,
    required this.location,
    required this.distance,
    required this.graves,
    required this.details,
    required this.graveNames,
    this.images = const [],
    this.imageAsset,
    this.imageUrl,
    this.mapUrl,
  });
}

class NearestDargas extends StatelessWidget {
  final List<Darga> dargas = [
    Darga(
      name: 'ERVADI MAIN DARGA',
      location: 'Ervadi, Kilakarai',
      distance: '0 m',
      graves: 19,
      details: 'from ERVADI',
      graveNames: [
        'Qutub Sulthan Sayyed Ibrahim Badusha Shaheed (R)',
        'Sayyedath Fathima (R) - Mother',
        'Qutub Sayyed Abuthahir Shaheed (R) - Son',
        'Sayyedath Ali Fathima (R) - Wife',
        'Sayyedath Rabiya (R) - Sister',
        'Sayyedath Maryam Beevi (R)',
        'Fathimathu Suhra (R)',
        'Dulqarni Sikkandar (R)',
        'Doctor Jeelani Umma (R)',
        'Doctor Mehmooda Umma (R)',
        'Doctor Suhra Umma (R)',
        'Doctor Abdu-Razaq (R)',
        'Doctor Yusuf (R)',
        'Doctor Jafar Muhammed (R)',
        'Sayyed Shamsudheen (R)',
        'Sayyed Qamarudheen (R)',
        'Sayyed Nurudheen (R)',
        'Sayyed Zainul Aabideen (R)',
        'Sayyed Nalla Ibrahim (R)',
      ],
      images: const [
        'assets/images/dargas/maindarga_1.jpg',
        'assets/images/dargas/maindarga_2.jpg',
        'assets/images/dargas/maindarga_3.jpg',
        'assets/images/dargas/maindarga_4.jpg',
        'assets/images/dargas/maindarga_5.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Ervadi%20durgah/@9.20902768,78.71007701,17z?hl=en',
    ),
    Darga(
      name: 'KATTU PALLI DARGA',
      location: 'Another Location With Long Name',
      distance: '750 m',
      graves: 20,
      details: 'from ERVADI',
      graveNames: [
        'Vazeerul Akbar Sayyed Ameer Abbas (R)',
        'Abdul Hakeem Doctor (R)',
        'Sayyed Qadir Manthri (R)',
        'Sayyed Muhyudheen Manthri (R)',
        'Sayyedath Ruqiya Doctor (R)',
        'Doctor Jafar Sadique (R)',
        'Doctor Abdullah (R)',
        'Sayyed Ahmed (R)',
        'Sayyed Veerar Abdullah (R)',
        'Sayyed Veerar Siddique (R)',
        'Sayyed Chandanappeer (R)',
        'Sayyed Abdul Qadir Jeelani (R)',
        'Sayyed Abdul Qadir Samadani (R)',
        'Syyedath Balqees (R)',
        'Sayyedath Ummu Qulsum Beevi (R)',
        'Sayyed Ali (R)',
        'Batan Sahib (R)',
        'Meeran Sahib (R)',
        'Hamsathul Basheer (R)',
        'Sulaikha (R)',
      ],
      images: const [
        'assets/images/dargas/katupalli_1.jpg',
        'assets/images/dargas/katupalli_2.jpg',
        'assets/images/dargas/katupalli_3.jpg',
        'assets/images/dargas/katupalli_4.jpg',
        'assets/images/dargas/katupalli_5.jpg',
        'assets/images/dargas/katupalli_6.jpg',
        'assets/images/dargas/katupalli_7.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Ameer%20Abbas%20Manthiri%20dargah/@9.21275129,78.71415699,17z?hl=en',
    ),
    Darga(
      name: 'SARA BEEVI DARGA',
      location: 'Another Location With Long Name',
      distance: '600 m',
      graves: 8,
      details: 'from ERVADI',
      graveNames: [
        'Sayyedath Sara Beevi (R)',
        'Sayyedath Sabura (R)',
        'Sayyedath Zainab (R)',
        'Sayyed Ismayil (R)',
        'Sayyed Ishaq (R)',
        'Sayyed Husain (R)',
        'Sayyed Faqir (R)',
        'Sayyed Qasim (R)',
      ],
      images: const [
        'assets/images/dargas/sarabi_1.jpg',
        'assets/images/dargas/sarabi_2.jpg',
        'assets/images/dargas/sarabi_3.jpg',
        'assets/images/dargas/sarabi_4.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Sara%20Amma%20Safura%20Amma%20Palli%20Ervadi/@9.20902768,78.71007701,17z?hl=en',
    ),
    Darga(
      name: 'KANJIPPALLI DARGA',
      location: 'Another Location With Long Name',
      distance: '1.1 k/m',
      graves: 6,
      details: 'from ERVADI',
      graveNames: [
        'Iraq Rani Noorjahan Beevi (R)',
        'Sheykh Muhammed Swalih (R)',
        'Doctor Luqmanul Hakeem (R)',
        'Sayyedath Rilfan Beevi (R)',
        'Sayyed Vakeel Saheb (R)',
        'Meeran Sahib (R)',
      ],
      images: const [
        'assets/images/dargas/kanhipalli_1.jpg',
        'assets/images/dargas/kanhipalli_2.jpg',
        'assets/images/dargas/kanhipalli_3.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Kanjipalli%20Dharga/@9.20981879,78.72044807,17z?hl=en',
    ),
    Darga(
      name: 'KODIMARAM',
      location: 'Another Location With Long Name',
      distance: '2.1 k/m',
      graves: 0,
      details: 'from ERVADI',
      graveNames: [],
      images: const [
        'assets/images/dargas/kodimaram_1.jpg',
      ],
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/3/32/Erwadi_kodi.jpg',
      mapUrl:
          'https://maps.google.com/maps/search/Ervadi%20kodimaram/@9.1910144,78.71693461,17z?hl=en',
    ),
    Darga(
      name: 'ARAKKAS UMMA DARGA',
      location: 'Another Location With Long Name',
      distance: '2.8 k/m',
      graves: 3,
      details: 'from ERVADI',
      graveNames: [
        'Sayyedath Arakkas Umma (R)',
        'Muhammed Ansari (R)',
        'Abdul Qadir Nadha Valiyullah (R)',
      ],
      images: const [
        'assets/images/dargas/arakas_1.jpg',
        'assets/images/dargas/arakas_2.jpg',
        'assets/images/dargas/arakas_3.jpg',
        'assets/images/dargas/arakas_4.jpg',
        'assets/images/dargas/arakas_5.jpg',
        'assets/images/dargas/arakas_6.jpg',
        'assets/images/dargas/arakas_7.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Arakkas%20Umma%20Beevi/@9.21870054,78.72400134,17z?hl=en',
    ),
    Darga(
      name: 'MAYA-KULAM DARGA',
      location: 'Another Location With Long Name',
      distance: '8 k/m',
      graves: 2,
      details: 'from ERVADI',
      graveNames: [
        'Periya Nainar Uppa (R)',
        'Mariyam Umma (R)',
      ],
      images: const [
        'assets/images/dargas/mayakulam_1.jpg',
        'assets/images/dargas/mayakulam_2.jpg',
        'assets/images/dargas/mayakulam_3.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Mayakulam%20dharga%20Chevakilamai%20Dharga/@9.22768354,78.75342711,17z?hl=en',
    ),
    Darga(
      name: 'SADAQATHULLAH QAHIRI DARGA',
      location: 'Another Location With Long Name',
      distance: '12 k/m',
      graves: 1,
      details: 'from ERVADI',
      graveNames: [
        '1 Qutub Sadaqallah-al-Qahiri (R)',
      ],
      images: const [
        'assets/images/dargas/kilakara_1.jpg',
        'assets/images/dargas/kilakara_2.jpg',
        'assets/images/dargas/kilakara_3.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Keelakkarai%20Sadaqathullah%20Darga%20and%20Jinn%20Masjid/@9.23122954,78.78447091,17z?hl=en',
    ),
    Darga(
      name: 'VALINOKKAM DARGA',
      location: 'Another Location With Long Name',
      distance: '25 k/m',
      graves: 7,
      details: 'from ERVADI',
      graveNames: [
        'Sayyedath Khadeejath-ul-Qubra (R)',
        'Noor Muhammed (R)',
        'Beer Muhammed (R)',
        'Muhammed Sulaiman (R)',
        'Maryam Beevi (R)',
        'Abbas (R)',
        'Abdullah (R)',
      ],
      images: const [
        'assets/images/dargas/valinokam_1.jpg',
        'assets/images/dargas/valinokam_2.jpg',
        'assets/images/dargas/valinokam_3.jpg',
        'assets/images/dargas/valinokam_4.jpg',
        'assets/images/dargas/valinokam_5.jpg',
        'assets/images/dargas/valinokam_6.jpg',
        'assets/images/dargas/valinokam_7.jpg',
      ],
      mapUrl:
          'https://maps.google.com/maps/search/Valinokkam%20Dargah/@9.167,78.650,15z?hl=en',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text(
          'Nearest Dargas',
          style: (theme.textTheme.titleMedium ?? TextStyle()).copyWith(
            color: theme.brightness == Brightness.dark ? white : white,
          ),
        ),
        backgroundColor: theme.primaryColor,
        iconTheme: IconThemeData(color: theme.hintColor),
        elevation: 2,
        centerTitle: true,
        shadowColor: theme.brightness == Brightness.dark
            ? Colors.black.withOpacity(0.5)
            : Colors.grey.withOpacity(0.3),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.hintColor.withOpacity(0.3),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
          itemCount: dargas.length,
          itemBuilder: (context, index) {
            final darga = dargas[index];

            return Container(
              margin: EdgeInsets.only(bottom: screenWidth * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: isDark ? theme.primaryColor : white,
                elevation: 0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    backgroundColor: isDark ? theme.primaryColor : white,
                    collapsedBackgroundColor:
                        isDark ? theme.primaryColor : white,
                    iconColor: isDark ? amber : theme.colorScheme.primary,
                    collapsedIconColor:
                        isDark ? amber : theme.colorScheme.primary,
                    tilePadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenWidth * 0.015,
                    ),
                    leading: Container(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.18,
                          maxHeight: screenWidth * 0.18,
                          minWidth: screenWidth * 0.15,
                          minHeight: screenWidth * 0.15,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark
                                ? [amber.withOpacity(0.8), amber]
                                : [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.secondary
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? amber.withOpacity(0.3)
                                : theme.colorScheme.primary.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? amber.withOpacity(0.3)
                                  : theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Container(
                          width:
                              45, // Much narrower width - just enough for content
                          height: 70, // Reduce height slightly
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10), // Slightly smaller radius
                            color: isDark
                                ? Colors.white
                                : Color(0xFF1B5E20), // Dark green background
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0,
                                vertical: 6.0), // Minimal horizontal padding
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    child: Text(
                                      darga.graves.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: isDark ? blk : white,
                                        fontFamily: 'lpmq',
                                        letterSpacing: 0.3,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  flex: 2,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Known\nGraves',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: isDark
                                            ? blk.withOpacity(0.9)
                                            : white.withOpacity(0.95),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'lpmq',
                                        letterSpacing: 0.1,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    title: LayoutBuilder(
                      builder: (context, constraints) {
                        return Text(
                          darga.name,
                          style: (theme.textTheme.titleMedium ?? TextStyle()).copyWith(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.bold,
                            color: isDark ? white : theme.colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        );
                      },
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: isDark ? amber : theme.colorScheme.primary,
                          size: screenWidth * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Expanded(
                          child: Text(
                            '${darga.distance} - ${darga.details}',
                            style: (theme.textTheme.titleSmall ?? TextStyle()).copyWith(
                              fontSize: screenWidth * 0.03,
                              color: isDark
                                  ? ltWhite
                                  : theme.colorScheme.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          screenWidth * 0.01,
                          0,
                          screenWidth * 0.01,
                          screenWidth * 0.01,
                        ),
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color:
                              isDark ? brown.withOpacity(0.3) : theme.hintColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark
                                ? amber.withOpacity(0.2)
                                : theme.colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Open location in Google Maps
                            if (darga.mapUrl != null) ...[
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => launch(darga.mapUrl!),
                                  icon: Icon(
                                    Icons.map_rounded,
                                    size: screenWidth * 0.05,
                                    color: white,
                                  ),
                                  label: Text(
                                    'View on Map',
                                    style: (theme.textTheme.titleSmall ??
                                            TextStyle())
                                        .copyWith(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isDark
                                        ? amber.withOpacity(0.85)
                                        : theme.colorScheme.primary,
                                    padding: EdgeInsets.symmetric(
                                      vertical: screenWidth * 0.03,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.04),
                            ],
                            // Enhanced graves list
                            ...List.generate(darga.graveNames.length, (i) {
                              final name = darga.graveNames[i];
                              final isHighlight = name.contains('Shaheed') ||
                                  name.contains('Mother') ||
                                  name.contains('Wife') ||
                                  name.contains('Son') ||
                                  name.contains('Sister');
                              return Container(
                                margin:
                                    EdgeInsets.only(bottom: screenWidth * 0.03),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? theme.primaryColor.withOpacity(0.7)
                                      : white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isHighlight
                                        ? (isDark ? amber : Colors.red.shade300)
                                        : (isDark
                                            ? amber.withOpacity(0.3)
                                            : theme.colorScheme.primary
                                                .withOpacity(0.3)),
                                    width: isHighlight ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isDark
                                          ? Colors.black.withOpacity(0.3)
                                          : Colors.grey.withOpacity(0.15),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.12,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: isHighlight
                                                ? (isDark
                                                    ? [
                                                        amber,
                                                        amber.withOpacity(0.7)
                                                      ]
                                                    : [
                                                        Colors.red.shade400,
                                                        Colors.red.shade600
                                                      ])
                                                : (isDark
                                                    ? [
                                                        amber.withOpacity(0.8),
                                                        amber.withOpacity(0.6)
                                                      ]
                                                    : [
                                                        theme.colorScheme
                                                            .primary,
                                                        theme.colorScheme
                                                            .secondary
                                                      ]),
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: screenWidth * 0.03,
                                            ),
                                            child: Text(
                                              '${i + 1}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03,
                                                color: isDark ? blk : white,
                                                fontFamily: 'lpmq',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.02,
                                            vertical: screenWidth * 0.02,
                                          ),
                                          child: Text(
                                            name,
                                            style: (theme.textTheme.titleSmall ?? TextStyle())
                                                .copyWith(
                                              color: isHighlight
                                                  ? (isDark
                                                      ? amber
                                                      : Colors.red.shade700)
                                                  : (isDark
                                                      ? white
                                                      : theme
                                                          .colorScheme.primary),
                                              fontWeight: isHighlight
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      if (isHighlight)
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.03,
                                          ),
                                          child: Icon(
                                            Icons.star_rounded,
                                            color: isDark
                                                ? amber
                                                : Colors.red.shade600,
                                            size: screenWidth * 0.05,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            SizedBox(height: screenWidth * 0.05),
                            // Photo gallery (swipeable) — real photos bundled from the app
                            _DargaGallery(darga: darga),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Swipeable photo gallery for a single darga.
/// Shows all bundled photos in a horizontal PageView with page-dot indicators
/// and a "current / total" counter badge. Falls back gracefully to the legacy
/// [Darga.imageUrl] / [Darga.imageAsset] fields, and finally to a placeholder.
class _DargaGallery extends StatefulWidget {
  final Darga darga;
  const _DargaGallery({Key? key, required this.darga}) : super(key: key);

  @override
  State<_DargaGallery> createState() => _DargaGalleryState();
}

class _DargaGalleryState extends State<_DargaGallery> {
  final PageController _controller = PageController();
  int _current = 0;
  bool _precached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) return;
    _precached = true;
    // Warm the image cache so the first frame and swipes render instantly.
    for (final p in _images) {
      if (!_isNetwork(p)) {
        precacheImage(ResizeImage(AssetImage(p), width: 720), context);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Resolve which list of images to show (new gallery first, then legacy fields).
  List<String> get _images {
    if (widget.darga.images.isNotEmpty) return widget.darga.images;
    if (widget.darga.imageUrl != null) return [widget.darga.imageUrl!];
    if (widget.darga.imageAsset != null) return [widget.darga.imageAsset!];
    return const [];
  }

  bool _isNetwork(String path) => path.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final darga = widget.darga;
    final images = _images;
    final imgHeight = screenWidth * 0.6;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? amber.withOpacity(0.3)
              : theme.colorScheme.primary.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with camera icon, name/distance, and a photo counter.
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: isDark
                  ? theme.primaryColor.withOpacity(0.8)
                  : theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.photo_camera_rounded,
                  color: isDark ? amber : theme.colorScheme.primary,
                  size: screenWidth * 0.05,
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Text(
                    '${darga.name} (${darga.distance})',
                    style: (theme.textTheme.titleSmall ?? const TextStyle())
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                      color: isDark ? white : theme.colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (images.length > 1)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenWidth * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? amber.withOpacity(0.9)
                          : theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.collections_rounded,
                          size: screenWidth * 0.035,
                          color: isDark ? blk : white,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          '${_current + 1}/${images.length}',
                          style: TextStyle(
                            color: isDark ? blk : white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Swipeable image carousel.
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: images.isEmpty
                ? _placeholder(context, isDark, imgHeight)
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: imgHeight,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: _controller,
                          itemCount: images.length,
                          onPageChanged: (i) => setState(() => _current = i),
                          itemBuilder: (context, i) {
                            final path = images[i];
                            if (_isNetwork(path)) {
                              return Image.network(
                                path,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: imgHeight,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    height: imgHeight,
                                    color: isDark
                                        ? theme.primaryColor.withOpacity(0.5)
                                        : Colors.grey.shade200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: isDark
                                            ? amber
                                            : theme.colorScheme.primary,
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    _placeholder(context, isDark, imgHeight),
                              );
                            }
                            return Image.asset(
                              path,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: imgHeight,
                              cacheWidth: 720,
                              gaplessPlayback: true,
                              filterQuality: FilterQuality.low,
                              errorBuilder: (context, error, stackTrace) =>
                                  _placeholder(context, isDark, imgHeight),
                            );
                          },
                        ),
                      ),
                      // Page-dot indicators over a soft gradient scrim.
                      if (images.length > 1)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.025,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.45),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (i) {
                              final active = i == _current;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                width: active ? 18 : 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: active
                                      ? (isDark ? amber : white)
                                      : white.withOpacity(0.55),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // Fallback shown when an image is missing or fails to load.
  Widget _placeholder(BuildContext context, bool isDark, double height) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: double.infinity,
      color: isDark ? theme.primaryColor.withOpacity(0.5) : Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          size: screenWidth * 0.12,
          color: isDark ? amber : theme.colorScheme.primary,
        ),
      ),
    );
  }
}
