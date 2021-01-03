import 'package:flutter/cupertino.dart';

class StaffData {
  final String username;
  final String mobileNumber;
  final String password;
  StaffData(
      {@required this.username,
      @required this.mobileNumber,
      @required this.password});

  factory StaffData.fromJson(Map<String, dynamic> json) {
    return StaffData(
        username: json['username'] as String,
        mobileNumber: json['mobileNumber'] as String,
        password: json['password'] as String);
  }

  factory StaffData.values(
      String username, String mobileNumber, String password) {
    return StaffData(
        username: username, mobileNumber: mobileNumber, password: password);
  }
}
