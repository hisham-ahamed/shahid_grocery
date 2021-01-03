import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahid_grocery_admin/common_services/admin_service.dart';
import 'package:shahid_grocery_admin/src/Screens/Home_Screen/home_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Login_Screen/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _goToScreen();
  }

  void _goToScreen() async {
    bool _tokenExist = await Admin.doesTokenExist(key: 'token');
    if (_tokenExist) {
      Admin.initBackend();
      Navigator.popAndPushNamed(context, HomeScreen.id);
    } else {
      await Admin.initBackend();
      Navigator.popAndPushNamed(context, LoginScreen.id);
    }
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
