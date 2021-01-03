import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shahid_grocery_admin/common_services/admin_service.dart';
import 'package:shahid_grocery_admin/common_services/snackbar_service.dart';
import 'package:shahid_grocery_admin/models/server_response_data_model.dart';
import 'package:shahid_grocery_admin/models/staff_data_model.dart';
import 'package:shahid_grocery_admin/src/common_components/detail_card.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

import 'Sub_Screens/add_staff_screen.dart';

class StaffPanelScreen extends StatefulWidget {
  static String id = 'staff_panel_screen';
  final bool addStaff;
  final String serverMessage;
  final bool dataReceived;
  final List<StaffData> staffData;
  StaffPanelScreen(
      {this.addStaff = false,
      this.serverMessage = '',
      this.dataReceived = false,
      this.staffData});
  @override
  _StaffPanelScreenState createState() => _StaffPanelScreenState();
}

class _StaffPanelScreenState extends State<StaffPanelScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _dataReceived = false;
  List<StaffData> _staffData;
  List<StaffData> _searchResult = [];
  List<bool> _visibility = [];
  String _searchQuery = '';
  void _visibilityState(int index, bool boolean) {
    setState(() {
      _visibility[index] = boolean;
    });
  }

  @override
  void initState() {
    super.initState();
    _dataReceived = widget.dataReceived;
    if (widget.dataReceived) _staffData = widget.staffData;
    if (widget.addStaff) {
      Future.delayed(Duration(milliseconds: 300)).then((_) => {
            SnackBarService.initSuccess(
                key: _key, message: widget.serverMessage)
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: kBodyBackgroundColor,
      appBar: AppBar(
        title: Text('Staff Panel'),
      ),
      body: Builder(builder: (context) {
        if (_dataReceived) {
          _searchResult.clear();
          _staffData.forEach((element) {
            if (element.username.toLowerCase().contains(_searchQuery))
              _searchResult.add(element);
          });
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                    ),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20.0,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: double.infinity,
                    child: ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        _visibility.add(false);
                        return DetailCard(
                          visibility: _visibility[index],
                          title: _searchResult[index].username,
                          subTitle: _searchResult[index].password,
                          onDeletePressed: () async {
                            _visibilityState(index, true);

                            ServerResponse _serverResponse =
                                await Admin.deleteStaff(
                                    _searchResult[index].mobileNumber);

                            if (_serverResponse.staffDetailsdeleted) {
                              SnackBarService.success(
                                  context: context,
                                  message: _serverResponse.message);
                              _staffData.removeWhere((element) =>
                                  element.mobileNumber ==
                                  _searchResult[index].mobileNumber);
                              _visibilityState(index, false);
                            } else {
                              SnackBarService.alert(
                                  context: context,
                                  message: _serverResponse.message);
                              _visibilityState(index, false);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddStaffScreen(staffData: _staffData)));
                        },
                      ),
                    ))
              ],
            ),
          );
        } else
          return FutureBuilder(
              future: Admin.getStaffDetails(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<StaffData>> snapshot) {
                if (snapshot.hasData) {
                  _staffData = snapshot.data;
                  _staffData.sort((a, b) => a.username
                      .toLowerCase()
                      .compareTo(b.username.toLowerCase()));
                  Future.delayed(Duration(milliseconds: 1)).then((_) => {
                        setState(() {
                          _dataReceived = true;
                        })
                      });
                  return Text('Data Fetched');
                } else
                  return ModalProgressHUD(
                      inAsyncCall: true, child: Text('Fetching Data'));
              });
      }),
    );
  }
}
