import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/src/Screens/Address_Panel_Screen/Sub_Screens/add_address_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Address_Panel_Screen/address_panel_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Delivery_Panel_Screen/delivery_panel_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Home_Screen/home_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Loading_Screen/loading_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Login_Screen/login_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Sync_Screen/sync_screen.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        AddressPanelScreen.id: (context) => AddressPanelScreen(),
        AddAddressScreen.id: (context) => AddAddressScreen(),
        DeliveryPanelScreen.id: (context) => DeliveryPanelScreen(),
        SyncScreen.id: (context) => SyncScreen()
      },
    );
  }
}
