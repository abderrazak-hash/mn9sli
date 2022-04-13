import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class LiteRollingSwitch extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final String textOff, textOn;
  final Color colorOn, colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn, iconOff;
  final double iconOnSize, iconOffSize;
  final Function onTap, onDoubleTap, onSwipe;
  final bool isTxt;
  final String txtOn, txtOff;

  LiteRollingSwitch({
    this.value = false,
    this.textOff = "Off",
    this.textOn = "On",
    this.textSize = 14.0,
    this.colorOn = Colors.greenAccent,
    this.colorOff = Colors.redAccent,
    this.iconOff = Icons.flag,
    this.iconOnSize = 30.0,
    this.iconOffSize = 30.0,
    this.iconOn = Icons.check,
    this.animationDuration = const Duration(milliseconds: 600),
    required this.onTap,
    required this.onDoubleTap,
    required this.onSwipe,
    required this.onChanged,
    this.isTxt = false,
    this.txtOn = "",
    this.txtOff = "",
  });

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<LiteRollingSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  double value = 0.0;

  late bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value)!;

    return GestureDetector(
      onDoubleTap: () {
        _action();
        // if (widget.onDoubleTap != null) {
        setState(() {
          widget.onDoubleTap();
        });
        // }
      },
      onTap: () {
        _action();
        setState(() {
          widget.onTap();
        });
      },
      onPanEnd: (details) {
        _action();
        setState(() {
          widget.onSwipe();
        });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 130,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  height: 40,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.textSize,
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(/*top: 10,*/ left: 5),
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.textSize,
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(80 * value, 0),
              child: Transform.rotate(
                angle: lerpDouble(0, 2 * pi, value)!,
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: widget.isTxt
                              ? Text(
                                  widget.txtOff,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                )
                              : Icon(
                                  widget.iconOff,
                                  size: widget.iconOffSize,
                                  color: transitionColor,
                                ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: widget.isTxt
                              ? Text(
                                  widget.txtOn,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                )
                              : Icon(
                                  widget.iconOn,
                                  size: widget.iconOnSize,
                                  color: transitionColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
      setState(() {
        turnState = turnState;
      });
    });
  }
}
