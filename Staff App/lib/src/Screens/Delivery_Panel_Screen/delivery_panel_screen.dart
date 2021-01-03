import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/common_services/show_alert_service.dart';
import 'package:shahid_grocery_staff/common_services/snackbar_service.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/models/address_data_model.dart';
import 'package:shahid_grocery_staff/models/delivery_data_model.dart';
import 'package:shahid_grocery_staff/models/server_response_model.dart';
import 'package:shahid_grocery_staff/src/Screens/Address_Panel_Screen/Sub_Screens/add_address_screen.dart';
import 'package:shahid_grocery_staff/src/Screens/Delivery_Report_Panel_Screen/delivery_report_panel_screen.dart';
import 'package:shahid_grocery_staff/src/common_components/box_text_field.dart';
import 'package:shahid_grocery_staff/src/common_components/form_boiler_plate.dart';
import 'package:shahid_grocery_staff/src/common_components/text_field_container.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class DeliveryPanelScreen extends StatefulWidget {
  static String id = 'delivery_panel_screen';
  final String userName;
  final bool addAddress;
  final String serverMessage;
  final bool fromDeliveryReportScreen;
  final DeliveryData deliveryData;
  final DateTime dateTime;
  DeliveryPanelScreen(
      {this.addAddress = false,
      this.serverMessage,
      this.userName,
      this.fromDeliveryReportScreen = false,
      this.deliveryData,
      this.dateTime});
  @override
  _DeliveryPanelScreenState createState() => _DeliveryPanelScreenState();
}

class _DeliveryPanelScreenState extends State<DeliveryPanelScreen> {
  GlobalKey<AutoCompleteTextFieldState<AddressData>> _key = new GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<AddressData> _addressData;
  AddressData _selectedAddressData;
  DeliveryData _deliveryData;
  bool _singleSetState = true;
  bool _addressInputVisibility = true;
  String _value;
  int _serialNumber;
  int _cashRiyal = 0;
  int _cashHalala = 0;
  int _spnRiyal = 0;
  int _spnHalala = 0;
  int _creditRiyal = 0;
  int _creditHalala = 0;
  bool _visibility = false;
  TextEditingController initialText(String text) =>
      (widget.fromDeliveryReportScreen)
          ? TextEditingController(text: text)
          : null;

  void _visibilityState(bool boolean) {
    setState(() {
      _visibility = boolean;
    });
  }

