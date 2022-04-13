import 'package:flutter/material.dart';
import 'package:mn9sli/konstants.dart';
import 'package:share/share.dart';

String onLongPressing = "";
String res = "0";
int mark = 0;
List<dynamic> marx = [0];

class CalcScreen extends StatefulWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  _CalcScreenState createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> with TickerProviderStateMixin {
  late AnimationController menuCtrl;
  late AnimationController googleCtrl;

  bool isMenu = false;
  bool googleDrop = false;

  Widget multMark(String multIt, String miniMark) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(1.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kBgClr,
          ),
          onPressed: () {
            calcMark(double.parse(multIt) * double.parse(miniMark));
          },
          child: SizedBox.expand(
            child: Center(
              child: Text(
                multIt,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: kTxtClr,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myBtn(String miniMark) {
    return Expanded(
      child: Container(
        margin:
            onLongPressing == miniMark ? EdgeInsets.zero : EdgeInsets.all(1.0),
        child: onLongPressing == miniMark
            ? Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        multMark('1', miniMark),
                        multMark('2', miniMark),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        multMark('3', miniMark),
                        multMark('4', miniMark),
                      ],
                    ),
                  ),
                ],
              )
            // Center(child: Text('hglk'))
            : TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBgClr,
                ),
                onLongPress: () {
                  print(onLongPressing);
                  setState(() {
                    onLongPressing = miniMark;
                  });
                },
                onPressed: () {
                  calcMark(double.parse(miniMark));
                },
                child: SizedBox.expand(
                  child: Center(
                    child: Text(
                      miniMark,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: kTxtClr,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    menuCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    googleCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    setState(() {
      menuCtrl.value = 0;
      googleCtrl.value = 0;
    });
  }

  void calcMark(double toBeAdded) {
    setState(() {
      onLongPressing = "";
    });
    dynamic x = marx.last + toBeAdded;
    if (x <= kLevel) {
      setState(() {
        if (x == x.toInt())
          marx.add(x.toInt());
        else
          marx.add(x);
      });
    }
  }

  double wid = 0;

  @override
  Scaffold build(BuildContext context) {
    wid = (MediaQuery.of(context).size.width - 28) / 3;
    return Scaffold(
      backgroundColor: kBgClr,
      appBar: AppBar(
        title: Text(
          kLang ? 'Mn9sLi' : 'منقسلي',
          style: TextStyle(
            fontFamilyFallback: ['ElMessiri'],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {
            setState(() {
              isMenu = true;
            });
            menuCtrl.forward();
            menuCtrl.addListener(() {
              setState(() {});
            });
          },
        ),
        backgroundColor: kThemeClr,
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
            ),
            onPressed: () {
              Share.share(
                kLang
                    ? 'Mn9sLiApp\nMn9sLiApp is designed to help students and teachers calc the total exam mark easily.\n You can get the app on Google Play Store.\nDevelopper: AbdErrazak KENNICHE.'
                    : 'تطبيق منقسلي\nتطبيق منقسلي مصمم لمساعدة الطلبة على حساب العلامة الخاصة بأي امتحان.\nيمكنك تحميل التطبيق من خلال  متجر جوجل بلاي.\nالمطور: عبد الرزاق قنيش.',
                subject: kLang ? 'Mn9sLiApp' : 'تطبيق منقسلي',
              );
            },
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Result Part
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: kThemeClr,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.0),
                                child: Icon(
                                  Icons.star_border_outlined,
                                  color: kThemeClr,
                                ),
                              ),
                              Icon(
                                Icons.star_border_outlined,
                                color: kThemeClr,
                              ),
                            ],
                          ),
                          Text(
                            marx.last.toString(),
                            style: TextStyle(
                              fontSize: 50.0,
                              color: kTxtClr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(30.0),
                        width: 35.0,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.5),
                          border: Border.all(
                            width: 3.0,
                            color: Colors.black,
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 35.0,
                              height: 200.0 * marx.last / kLevel,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.5),
                                color: kThemeClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Calc Part
              Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  color: kThemeClr,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 30,
                            child: Column(
                              children: [
                                myBtn("2.00"),
                                myBtn("1.25"),
                                myBtn("0.50"),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: Column(
                              children: [
                                myBtn("1.75"),
                                myBtn("1.00"),
                                myBtn("0.25"),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: Column(
                              children: [
                                myBtn('1.50'),
                                myBtn('0.75'),
                                myBtn('0.125'),
                              ],
                            ),
                          ),
                          Container(
                            width: 30.0,
                          ),
                        ],
                      ),
                      // Positioned(
                      //   top: 0,
                      //   // left: MediaQuery.of(context).size.width - 120.0,
                      //   child: Container(
                      //     margin: EdgeInsets.only(
                      //       left: MediaQuery.of(context).size.width -
                      //           31 -
                      //           wid * googleCtrl.value.toDouble(),
                      //     ),
                      //     width: wid + 30,
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           color: Colors.red,
                      //           child: Center(
                      //             child: GestureDetector(
                      //               onTap: () {
                      //                 setState(() {
                      //                   if (googleCtrl.value == 0) {
                      //                     googleCtrl.forward();
                      //                   } else if (googleCtrl.value == 1) {
                      //                     googleCtrl.reverse();
                      //                   }
                      //                   googleCtrl.addListener(() {
                      //                     setState(() {});
                      //                   });
                      //                 });
                      //               },
                      //               child: Icon(
                      //                 Icons.arrow_back_ios,
                      //               ),
                      //             ),
                      //           ),
                      //           width: 30.0,
                      //           height: double.infinity,
                      //         ),
                      //         Container(
                      //           color: kThemeClr,
                      //           width: wid,
                      //           height: double.infinity,
                      //           child: Column(
                      //             children: [
                      //               myBtn('3.00'),
                      //               myBtn('4.00'),
                      //               myBtn('5.00'),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // Third Part
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              if (marx.last != 0) {
                                setState(() {
                                  marx.removeLast();
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                'Undo',
                                style: TextStyle(
                                  color: kTxtClr,
                                  fontSize: 26.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          color: kThemeClr,
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (marx.last != 0) marx.add(0);
                              });
                            },
                            child: Center(
                              child: Text(
                                'New',
                                style: TextStyle(
                                  color: kTxtClr,
                                  fontSize: 26.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Menu //
          if (isMenu)
            GestureDetector(
              onTap: () {
                setState(() {
                  isMenu = false;
                  menuCtrl.value = 0;
                });
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
              ),
            ),

          if (isMenu)
            Positioned(
              top: menuCtrl.value.toDouble() * -4.0,
              left: menuCtrl.value.toDouble() * 70.0,
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: kThemeClr,
                  size: 45.0,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'settings_screen');
                },
              ),
            ),
          if (isMenu)
            Positioned(
              top: menuCtrl.value.toDouble() * 45.0,
              left: menuCtrl.value.toDouble() * 40.0,
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  color: kThemeClr,
                  size: 45.0,
                ),
                onPressed: () {},
              ),
            ),
          if (isMenu)
            Positioned(
              top: menuCtrl.value.toDouble() * 75.0,
              left: menuCtrl.value.toDouble() * -5.0,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: kThemeClr,
                  size: 45.0,
                ),
                onPressed: () {},
              ),
            ),
        ],
      ),
    );
  }
}
