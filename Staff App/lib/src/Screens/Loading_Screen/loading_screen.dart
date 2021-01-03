import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/models/server_response_model.dart';
import 'package:shahid_grocery_staff/models/staff_data_model.dart';
import 'package:shahid_grocery_staff/src/Screens/Home_Screen/home_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Login_Screen/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  final bool logout;
  LoadingScreen({this.logout = false});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void _goToScreen() async {
    bool _tokenExist = await Staff.doesTokenExist(key: 'token');
    if (_tokenExist) {
      String _usernameSaved = await Staff.readJwtToken(key: 'name');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    userName: _usernameSaved,
                  )));
    } else {
      List<StaffData> _staffData = await Staff.getStaffDetails();
      ServerResponse _response = await Staff.getStaffToken();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    logout: widget.logout,
                    staffData: _staffData,
                    token: _response.token,
                  )));
    }
  }

  @override
  void initState() {
    super.initState();
    _goToScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Center(
        child: SpinKitRotatingPlain(
          color: Colors.red,
        ),
      ),
    );
  }
}
