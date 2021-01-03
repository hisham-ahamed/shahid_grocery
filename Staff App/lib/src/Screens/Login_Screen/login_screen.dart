import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/snackbar_service.dart';
import 'package:shahid_grocery_staff/models/staff_data_model.dart';

import 'body.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  final bool logout;
  final List<StaffData> staffData;
  final String token;
  LoginScreen({this.logout = false, this.staffData, this.token});
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Builder(
        builder: (context) => Body(
          staffData: widget.staffData,
          token: widget.token,
        ),
      ),
    );
  }
}
