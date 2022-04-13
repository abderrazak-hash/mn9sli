import 'package:flutter/material.dart';
import 'package:mn9sli/screens/calc_screen.dart';
import 'package:mn9sli/screens/settings_screen.dart';
import 'package:mn9sli/konstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    Mn9sLiApp(),
  );
}

class Mn9sLiApp extends StatefulWidget {
  const Mn9sLiApp({Key? key}) : super(key: key);

  @override
  _Mn9sLiAppState createState() => _Mn9sLiAppState();
}

class _Mn9sLiAppState extends State<Mn9sLiApp> {
  void getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kTheme = prefs.getBool('kTheme') ?? false;
    kThemeClr = kTheme ? kWomanClr : kManClr;
    kMode = prefs.getBool('kMode') ?? false;
    kBgClr = kMode ? kLightClr : kDarkClr;
    kTxtClr = kMode ? kDarkClr : kLightClr;
    kLevel = prefs.getInt('kLevel') ?? 20;
    kSmall = prefs.getBool('kSmall') ?? false;
    kLang = prefs.getBool('kLang') ?? false;
    kNum = prefs.getBool('kNum') ?? false;
    kSound = prefs.getBool('kSound') ?? false;
  }

  @override
  void initState() {
    super.initState();
    getSettings();
    kTheme = false;
    kThemeClr = kManClr;
    kMode = false;
    kTxtClr = kLightClr;
    kBgClr = kDarkClr;
    kLevel = 20;
    kSmall = false;
    kLang = false;
    kNum = false;
    kSound = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'calc_screen': (context) => CalcScreen(),
        'settings_screen': (context) => SettingsScreen()
      },
      initialRoute: 'calc_screen',
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        textTheme: TextTheme(
            //   body1: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   body2: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   bodyText1: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   bodyText2: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   caption: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   title: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   overline: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   subhead: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   subtitle: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   subtitle1: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   subtitle2: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   display1: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   display2: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   display3: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),display4: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   headline: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            //   ),
            //   headline1: TextStyle(
            //     fontFamilyFallback: [
            //       'ElMessiri',
            //     ],
            // ),
            ),
      ),
    );
  }
}
