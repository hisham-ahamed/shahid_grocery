import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/snackbar_service.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/models/address_data_model.dart';
import 'package:shahid_grocery_staff/models/server_response_model.dart';
import 'package:shahid_grocery_staff/src/Screens/Delivery_Panel_Screen/delivery_panel_screen.dart';
import 'package:shahid_grocery_staff/src/common_components/form_boiler_plate.dart';
import 'package:shahid_grocery_staff/src/common_components/rounded_password_field.dart';
import 'package:shahid_grocery_staff/src/common_components/text_field_container.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

import '../address_panel_screen.dart';

class AddAddressScreen extends StatefulWidget {
  static String id = 'add_address_screen';
  final List<AddressData> addressData;
  final bool fromDeliveryScreen;
  AddAddressScreen({this.addressData, this.fromDeliveryScreen = false});
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  GlobalKey<AutoCompleteTextFieldState<AddressData>> _key = new GlobalKey();
  List<AddressData> _addressData;
  String _name;
  String _mobileNumber;
  String _buildingNumber = ' ';
  String _streetName = ' ';
  String _postalCode = ' ';
  String _additional = ' ';
  bool _visibility = false;
  void _visibilityState(bool boolean) {
    setState(() {
      _visibility = boolean;
    });
  }

  @override
  void initState() {
    super.initState();
    _addressData = widget.addressData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyBackgroundColor,
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: Builder(
        builder: (context) => FormBoilerPlate(
          iconName: Icons.home,
          buttonText: 'Add',
          visibility: _visibility,
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Expanded(
                      flex: 8,
                      child: TextFieldContainer(
                        child: AutoCompleteTextField<AddressData>(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter the name'),
                          key: _key,
                          textChanged: (value) {
                            _name = value;
                          },
                          itemSubmitted: (value) {
                            _name = null;
                          },
                          suggestions: _addressData,
                          itemBuilder: (context, suggestion) => ListTile(
                            title: Text(suggestion.name),
                          ),
                          itemSorter: (a, b) => 1,
                          itemFilter: (suggestion, input) => suggestion.name
                              .toLowerCase()
                              .startsWith(input.toLowerCase()),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Mobile No',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Expanded(
                      flex: 8,
                      child: RoundedPasswordField(
                        lockIconVisibility: false,
                        hintText: 'Enter the Mobile No',
                        obscureText: false,
                        onChanged: (value) {
                          _mobileNumber = value;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Building No',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Expanded(
                      flex: 4,
                      child: RoundedPasswordField(
                        lockIconVisibility: false,
                        hintText: 'Enter the Building No',
                        obscureText: false,
                        onChanged: (value) {
                          _buildingNumber = value;
                        },
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Postal Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Expanded(
                      flex: 4,
                      child: RoundedPasswordField(
                        lockIconVisibility: false,
                        hintText: 'Enter the Postal Code',
                        obscureText: false,
                        onChanged: (value) {
                          _postalCode = value;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Street Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Expanded(
                      flex: 8,
                      child: RoundedPasswordField(
                        lockIconVisibility: false,
                        hintText: 'Enter the Street Name',
                        obscureText: false,
                        onChanged: (value) {
                          _streetName = value;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Additional Info',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )),
                    Expanded(
                      flex: 8,
                      child: RoundedPasswordField(
                        maxLines: 3,
                        lockIconVisibility: false,
                        hintText: 'Enter the Additional Info',
                        obscureText: false,
                        onChanged: (value) {
                          _additional = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          buttonOnClick: () async {
            if (_name == null ||
                _name == '' ||
                _mobileNumber == null ||
                _mobileNumber == '')
              SnackBarService.alert(
                  context: context, message: 'Name and Mobile number required');
            else {
              _visibilityState(true);
              AddressData _temp = AddressData.values(_name, _mobileNumber,
                  _buildingNumber, _streetName, _postalCode, _additional);
              ServerResponse _serverResponse =
                  await Staff.addAddressDetails(_temp);
              if (_serverResponse.addressDetailsSaved) {
                _addressData.add(_temp);
                _addressData.sort((a, b) =>
                    a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                _visibilityState(false);
                (widget.fromDeliveryScreen)
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryPanelScreen(
                                addAddress: true,
                                serverMessage: _serverResponse.message)))
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressPanelScreen(
                                  addAddress: true,
                                  serverMessage: _serverResponse.message,
                                  dataReceived: true,
                                  addressData: _addressData,
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
