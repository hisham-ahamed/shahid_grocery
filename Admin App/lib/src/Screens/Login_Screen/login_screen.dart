import 'package:flutter/material.dart';
import 'package:shahid_grocery_admin/common_services/snackbar_service.dart';

import 'body.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  final bool logout;
  final bool passwordChange;
  LoginScreen({this.logout = false, this.passwordChange = false});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (widget.logout) {
      Future.delayed(Duration(milliseconds: 300)).then((_) =>
          SnackBarService.initWarning(
              key: key, message: 'Logged out Successfully'));
    }
    if (widget.passwordChange) {
      Future.delayed(Duration(milliseconds: 300)).then((_) =>
          SnackBarService.initAlert(key: key, message: 'Please login again!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Builder(
        builder: (context) => Body(),
      ),
    );
  }
}
