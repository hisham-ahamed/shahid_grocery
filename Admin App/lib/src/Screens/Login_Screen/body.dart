import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shahid_grocery_admin/common_services/admin_service.dart';
import 'package:shahid_grocery_admin/common_services/screen_service.dart';
import 'package:shahid_grocery_admin/common_services/snackbar_service.dart';
import 'package:shahid_grocery_admin/models/server_response_data_model.dart';
import 'package:shahid_grocery_admin/src/Screens/Home_Screen/home_screen.dart';
import 'package:shahid_grocery_admin/src/common_components/rounded_button.dart';
import 'package:shahid_grocery_admin/src/common_components/rounded_password_field.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

import 'background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _password;
  bool _showSpinner = false;

  void _spinnerControl(bool boolean) {
    setState(() {
      _showSpinner = boolean;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorizeAnimatedTextKit(
                    text: ["Shahid Grocery"],
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Horizon",
                      fontWeight: FontWeight.w900,
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                    repeatForever: true,
                    textAlign: TextAlign.start,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
                SizedBox(height: Screen.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: Screen.height * 0.35,
                ),
                SizedBox(height: Screen.height * 0.03),
                Container(
                  child: Text(
                    "Hi Mufeed",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RoundedPasswordField(
                  hintText: "Please enter your password",
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                RoundedButton(
                  fontSize: 16.0,
                  text: "LOGIN",
                  onClick: () async {
                    _spinnerControl(true);
                    try {
                      ServerResponse _serverResponse =
                          await Admin.login(password: _password);
                      if (_serverResponse.auth) {
                        bool save = await Admin.saveJwtToken(
                            token: _serverResponse.token);
                        _spinnerControl(false);
                        if (save) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        auth: _serverResponse.auth,
                                        message: _serverResponse.message,
                                      )));
                          // Navigator.popAndPushNamed(context, HomeScreen.id);
                        }
                      } else {
                        _spinnerControl(false);
                        SnackBarService.alert(
                            context: context, message: _serverResponse.message);
                      }
                    } catch (e) {
                      print('Error found');
                      print(e);
                    }
                  },
                ),
                SizedBox(height: Screen.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
