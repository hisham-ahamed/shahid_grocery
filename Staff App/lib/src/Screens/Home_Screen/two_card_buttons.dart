import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/src/Screens/Home_Screen/card_button.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class TwoCardButtons extends StatelessWidget {
  final Color color;
  final bool doubleButton;
  final Function primaryOnPressed;
  final IconData primaryIcon;
  final String primaryText;
  final Function secondaryOnPressed;
  final IconData secondaryIcon;
  final String secondaryText;
  const TwoCardButtons({
    this.color = kPrimaryColor,
    this.doubleButton = true,
    this.primaryOnPressed,
    @required this.primaryIcon,
    @required this.primaryText,
    this.secondaryOnPressed,
    this.secondaryIcon = Icons.android_outlined,
    this.secondaryText = "Android",
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Screen.height * 0.2,
      margin: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: CardButton(
            icon: Icon(
              primaryIcon,
              size: 50.0,
              color: color,
            ),
            text: Text(
              primaryText,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            onPressed: primaryOnPressed,
          )),
          Visibility(
              visible: doubleButton,
              child: SizedBox(width: Screen.width * 0.07)),
          Visibility(
            visible: doubleButton,
            child: Expanded(
                child: CardButton(
              icon: Icon(
                secondaryIcon,
                size: 50.0,
                color: color,
              ),
              text: Text(
                secondaryText,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              onPressed: secondaryOnPressed,
            )),
          )
        ],
      ),
    );
  }
}
