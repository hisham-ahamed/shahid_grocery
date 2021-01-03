import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showAlert(
    {BuildContext context,
    String message,
    AlertType alertType,
    Function onPressed}) {
  Alert(
    context: context,
    type: alertType,
    title: "SUCCESS",
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: onPressed,
        width: 120,
      )
    ],
  ).show();
}
