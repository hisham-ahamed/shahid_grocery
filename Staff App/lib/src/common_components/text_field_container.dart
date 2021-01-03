import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double pHorizontal;
  final double pVertical;
  final double mVertical;
  final double radius;

  const TextFieldContainer({
    Key key,
    this.pHorizontal = 20.0,
    this.pVertical = 5.0,
    this.mVertical = 10.0,
    this.radius = 29,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: mVertical),
      padding:
          EdgeInsets.symmetric(horizontal: pHorizontal, vertical: pVertical),
      width: Screen.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
