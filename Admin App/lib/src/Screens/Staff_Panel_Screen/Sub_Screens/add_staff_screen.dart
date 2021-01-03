import 'package:flutter/material.dart';
import 'package:shahid_grocery_admin/common_services/admin_service.dart';
import 'package:shahid_grocery_admin/common_services/snackbar_service.dart';
import 'package:shahid_grocery_admin/models/server_response_data_model.dart';
import 'package:shahid_grocery_admin/models/staff_data_model.dart';
import 'package:shahid_grocery_admin/src/Screens/Staff_Panel_Screen/staff_panel_screen.dart';
import 'package:shahid_grocery_admin/src/common_components/form_boiler_plate.dart';
import 'package:shahid_grocery_admin/src/common_components/rounded_password_field.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

class AddStaffScreen extends StatefulWidget {
  static String id = 'add_staff_screen';
  final List<StaffData> staffData;
  AddStaffScreen({this.staffData});
  @override
  _AddStaffScreenState createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  String _name;
  String _mobileNumber;
  String _password;
  bool _visibility = false;
  List<StaffData> _staffData;
  void _visibilityState(bool boolean) {
    setState(() {
      _visibility = boolean;
    });
  }

  @override
  void initState() {
    super.initState();
    _staffData = widget.staffData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyBackgroundColor,
      appBar: AppBar(
        title: Text('Add Staff'),
      ),
      body: Builder(
        builder: (context) => FormBoilerPlate(
          iconName: Icons.face,
          buttonText: 'Add',
          visibility: _visibility,
          child: Container(
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                        ),
                      )),
                  Expanded(
                    flex: 7,
                    child: RoundedPasswordField(
                      lockIconVisibility: false,
                      hintText: 'Please enter name',
                      obscureText: false,
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                  )
                ]),
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Mobile No',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                        ),
                      )),
                  Expanded(
                    flex: 7,
                    child: RoundedPasswordField(
                      lockIconVisibility: false,
                      hintText: 'Please enter mobile number',
                      obscureText: false,
                      onChanged: (value) {
                        _mobileNumber = value;
                      },
                    ),
                  )
                ]),
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                        ),
                      )),
                  Expanded(
                    flex: 7,
                    child: RoundedPasswordField(
                      lockIconVisibility: true,
                      hintText: 'Please provide a password',
                      obscureText: false,
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                  )
                ]),
              ],
            ),
          ),
          buttonOnClick: () async {
            if (_name == null ||
                _name == '' ||
                _mobileNumber == null ||
                _mobileNumber == '' ||
                _password == null ||
                _password == '')
              SnackBarService.warning(
                  context: context, message: 'Please fill all the fields');
            else {
              _visibilityState(true);
              StaffData _temp =
                  StaffData.values(_name, _mobileNumber, _password);
              ServerResponse _serverResponse =
                  await Admin.addStaffDetails(_temp);
              if (_serverResponse.staffDetailsSaved) {
                _staffData.add(_temp);
                _staffData.sort((a, b) => a.username
                    .toLowerCase()
                    .compareTo(b.username.toLowerCase()));
                _visibilityState(false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StaffPanelScreen(
                              addStaff: true,
                              serverMessage: _serverResponse.message,
                              dataReceived: true,
                              staffData: _staffData,
                            )));
              } else
                _visibilityState(false);
            }
          },
        ),
      ),
    );
  }
}
