import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  static void _boilerPlate(
      {BuildContext context, String message, Color color, IconData iconData}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              iconData,
              color: color,
            ),
            SizedBox(width: 5.0),
            Text(
              message,
              style: TextStyle(color: color, fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }

  static void _initBoilerPlate(
      {GlobalKey<ScaffoldState> key,
      String message,
      Color color,
      IconData iconData}) {
    key.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              iconData,
              color: color,
            ),
            SizedBox(width: 5.0),
            Text(
              message,
              style: TextStyle(color: color, fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }

  static void success(
      {@required BuildContext context, @required String message}) {
    _boilerPlate(
        context: context,
        message: message,
        color: Colors.green,
        iconData: Icons.verified);
  }

  static void warning(
      {@required BuildContext context, @required String message}) {
    _boilerPlate(
        context: context,
        message: message,
        color: Colors.orange,
        iconData: Icons.warning);
  }

  static void alert(
      {@required BuildContext context, @required String message}) {
    _boilerPlate(
        context: context,
        message: message,
        color: Colors.red,
        iconData: Icons.error);
  }

  static void initSuccess(
      {@required GlobalKey<ScaffoldState> key, @required String message}) {
    _initBoilerPlate(
        key: key,
        message: message,
        color: Colors.green,
        iconData: Icons.verified);
  }

  static void initWarning(
      {@required GlobalKey<ScaffoldState> key, @required String message}) {
    _initBoilerPlate(
        key: key,
        message: message,
        color: Colors.orange,
        iconData: Icons.warning);
  }

  static void initAlert(
      {@required GlobalKey<ScaffoldState> key, @required String message}) {
    _initBoilerPlate(
        key: key, message: message, color: Colors.red, iconData: Icons.error);
  }

  static void warningOnTop(BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: "Error",
      message: "Enter correct values!",
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ).show(context);
  }
}
