import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shahid_grocery_staff/common_services/http_services.dart';
import 'package:shahid_grocery_staff/common_services/offline_services.dart';
import 'package:shahid_grocery_staff/models/address_data_model.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';
import 'package:shahid_grocery_staff/utilities/url.dart';

class SyncScreen extends StatefulWidget {
  static String id = 'sync_screen';
  @override
  _SyncScreenState createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  List<AddressData> _addressDataFromServer;
  List<AddressData> _addressDataFromLocal;
  List<AddressData> _extraAddressList;
  bool _hasData = false;
  bool _addressFileExists = false;
  String _addressContentToSave;
  String _retrievedAddressContent;

  void futureEvents() async {
    _addressFileExists = await Offline.doFileExist(Offline.address);
    if (_addressFileExists) {
      _retrievedAddressContent = await Offline.readFromLocal(Offline.address);
      _addressDataFromLocal =
          Offline.jsonStringToAddressDataList(_retrievedAddressContent);
    }
  }

  Future<List<AddressData>> fromServer() async {
    _addressContentToSave = await HttpService.getWithoutDecode(kGetAddressUrl);
    List<AddressData> _addressDataList =
        Offline.jsonStringToAddressDataList(_addressContentToSave);
    return _addressDataList;
  }

  @override
  void initState() {
    futureEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyBackgroundColor,
      appBar: AppBar(
        title: Text('Sync'),
      ),
      body: Builder(builder: (BuildContext context) {
        if (_hasData) {
          if (!_addressFileExists) {
            Offline.saveToLocal(Offline.address, _addressContentToSave);
            _retrievedAddressContent = _addressContentToSave;
            _addressDataFromLocal =
                Offline.jsonStringToAddressDataList(_retrievedAddressContent);
            _addressFileExists = !_addressFileExists;
          }
          _addressDataFromLocal.forEach((element) {
            if (_addressDataFromServer[_addressDataFromLocal.indexOf(element)]
                    .id ==
                element.id) print('Yes ' + element.name);
          });
          return Text(_retrievedAddressContent);
        } else
          return FutureBuilder(
              future: fromServer(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AddressData>> snapshot) {
                if (snapshot.hasData) {
                  Future.delayed(Duration(microseconds: 2))
                      .then((_) => setState(() {
                            _hasData = true;
                            _addressDataFromServer = snapshot.data;
                          }));
                  return Text('Fetched');
                } else
                  return ModalProgressHUD(
                      inAsyncCall: true,
                      child: Text('Fetching Data from Server'));
              });
      }),
    );
  }
}
