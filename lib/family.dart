import 'package:ervadi/module/assets.dart';
import 'package:flutter/material.dart';

class ErvadiShaheeedFamilyTree extends StatefulWidget {
  const ErvadiShaheeedFamilyTree({Key? key}) : super(key: key);

  @override
  State<ErvadiShaheeedFamilyTree> createState() =>
      _ErvadiShaheeedFamilyTreeState();
}

class _ErvadiShaheeedFamilyTreeState extends State<ErvadiShaheeedFamilyTree>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Family lineage data with corrected Malayalam
  final List<Map<String, dynamic>> familyLineage = [
    {
      'name': 'سيدتنا فاطمة',
      'title': 'رضي الله عنها',
      'malayalam': 'സയ്യിദത്ത് ഫാത്തിമ (റ)',
      'isSpecial': false,
      'generation': 2,
    },
    {
      'name': 'سيدنا حسين',
      'title': 'رضي الله عنه',
      'malayalam': 'ഇമാം ഹുസൈൻ (റ)',
      'isSpecial': false,
      'generation': 3,
    },
    {
      'name': 'سيدنا زين العابدين',
      'title': 'رضي الله عنه',
      'malayalam': 'സൈനുൽ ആബിദീൻ (റ)',
      'isSpecial': false,
      'generation': 4,
    },
    {
      'name': 'سيدنا محمد الباقر',
      'title': 'رضي الله عنه',
      'malayalam': 'മുഹമ്മദ് ബാഖിർ (റ)',
      'isSpecial': false,
      'generation': 5,
    },
    {
      'name': 'سيدنا جعفر الصادق',
      'title': 'رضي الله عنه',
      'malayalam': 'ജഅ്ഫർ സാദിഖ് (റ)',
      'isSpecial': false,
      'generation': 6,
    },
    {
      'name': 'سيدنا محمد',
      'title': 'رضي الله عنه',
      'malayalam': 'മുഹമ്മദ് (റ)',
      'isSpecial': false,
      'generation': 7,
    },
    {
      'name': 'سيدنا سعيد جلال الدين',
      'title': 'رضي الله عنه',
      'malayalam': 'സഈദ് ജലാലുദ്ദീൻ (റ)',
      'isSpecial': false,
      'generation': 8,
    },
    {
      'name': 'سيدنا محمد الكمال',
      'title': 'رضي الله عنه',
      'malayalam': 'മുഹമ്മദ് കമാൽ (റ)',
      'isSpecial': false,
      'generation': 9,
    },
    {
      'name': 'سيدنا داود',
      'title': 'رضي الله عنه',
      'malayalam': 'ദാവൂദ് (റ)',
      'isSpecial': false,
      'generation': 10,
    },
    {
      'name': 'سيدنا جمال الكريم',
      'title': 'رضي الله عنه',
      'malayalam': 'ജമാൽ കരീം (റ)',
      'isSpecial': false,
      'generation': 11,
    },
    {
      'name': 'سيدنا ابو الحسين',
      'title': 'رضي الله عنه',
      'malayalam': 'അബുൽ ഹുസൈൻ (റ)',
      'isSpecial': false,
      'generation': 12,
    },
    {
      'name': 'سيدنا اسماعيل الكريم',
      'title': 'رضي الله عنه',
      'malayalam': 'ഇസ്മാഈൽ കരീം (റ)',
      'isSpecial': false,
      'generation': 13,
    },
    {
      'name': 'سيدنا محمد النضير',
      'title': 'رضي الله عنه',
      'malayalam': 'മുഹമ്മദ് നദീർ (റ)',
      'isSpecial': false,
      'generation': 14,
    },
    {
      'name': 'سيدنا ابو يوسف الجمال',
      'title': 'رضي الله عنه',
      'malayalam': 'അബൂ യൂസുഫ് ജമാൽ (റ)',
      'isSpecial': false,
      'generation': 15,
    },
    {
      'name': 'سيدنا عبد الغفور',
      'title': 'رضي الله عنه',
      'malayalam': 'അബ്ദുൽ ഗഫൂർ (റ)',
      'isSpecial': false,
      'generation': 16,
    },
    {
      'name': 'سيدنا احمد',
      'title': 'رضي الله عنه',
      'malayalam': 'അഹ്മദ് (റ)',
      'isSpecial': false,
      'generation': 17,
    },
    {
      'name': 'قطب السلطان سيد ابراهيم بادشاه',
      'title': 'رضي الله عنه',
      'malayalam': 'ഖുത്ബുസ് സുൽത്താൻ സയ്യിദ് ഇബ്രാഹീം ബാദ്ശാഹ് (റ)',
      'isSpecial': true,
      'generation': 18,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text(
              'Family Lineage',
              style: (theme.textTheme.titleMedium ?? TextStyle()).copyWith(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ervadi Shaheed',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.white70,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [Colors.brown.shade800, Colors.brown.shade600]
                  : [theme.primaryColor, theme.primaryColorDark],
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [Colors.brown.shade900, Colors.brown.shade800]
                  : [const Color(0xFFE7E7E7), const Color(0xFFD0D0D0)],
            ),
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: familyLineage.length,
              itemBuilder: (context, index) {
                final person = familyLineage[index];
                final isLast = index == familyLineage.length - 1;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Stack(
                    children: [
                      // Connection line
                      if (!isLast)
                        Positioned(
                          left: 24,
                          top: 85,
                          child: Container(
                            width: 2,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDark
                                    ? [
                                        Colors.amber.shade300,
                                        Colors.amber.shade600
                                      ]
                                    : [
                                        theme.primaryColor,
                                        theme.primaryColorDark
                                      ],
                              ),
                            ),
                          ),
                        ),

                      // Person card
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Generation indicator
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: person['isSpecial']
                                    ? [
                                        Colors.amber.shade300,
                                        Colors.amber.shade600
                                      ]
                                    : isDark
                                        ? [
                                            Colors.brown.shade400,
                                            Colors.brown.shade600
                                          ]
                                        : [
                                            theme.primaryColor.withOpacity(0.7),
                                            theme.primaryColor
                                          ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: person['isSpecial']
                                      ? Colors.amber.withOpacity(0.3)
                                      : theme.primaryColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: person['isSpecial'] ? 18 : 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Person details card - Fixed overflow issue
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.brown.shade700.withOpacity(0.8)
                                    : Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                                border: person['isSpecial']
                                    ? Border.all(color: Colors.amber, width: 2)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Arabic name
                                  Text(
                                    person['name'],
                                    style: TextStyle(
                                      fontSize: person['isSpecial'] ? 18 : 16,
                                      fontWeight: person['isSpecial']
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      color: person['isSpecial']
                                          ? Colors.amber.shade700
                                          : isDark
                                              ? Colors.white
                                              : theme.primaryColor,
                                      fontFamily: 'Arabic',
                                      height: 1.3,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),

                                  const SizedBox(height: 4),

                                  // Title/blessing
                                  Text(
                                    person['title'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.grey.shade600,
                                      fontFamily: 'Arabic',
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),

                                  const SizedBox(height: 8),

                                  // Malayalam translation - Fixed container
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.brown.shade600
                                                .withOpacity(0.5)
                                            : theme.primaryColor
                                                .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isDark
                                              ? Colors.brown.shade500
                                              : theme.primaryColor
                                                  .withOpacity(0.3),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        person['malayalam'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? Colors.white
                                              : theme.primaryColor,
                                          fontFamily: 'lpmq',
                                          height: 1.1,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),

      // Floating action button for additional info
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber.shade700,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'About This Lineage',
                      style: (theme.textTheme.titleMedium ?? TextStyle()).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'This blessed lineage traces back from Qutb Sultan Syed Ibrahim Badshah (رضي الله عنه) of Ervadi to our beloved Prophet Muhammad (صلى الله عليه وسلم) through Sayyida Fatima (رضي الله عنها) and Imam Hussein (رضي الله عنه).',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.amber.shade200,
                          ),
                        ),
                        child: Text(
                          'This represents 17 generations of blessed souls who carried forward the light of Islam and spiritual guidance.',
                          style: TextStyle(
                            color: Colors.amber.shade800,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.amber.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.info_outline),
        label: const Text('About'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
        elevation: 4,
      ),
    );
  }
}
