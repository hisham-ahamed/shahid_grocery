import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shahid_grocery_staff/common_services/snackbar_service.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/models/address_data_model.dart';
import 'package:shahid_grocery_staff/models/server_response_model.dart';
import 'package:shahid_grocery_staff/src/common_components/detail_card.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

import 'Sub_Screens/add_address_screen.dart';

class AddressPanelScreen extends StatefulWidget {
  static String id = "address_panel_screen";
  final bool addAddress;
  final String serverMessage;
  final bool dataReceived;
  final List<AddressData> addressData;

  AddressPanelScreen(
      {this.addAddress = false,
      this.serverMessage,
      this.dataReceived = false,
      this.addressData});
  @override
  _AddressPanelScreenState createState() => _AddressPanelScreenState();
}

class _AddressPanelScreenState extends State<AddressPanelScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _dataReceived = false;
  List<bool> _visibility = [];
  List<AddressData> _addressData;
  List<AddressData> _searchResult = [];
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
    if (widget.dataReceived) _addressData = widget.addressData;
    if (widget.addAddress) {
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
        title: Text('Address Panel'),
      ),
      body: Builder(builder: (context) {
        if (_dataReceived) {
          print(_addressData.length);
          _searchResult.clear();
          _addressData.forEach((element) {
            if (element.name.toLowerCase().contains(_searchQuery)) {
              _searchResult.add(element);
            }
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 4.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                        '${_searchResult.length} ${_searchResult.length > 1 ? 'results' : 'result'} found'),
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
                          additionalText: true,
                          title: _searchResult[index].name,
                          subTitle: _searchResult[index].mobileNumber,
                          text1: _searchResult[index].buildingNumber,
                          text2: _searchResult[index].streetName,
                          onDeletePressed: () async {
                            _visibilityState(index, true);
                            ServerResponse _serverResponse =
                                await Staff.deleteAddress(
                                    _searchResult[index].mobileNumber);
                            if (_serverResponse.addressdeleted) {
                              _addressData.removeWhere((element) =>
                                  element.mobileNumber ==
                                  _searchResult[index].mobileNumber);
                              SnackBarService.success(
                                  context: context,
                                  message: _serverResponse.message);
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
                                  builder: (context) => AddAddressScreen(
                                        addressData: _addressData,
                                      )));
                        },
                      ),
                    ))
              ],
            ),
          );
        } else
          return FutureBuilder(
              future: Staff.getAddressDetails(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AddressData>> snapshot) {
                if (snapshot.hasData) {
                  _addressData = snapshot.data;
                  _addressData.sort((a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                  Future.delayed(Duration(milliseconds: 1)).then((_) => {
                        setState(() {
                          _dataReceived = true;
                        })
                      });
                  return Text('Data Fetched..');
                } else
                  return ModalProgressHUD(
                      inAsyncCall: true,
                      child: Text('Fetching Data from Server..'));
              });
      }),
    );
  }
}
