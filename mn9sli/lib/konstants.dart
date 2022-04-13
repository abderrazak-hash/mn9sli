import 'package:flutter/material.dart';

late bool kTheme, kMode, kSmall, kLang, kNum, kSound;
late int kLevel;
Color kDarkClr = Colors.black,
    kLightClr = Colors.white,
    kManClr = Colors.blue,
    kWomanClr = Colors.pink,
    kBgClr = kMode ? Colors.white : Colors.black,
    kTxtClr = kMode ? Colors.black : Colors.white,
    kThemeClr = kTheme ? Colors.pink : Colors.blue;
