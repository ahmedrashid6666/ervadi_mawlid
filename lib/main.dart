import 'package:ervadi/module/assets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ervadi/tab_bar_page.dart';
import 'package:ervadi/module/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'package:upgrader/upgrader.dart'; // ✅ Added

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FontSize fontSizeProvider = FontSize();
  await fontSizeProvider.loadFontSize();
  final prefs = await SharedPreferences.getInstance();
  final isDarkTheme = prefs.getBool("darkTheme") ?? false;

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      child: const MyApp(),
      create: (BuildContext context) {
        return ThemeProvider(isDarkTheme);
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FontSize(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: PointerDeviceKind.values.toSet(),
            ),
            title: 'Ervadi Mawlid',
            theme: value.getTheme(),
            home: UpgradeAlert(
              showIgnore: false,
              showLater: false,
              shouldPopScope: () => false, // ❗ Prevent closing without update
              child: MainScreen(),
            ),
          );
        },
      ),
    );
  }
}


//flutter build appbundle --target-platform android-arm,android-arm64,android-x64 --no-sound-null-safety
// flutter run --no-sound-null-safety
//flutter build web --no-sound-null-safety
//flutter build apk --split-per-abi --no-sound-null-safety
//flutter build appbundle --target-platform android-arm,android-arm64 --no-sound-null-safety
//flutter build appbundle --no-sound-null-safety
//flutter build web --no-sound-null-safety
//C:\android studio\jre\bin\keytool
//  keytool -genkey -v -keystore E:\flutter\arabic\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
//https://play.google.com/apps/test/com.hark.thajweed/4
//keytool -genkey -v -keystore G:\flutter\ihdau_swalath\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
  //keytool -genkey -v -keystore D:\flutter\ervadi\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
//keytool -genkey -v -keystore D:\flutter\mawlid\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload