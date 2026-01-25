// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:ui';

import 'package:ervadi/dargas.dart';
import 'package:ervadi/expandablefab.dart';
import 'package:ervadi/module/assets.dart';
import 'package:ervadi/tab_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ervadi/module/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about.dart';
import 'module/open_url.dart';
import 'package:share_plus/share_plus.dart';

// class HomePage extends StatefulWidget {
//   const HomePage();
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  brightness: Brightness.dark,
);

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> showTranslationNotifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme =
        themeProvider.selectedTheme.brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawerEdgeDragWidth: 0,
      key: _scaffoldKey,
      endDrawer: Container(
        width: 270,
        child: Drawer(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 240,
                child: DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Center(
                          // child: Text(
                          //   'يروآدي مولد',
                          //   style: TextStyle(
                          //       color: ltWhite,
                          //       fontSize: 25,
                          //       fontFamily: 'lpmq'),
                          // ),
                          child: SvgPicture.asset(
                            ervadi,
                            height: 50,
                            color: white,
                          ),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Divider(
                  height: 6,
                  thickness: 0.2,
                  color: white,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.input,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Share App',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 18,
                      fontFamily: 'lpmq',
                      fontWeight: FontWeight.w800),
                ),
                onTap: () => {
                  Share.share(
                    '*Ervadi Mawlid*: https://play.google.com/store/apps/details?id=in.mawlid.ervadi',
                  ),
                  Get.back()
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.system_update,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Check For Update',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 18,
                      fontFamily: 'lpmq',
                      fontWeight: FontWeight.w800),
                ),
                onTap: () => {
                  launch(
                      'https://play.google.com/store/apps/details?id=in.mawlid.ervadi'),
                  Get.back()
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.message,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'Feedback',
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 18,
                        fontFamily: 'lpmq',
                        fontWeight: FontWeight.w800),
                  ),
                  onTap: () {
                    launch(
                        'https://wa.me/+918075703855/?text=Ervadi%20Mawlid%20App%20feedback%20');
                    Get.back();
                  }),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 18,
                      fontFamily: 'lpmq',
                      fontWeight: FontWeight.w800),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => AboutPage());
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                automaticallyImplyLeading: false,
                expandedHeight: 250,
                floating: true,
                pinned: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10, bottom: 10, top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .swapTheme();
                      },
                      child: Icon(
                        Icons.brightness_6,
                        color: Colors.white,
                        size: 25,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: CircleBorder(),
                        backgroundColor: Colors.black12,
                      ),
                    ),
                  ),
                ],
                leading: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 5,
                    ),
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(11),
                          child: SvgPicture.asset(
                            menu,
                            height: 50,
                            width: 50,
                            color: white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                          // Button color
                          backgroundColor: Colors.black12,
                          // Splash color
                        ),
                      ),
                    )),
                flexibleSpace: FlexibleSpaceBar(
                  // Make sure title is centered horizontally
                  titlePadding: EdgeInsets.only(
                      bottom: 0, right: 48), // Adjust this if needed
                  title: SvgPicture.asset(
                    ervadi,
                    height: 40,
                    width: 40,
                    color: Colors.amberAccent,
                  ),

                  background: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      SvgPicture.asset(
                        ervadi,
                        color: Colors.amberAccent,
                        fit: BoxFit.contain,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, 0.5),
                            end: Alignment.center,
                            colors: <Color>[
                              Color(0x60000000),
                              Color(0x00000000)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Scrollable content
              SliverList(
                delegate: SliverChildListDelegate([
                  Detailed1(context, isDarkTheme, 'مُرَادِي بَيت', '١', () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 0,
                      ),
                    );
                  }),
                  Detailed1(context, isDarkTheme, 'أَيَا مَحْبُوب', '٢', () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 1,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Detailed1(
                      context, isDarkTheme, 'يٰا وَلِي سَلَامْ عَلَيْكُم', '٣',
                      () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 2,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Detailed1(context, isDarkTheme,
                      'أَيٰا سٰامِي لَدَى الْقٰادِرْ', '٤', () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 3,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Detailed1(context, isDarkTheme, 'عَبَّاسْ مَنْترِي بَيت', '٥',
                      () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 4,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Detailed1(context, isDarkTheme, 'صَلٰوةٌ وَتَسْلِيمٌ', '٦',
                      () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 5,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Detailed1(context, isDarkTheme, 'دُعــــآء', '٧', () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 6,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Detailed1(context, isDarkTheme, 'يَا أَكْرَمَ الْخَلْقِ', '٨',
                      () {
                    Get.to(
                      () => tabsBarPage(
                        showTranslationNotifier: showTranslationNotifier,
                        isDarkTheme: isDarkTheme,
                        selectedpage: 7,
                      ),
                      transition: Transition.fade,
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Detailed1(context, isDarkTheme,
                        'وَاهًا لِلْقُبَّةِ الْخَضْرَاءِ', '٩', () {
                      Get.to(
                        () => tabsBarPage(
                          showTranslationNotifier: showTranslationNotifier,
                          isDarkTheme: isDarkTheme,
                          selectedpage: 8,
                        ),
                        transition: Transition.fade,
                      );
                    }),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFAB(
        isDarkTheme: isDarkTheme,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Container Detailed1(
  BuildContext context,
  bool isDarkTheme,
  String buttonar,
  String no,
  void Function() buttonAction,
) {
  final theme = Theme.of(context);
  final screenWidth = MediaQuery.of(context).size.width;

  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.03,
      vertical: screenWidth * 0.02,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: isDarkTheme
              ? Colors.black.withOpacity(0.4)
              : Colors.grey.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Material(
      color: isDarkTheme ? theme.primaryColor : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: buttonAction,
        borderRadius: BorderRadius.circular(16),
        splashColor: isDarkTheme
            ? Colors.amber.withOpacity(0.2)
            : theme.colorScheme.primary.withOpacity(0.2),
        highlightColor: isDarkTheme
            ? Colors.amber.withOpacity(0.1)
            : theme.colorScheme.primary.withOpacity(0.1),
        child: Container(
          height: screenWidth * 0.18,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDarkTheme
                  ? Colors.amber.withOpacity(0.3)
                  : theme.colorScheme.primary.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text Section
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.02),
                    child: Text(
                      buttonar,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: (theme.textTheme.titleMedium ?? TextStyle()).copyWith(
                        fontSize: screenWidth * 0.058,
                        color: isDarkTheme
                            ? Colors.white
                            : theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Number Section
                Container(
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDarkTheme
                          ? [Colors.amber.withOpacity(0.8), Colors.amber]
                          : [
                              theme.colorScheme.primary,
                              theme.colorScheme.secondary,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkTheme
                          ? Colors.amber.withOpacity(0.3)
                          : theme.colorScheme.primary.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkTheme
                            ? Colors.amber.withOpacity(0.3)
                            : theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background SVG (if needed)
                      if (nmbrborder.isNotEmpty)
                        SvgPicture.asset(
                          nmbrborder,
                          width: screenWidth * 0.09,
                          color: isDarkTheme
                              ? Colors.black.withOpacity(0.2)
                              : Colors.white.withOpacity(0.3),
                          fit: BoxFit.fitHeight,
                        ),
                      // Number Text
                      Text(
                        no,
                        style: TextStyle(
                          fontSize: screenWidth * 0.058,
                          fontWeight: FontWeight.w900,
                          color: isDarkTheme ? Colors.black : Colors.white,
                          fontFamily: 'lpmq',
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