  @override
  void initState() {
    if (widget.addAddress) {
      Future.delayed(Duration(milliseconds: 300)).then((_) => {
            SnackBarService.initSuccess(
                key: _scaffoldKey, message: widget.serverMessage)
          });
    }
    if (widget.fromDeliveryReportScreen) {
      _visibility = false;
      _deliveryData = widget.deliveryData;
      _serialNumber = int.parse(_deliveryData.serialNumber);
      _cashRiyal = int.parse(_deliveryData.cashRiyal);
      _cashHalala = int.parse(_deliveryData.cashHalala);
      _spnRiyal = int.parse(_deliveryData.spnRiyal);
      _spnHalala = int.parse(_deliveryData.spnHalala);
      _creditRiyal = int.parse(_deliveryData.creditRiyal);
      _creditHalala = int.parse(_deliveryData.creditHalala);
      _addressInputVisibility = false;
    } else
      _deliveryData = DeliveryData.values(
          'id', 'name', 'mobileNumber', 0, 0, 0, 0, 0, 0, 0, 'Staff', false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Staff.getAddressDetails(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AddressData>> snapShot) {
          if (snapShot.hasData) {
            _addressData = snapShot.data;

            if (widget.fromDeliveryReportScreen && _singleSetState) {
              _addressData.forEach((element) {
                if (element.mobileNumber == _deliveryData.mobileNumber)
                  _selectedAddressData = element;
              });
            }

            return Scaffold(
                key: _scaffoldKey,
                backgroundColor: kBodyBackgroundColor,
                appBar: AppBar(
                  title: Text('Delivery Panel'),
                ),
                body: FormBoilerPlate(
                  visibility: _visibility,
                  iconName: Icons.delivery_dining,
                  child: Column(
                    children: [
                      Visibility(
                        visible: _addressInputVisibility,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Icon(
                                Icons.home,
                                size: 40.0,
                                color: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: TextFieldContainer(
                                child: AutoCompleteTextField<AddressData>(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Delivery Address'),
                                  key: _key,
                                  itemSubmitted: (value) {
                                    setState(() {
                                      _selectedAddressData = value;
                                      _addressInputVisibility = false;
                                    });
                                  },
                                  suggestions: _addressData,
                                  itemBuilder: (context, suggestion) =>
                                      ListTile(
                                    title: Text(suggestion.name),
                                    subtitle: Text(suggestion.streetName),
                                    trailing: Text(suggestion.mobileNumber),
                                  ),
                                  itemSorter: (a, b) => 1,
                                  itemFilter: (suggestion, input) => suggestion
                                      .name
                                      .toLowerCase()
                                      .startsWith(input.toLowerCase()),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: FloatingActionButton(
                                  child: Icon(Icons.add),
                                  backgroundColor: Colors.green,
                                  mini: true,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddAddressScreen(
                                                  fromDeliveryScreen: true,
                                                  addressData: _addressData,
                                                )));
                                  },
                                ))
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _selectedAddressData != null ? true : false,
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Container(width: double.infinity)),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        'Deliver To : ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedAddressData = null;
                                              _addressInputVisibility = true;
                                              _singleSetState = false;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 0, 15.0, 15.0),
                                child: Container(
                                  width: Screen.width * 0.7,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _selectedAddressData != null
                                              ? _selectedAddressData.name
                                              : '',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _selectedAddressData != null
                                              ? _selectedAddressData
                                                  .buildingNumber
                                              : '',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          _selectedAddressData != null
                                              ? _selectedAddressData.streetName
                                              : '',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          _selectedAddressData != null
                                              ? _selectedAddressData.postalCode
                                              : '',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          _selectedAddressData != null
                                              ? _selectedAddressData
                                                  .mobileNumber
                                              : '',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'S.No',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: BoxTextField(
                              controller:
                                  initialText(_deliveryData.serialNumber),
                              prefixIcon:
                                  Icon(Icons.qr_code, color: kPrimaryColor),
                              hintText: 'Enter Serial Number',
                              onChanged: (value) {
                                _value = value;
                                if (value == '' || value == null)
                                  _serialNumber = null;
                                try {
                                  _serialNumber = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
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
                              'Cash',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: BoxTextField(
                              controller: initialText(_deliveryData.cashRiyal),
                              prefixIcon: Icon(
                                Icons.monetization_on,
                                color: Colors.green,
                              ),
                              hintText: 'Riyal',
                              onChanged: (value) {
                                _value = value;
                                try {
                                  _cashRiyal = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(width: Screen.width * 0.04),
                          Expanded(
                            flex: 4,
                            child: BoxTextField(
                              controller: initialText(_deliveryData.cashHalala),
                              prefixIcon: Icon(
                                Icons.monetization_on,
                                color: Colors.green,
                              ),
                              hintText: 'Halala',
                              onChanged: (value) {
                                _value = value;
                                try {
                                  _cashHalala = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
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
                              'SPN',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: BoxTextField(
                              controller: initialText(_deliveryData.spnRiyal),
                              prefixIcon: Icon(
                                Icons.point_of_sale,
                                color: Colors.deepPurple,
                              ),
                              hintText: 'Riyal',
                              onChanged: (value) {
                                _value = value;
                                try {
                                  _spnRiyal = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(width: Screen.width * 0.04),
                          Expanded(
                            flex: 4,
                            child: BoxTextField(
                              controller: initialText(_deliveryData.spnHalala),
                              prefixIcon: Icon(
                                Icons.point_of_sale,
                                color: Colors.deepPurple,
                              ),
                              hintText: 'Halala',
                              onChanged: (value) {
                                _value = value;
                                try {
                                  _spnHalala = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
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
                              'Credit',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: BoxTextField(
                              controller:
                                  initialText(_deliveryData.creditRiyal),
                              prefixIcon: Icon(
                                Icons.monetization_on,
                                color: Colors.red,
                              ),
                              hintText: 'Riyal',
                              onChanged: (value) {
                                _value = value;
                                try {
                                  _creditRiyal = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(width: Screen.width * 0.04),
                          Expanded(
                            flex: 4,
                            child: BoxTextField(
                              controller:
                                  initialText(_deliveryData.creditHalala),
                              prefixIcon: Icon(
                                Icons.monetization_on,
                                color: Colors.red,
                              ),
                              hintText: 'Halala',
                              onChanged: (value) {
                                _value = value;
                                try {
                                  _creditHalala = int.parse(value);
                                } catch (e) {
                                  if (_value != '')
                                    SnackBarService.warningOnTop(context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  buttonText: 'Submit',
                  buttonOnClick: () async {
                    _visibilityState(true);
                    if (_selectedAddressData == null ||
                        _serialNumber == null ||
                        _serialNumber == 0) {
                      SnackBarService.initAlert(
                          key: _scaffoldKey,
                          message: 'Address or Serial No is empty');
                      _visibilityState(false);
                    } else {
                      if (widget.fromDeliveryReportScreen) {
                        ServerResponse response =
                            await Staff.editDeliveryDetails(DeliveryData.values(
                                _deliveryData.id,
                                _selectedAddressData.name,
                                _selectedAddressData.mobileNumber,
                                _serialNumber,
                                _cashRiyal,
                                _cashHalala,
                                _spnRiyal,
                                _spnHalala,
                                _creditRiyal,
                                _creditHalala,
                                widget.userName,
                                null));
                        if (response.deliveryDetailsEdited) {
                          showAlert(
                              context: context,
                              alertType: AlertType.success,
                              message: response.message,
                              onPressed: () {
                                int count = 0;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DeliveryReportPanelScreen(
                                              userName: widget.userName,
                                              fromDeliveryPanel: true,
                                              dateTime: widget.dateTime,
                                            ))).then(
                                    (_) => Navigator.popUntil(context, (route) {
                                          return count++ == 1;
                                        }));
                              });
                          _visibilityState(false);
                        }
                      } else {
                        ServerResponse response =
                            await Staff.addDeliveryDetails(DeliveryData.values(
                                null,
                                _selectedAddressData.name,
                                _selectedAddressData.mobileNumber,
                                _serialNumber,
                                _cashRiyal,
                                _cashHalala,
                                _spnRiyal,
                                _spnHalala,
                                _creditRiyal,
                                _creditHalala,
                                widget.userName,
                                null));
                        if (response.deliveryDetailsSaved) {
                          showAlert(
                              context: context,
                              alertType: AlertType.success,
                              message: response.message,
                              onPressed: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              });
                        }
                      }
                    }
                  },
                ));
          } else
            return Scaffold(
              backgroundColor: kBodyBackgroundColor,
              appBar: AppBar(
                title: Text('Delivery Panel'),
              ),
              body: ModalProgressHUD(
                inAsyncCall: true,
                child: Text('Fetching data from Server'),
              ),
            );
        });
  }
}
