import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mn9sli/konstants.dart';
// ignore: unused_import
import 'package:mn9sli/utils/rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgClr,
      appBar: AppBar(
        title: Text(kLang ? 'Settings' : 'اﻹعدادات'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kThemeClr,
        actions: [
          IconButton(
            icon: Icon(
              Icons.restore,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('kTheme', false);
              prefs.setBool('kMode', false);
              prefs.setInt('kLevel', 20);
              prefs.setBool('kSmall', false);
              prefs.setBool('kLang', false);
              prefs.setBool('kNum', false);
              prefs.setBool('kSound', false);
              setState(() {
                kTheme = false;
                kThemeClr = kManClr;
                kMode = false;
                kTxtClr = kDarkClr;
                kBgClr = kLightClr;
                kLevel = 20;
                kSmall = false;
                kLang = false;
                kNum = false;
                kSound = false;
              });
            },
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      kTheme = !kTheme;
                      kThemeClr = kTheme ? Colors.pink : Colors.blue;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: kThemeClr,
                    ),
                    height: 130.0,
                    width: 130.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          kTheme ? Icons.female : Icons.male,
                          size: 80.0,
                        ),
                        Text(
                          kTheme ? 'Female' : 'Male',
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      kMode = !kMode;
                      kBgClr = kMode ? Colors.white : Colors.black;
                      kTxtClr = kMode ? Colors.black : Colors.white;
                    });
                  },
                  child: Container(
                    height: 130.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      border: Border.all(
                        width: 5.0,
                        color: kTxtClr,
                      ),
                      color: kBgClr,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          kMode
                              ? CupertinoIcons.moon
                              : CupertinoIcons.sun_max_fill,
                          size: 70.0,
                          color: kTxtClr,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                            color: kTxtClr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SettingCard(
            engOption: 'Level',
            arOption: 'المستوى',
            myWidget: LiteRollingSwitch(
              onChanged: (val) {},
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
            ),
          ),
          SettingCard(
            engOption: '0.125',
            arOption: '0.125',
            myWidget: LiteRollingSwitch(
              onChanged: (val) {},
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
            ),
          ),
          SettingCard(
            engOption: 'Language',
            arOption: 'اللغة',
            myWidget: LiteRollingSwitch(
              onChanged: (val) async {
                setState(() {
                  kLang = !kLang;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('kLang', false);
              },
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              colorOn: Colors.grey,
              colorOff: Colors.grey,
              isTxt: true,
              txtOn: 'ABC',
              txtOff: 'أبج',
              textOff: kLang ? 'English' : 'اﻹنجليزية',
              textOn: kLang ? 'Arabic' : 'العربية',
            ),
          ),
          SettingCard(
            engOption: 'Numbers',
            arOption: 'اﻷرقام',
            myWidget: LiteRollingSwitch(
              onChanged: (val) async {},
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              colorOn: Colors.grey,
              colorOff: Colors.grey,
              isTxt: true,
              txtOn: '123',
              txtOff: '456',
              textOff: kLang ? 'Indian' : 'الهندية',
              textOn: kLang ? 'Arabic' : 'العربية',
            ),
          ),
          SettingCard(
            engOption: 'Sound',
            arOption: 'الصوت',
            myWidget: LiteRollingSwitch(
              value: kSound,
              onChanged: (val) async {
                setState(() {
                  kSound = !kSound;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('kSound', false);
              },
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              textOn: kLang ? 'On' : 'منشط',
              textOff: kLang ? 'Off' : 'موقف',
            ),
          ),
        ],
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  final String engOption, arOption;
  final Widget myWidget;
  SettingCard({
    required this.engOption,
    required this.arOption,
    required this.myWidget,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        color: kThemeClr,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Row(
        textDirection: kLang ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Expanded(
            child: Center(
              child: myWidget,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                kLang ? engOption : arOption,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'ElMessiri',
                  fontFamilyFallback: [
                    'ElMessiri',
                  ],
                  color: kTxtClr,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
