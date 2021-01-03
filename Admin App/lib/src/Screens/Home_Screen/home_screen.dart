import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shahid_grocery_admin/common_services/admin_service.dart';
import 'package:shahid_grocery_admin/common_services/snackbar_service.dart';
import 'package:shahid_grocery_admin/src/Screens/Address_Panel_Screen/address_panel_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Delivery_Report_Panel_Screen/delivery_report_panel_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Home_Screen/two_card_buttons.dart';
import 'package:shahid_grocery_admin/src/Screens/Login_Screen/login_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Password_change_Screen/password_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Staff_Panel_Screen/staff_panel_screen.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  final bool auth;
  final String message;

  HomeScreen({this.auth = false, this.message = 'null'});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (widget.auth) {
      new Future.delayed(const Duration(milliseconds: 300)).then((_) =>
          SnackBarService.initSuccess(key: key, message: widget.message));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Dash Board'),
      ),
      backgroundColor: kBodyBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Welcome Mufeed !",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TwoCardButtons(
                  primaryIcon: Icons.person,
                  primaryText: 'Staff Panel',
                  primaryOnPressed: () {
                    Navigator.pushNamed(context, StaffPanelScreen.id);
                  },
                  secondaryIcon: Icons.home,
                  secondaryText: 'Address Panel',
                  secondaryOnPressed: () {
                    Navigator.pushNamed(context, AddressPanelScreen.id);
                  },
                ),
                TwoCardButtons(
                  primaryIcon: Icons.security,
                  primaryText: 'Password',
                  primaryOnPressed: () {
                    Navigator.pushNamed(context, PasswordScreen.id);
                  },
                  secondaryIcon: Icons.logout,
                  secondaryText: 'Logout',
                  secondaryOnPressed: () async {
                    bool delete = await Admin.deleteToken(key: 'token');
                    if (delete)
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    logout: true,
                                  )));
                  },
                ),
                TwoCardButtons(
                  doubleButton: false,
                  primaryIcon: Icons.file_copy_rounded,
                  primaryText: 'View Delivery Report',
                  primaryOnPressed: () {
                    Navigator.pushNamed(context, DeliveryReportPanelScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
