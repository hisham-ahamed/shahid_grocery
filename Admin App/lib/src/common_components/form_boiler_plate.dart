import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahid_grocery_admin/common_services/screen_service.dart';
import 'package:shahid_grocery_admin/src/Screens/Login_Screen/background.dart';
import 'package:shahid_grocery_admin/src/common_components/rounded_button.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

class FormBoilerPlate extends StatelessWidget {
  final IconData iconName;
  final Widget child;
  final Function buttonOnClick;
  final String buttonText;
  final bool visibility;
  const FormBoilerPlate({
    Key key,
    this.iconName,
    this.child,
    this.buttonOnClick,
    this.buttonText,
    this.visibility = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconName,
                  color: kPrimaryColor,
                  size: 75.0,
                ),
                SizedBox(height: Screen.height * 0.05),
                child,
                SizedBox(height: Screen.height * 0.03),
                Visibility(
                  visible: visibility,
                  child: SpinKitCircle(
                    size: 40.0,
                    color: kPrimaryColor,
                  ),
                ),
                Visibility(
                  visible: !visibility,
                  child: RoundedButton(
                    onClick: buttonOnClick,
                    text: buttonText,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
