import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final double fontSize;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.onClick,
    this.fontSize = 14.0,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: Screen.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: onClick,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
