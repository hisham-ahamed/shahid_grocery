import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/src/Screens/Address_Panel_Screen/address_panel_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Delivery_Panel_Screen/delivery_panel_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Delivery_Report_Panel_Screen/delivery_report_panel_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Home_Screen/two_card_buttons.dart';
import 'package:shahid_grocery_staff/src/Screens/Loading_Screen/loading_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Sync_Screen/sync_screen.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  final String userName;
  final bool fromDeliveryPanelScreen;
  HomeScreen({this.userName, this.fromDeliveryPanelScreen = false});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _offline = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: kBodyBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  color: kPrimaryColor,
                  elevation: 10.0,
                  child: Container(
                      height: Screen.height * 0.08,
                      child: Center(
                          child: Text(
                        "Online/Offline",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ))),
                ),
                ListTile(
                  title: Text('Offline', style: TextStyle(fontSize: 17.0)),
                  trailing: Checkbox(
                    value: _offline,
                    onChanged: (value) {
                      setState(() {
                        _offline = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                    "Welcome ${widget.userName} !",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TwoCardButtons(
                  primaryIcon: Icons.home,
                  primaryText: 'Address Panel',
                  primaryOnPressed: () {
                    Navigator.pushNamed(context, AddressPanelScreen.id);
                  },
                  secondaryIcon: Icons.delivery_dining,
                  secondaryText: 'Delivery Panel',
                  secondaryOnPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryPanelScreen(
                                  userName: widget.userName,
                                )));
                  },
                ),
                TwoCardButtons(
                  primaryIcon: Icons.sync,
                  primaryText: 'Sync',
                  primaryOnPressed: () {
                    Navigator.pushNamed(context, SyncScreen.id);
                  },
                  secondaryIcon: Icons.logout,
                  secondaryText: 'Logout',
                  secondaryOnPressed: () async {
                    await Staff.deleteToken(key: 'user');
                    bool delete = await Staff.deleteToken(key: 'token');
                    if (delete)
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingScreen(
                                    logout: true,
                                  )));
                  },
                ),
                TwoCardButtons(
                  doubleButton: false,
                  primaryIcon: Icons.file_copy_rounded,
                  primaryText: 'My Delivery Report',
                  primaryOnPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryReportPanelScreen(
                                  userName: widget.userName,
                                )));
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
