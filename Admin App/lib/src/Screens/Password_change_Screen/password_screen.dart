import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shahid_grocery_admin/common_services/admin_service.dart';
import 'package:shahid_grocery_admin/common_services/show_alert_service.dart';
import 'package:shahid_grocery_admin/models/server_response_data_model.dart';
import 'package:shahid_grocery_admin/src/Screens/Login_Screen/login_screen.dart';
import 'package:shahid_grocery_admin/src/common_components/form_boiler_plate.dart';
import 'package:shahid_grocery_admin/src/common_components/rounded_password_field.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

class PasswordScreen extends StatefulWidget {
  static String id = 'password_change_screen';
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String _password;
  String _repeatPassword;
  bool _visibility = false;
  void _visibilityState(bool boolean) {
    setState(() {
      _visibility = boolean;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyBackgroundColor,
      appBar: AppBar(
        title: Text('Change Admin Password'),
      ),
      body: Builder(
        builder: (context) => FormBoilerPlate(
          iconName: Icons.vpn_key,
          buttonText: 'Submit',
          visibility: _visibility,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                child: Text(
                  "Enter the new password and click submit button",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  _password = value;
                },
                obscureText: true,
                hintText: 'Enter the new password',
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  _repeatPassword = value;
                },
                obscureText: true,
                hintText: 'Re-enter the new password',
              ),
            ],
          ),
          buttonOnClick: () async {
            _visibilityState(true);
            ServerResponse _serverResponse = await Admin.changePassword(
                passwordA: _repeatPassword,
                passwordB: _password,
                context: context);
            _visibilityState(false);
            if (_serverResponse.adminPasswordChange) {
              _visibilityState(false);
              showAlert(
                context: context,
                message: _serverResponse.message,
                alertType: AlertType.success,
                onPressed: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                passwordChange: true,
                              )))
                },
              );
            } else {
              _visibilityState(false);
              showAlert(
                  context: context,
                  message: _serverResponse.message,
                  alertType: AlertType.error,
                  onPressed: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      passwordChange: true,
                                    )))
                      });
            }
          },
        ),
      ),
    );
  }
}
