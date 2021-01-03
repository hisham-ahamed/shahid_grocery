import 'package:flutter/material.dart';
import 'package:shahid_grocery_admin/src/Screens/Address_Panel_Screen/Sub_Screens/add_address_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Address_Panel_Screen/address_panel_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Delivery_Report_Panel_Screen/delivery_report_panel_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Home_Screen/home_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Loading_Screen/loading_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Password_change_Screen/password_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Staff_Panel_Screen/Sub_Screens/add_staff_screen.dart';
import 'package:shahid_grocery_admin/src/Screens/Staff_Panel_Screen/staff_panel_screen.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

import 'src/Screens/Login_Screen/login_screen.dart';

void main() {
  runApp(AdminApp());
}

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        primaryColorLight: kPrimaryLightColor,
      ),
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        StaffPanelScreen.id: (context) => StaffPanelScreen(),
        AddStaffScreen.id: (context) => AddStaffScreen(),
        AddressPanelScreen.id: (context) => AddressPanelScreen(),
        AddAddressScreen.id: (context) => AddAddressScreen(),
        PasswordScreen.id: (context) => PasswordScreen(),
        DeliveryReportPanelScreen.id: (context) => DeliveryReportPanelScreen()
      },
    );
  }
}
