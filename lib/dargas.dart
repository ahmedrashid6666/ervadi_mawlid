import 'package:ervadi/module/assets.dart';
import 'package:flutter/material.dart';

class Darga {
  final String name;
  final String location;
  final String distance;
  final int graves;
  final String details;
  final List<String> graveNames;
  final String imageAsset;

  Darga({
    required this.name,
    required this.location,
    required this.distance,
    required this.graves,
    required this.details,
    required this.graveNames,
    required this.imageAsset,
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
      imageAsset: 'assets/images/ervadi_main.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
    ),
    Darga(
      name: 'KODIMARAM',
      location: 'Another Location With Long Name',
      distance: '2.1 k/m',
      graves: 0,
      details: 'from ERVADI',
      graveNames: [],
      imageAsset: 'assets/images/another_darga.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
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
      imageAsset: 'assets/images/another_darga.jpg',
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
          style: theme.textTheme.titleMedium?.copyWith(
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
                borderRadius: BorderRadius.circular(25),
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
                  borderRadius: BorderRadius.circular(25),
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
                          style: theme.textTheme.titleMedium?.copyWith(
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
                            style: theme.textTheme.titleSmall?.copyWith(
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
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
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
                            // Enhanced image section
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark
                                      ? amber.withOpacity(0.3)
                                      : theme.colorScheme.primary
                                          .withOpacity(0.3),
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
                                  Container(
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? theme.primaryColor.withOpacity(0.8)
                                          : theme.colorScheme.primary
                                              .withOpacity(0.1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.photo_camera_rounded,
                                          color: isDark
                                              ? amber
                                              : theme.colorScheme.primary,
                                          size: screenWidth * 0.05,
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Expanded(
                                          child: Text(
                                            '${darga.name} (${darga.distance})',
                                            style: theme.textTheme.titleSmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth * 0.035,
                                              color: isDark
                                                  ? white
                                                  : theme.colorScheme.primary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14),
                                    ),
                                    child: Image.asset(
                                      darga.imageAsset,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: screenWidth * 0.5,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: screenWidth * 0.5,
                                          color: isDark
                                              ? theme.primaryColor
                                                  .withOpacity(0.5)
                                              : Colors.grey.shade200,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .image_not_supported_rounded,
                                                  size: screenWidth * 0.12,
                                                  color: isDark
                                                      ? amber
                                                      : theme
                                                          .colorScheme.primary,
                                                ),
                                                SizedBox(
                                                    height: screenWidth * 0.02),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
