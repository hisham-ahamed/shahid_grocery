import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/models/delivery_data_model.dart';
import 'package:shahid_grocery_staff/src/Screens/Delivery_Panel_Screen/delivery_panel_screen.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

import 'components/output_card.dart';
import 'components/output_heading.dart';

class DeliveryReportPanelScreen extends StatefulWidget {
  static String id = 'delivery_report_panel_screen';
  final String userName;
  final bool fromDeliveryPanel;
  final DateTime dateTime;
  DeliveryReportPanelScreen(
      {this.userName, this.fromDeliveryPanel = false, this.dateTime});
  @override
  _DeliveryReportPanelScreenState createState() =>
      _DeliveryReportPanelScreenState();
}

class _DeliveryReportPanelScreenState extends State<DeliveryReportPanelScreen> {
  GlobalKey _outputHeading = GlobalKey();
  bool _filterCash = false;
  bool _filterSpn = false;
  bool _filterCredit = false;
  bool _filterStaff = true;
  bool _dataReceived = false;
  bool _cashVisibility = true;
  bool _spnVisibility = true;
  bool _deliverToVisibility = true;
  bool _staffNameVisibility = false;
  bool _creditVisibility = true;
  bool _doubleSetStateProtection = false;
  double _totalCashRiyal = 0.0;
  double _totalCashHalala = 0.0;
  double _totalSpnRiyal = 0.0;
  double _totalSpnHalala = 0.0;
  double _totalCreditRiyal = 0.0;
  double _totalCreditHalala = 0.0;
  String _selectedStaffName;
  List<DeliveryData> _deliveryData = [];
  List<DeliveryData> _sortedData;
  List<DeliveryData> _tempSort = [];
  List<DeliveryData> _tempSortForStaff = [];
  DateTime _dateSelected;

  void _clearSum() {
    _totalCashRiyal = 0.0;
    _totalCashHalala = 0.0;
    _totalSpnRiyal = 0.0;
    _totalSpnHalala = 0.0;
    _totalCreditRiyal = 0.0;
    _totalCreditHalala = 0.0;
  }

  void _sum(List<DeliveryData> deliveryData) {
    deliveryData.forEach((element) {
      _totalCashRiyal += double.parse(element.cashRiyal);
      _totalCashHalala += double.parse(element.cashHalala);
      _totalSpnRiyal += double.parse(element.spnRiyal);
      _totalSpnHalala += double.parse(element.spnHalala);
      _totalCreditRiyal += double.parse(element.creditRiyal);
      _totalCreditHalala += double.parse(element.creditHalala);
    });
    _totalCashRiyal = _totalCashRiyal + (_totalCashHalala / 100);
    _totalSpnRiyal = _totalSpnRiyal + (_totalSpnHalala / 100);
    _totalCreditRiyal = _totalCreditRiyal + (_totalCreditHalala / 100);
  }

  Future<double> _getOutputHeadingWidth() async {
    RenderBox _renderBox;
    await Future.delayed(Duration(microseconds: 10),
        () => _renderBox = _outputHeading.currentContext.findRenderObject());
    return _renderBox.size.width;
  }

  @override
  void initState() {
    _dateSelected = widget.fromDeliveryPanel ? widget.dateTime : DateTime.now();
    _selectedStaffName = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
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
                        "Filter Report",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ))),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child: Text('View By :',
                      style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                ),
                Divider(thickness: 2.0),
                ListTile(
                  title: Text('Cash', style: TextStyle(fontSize: 17.0)),
                  trailing: Checkbox(
                    value: _filterCash,
                    onChanged: (value) {
                      if (value) {
                        _cashVisibility = true;
                        _spnVisibility = false;
                        _creditVisibility = false;
                        _filterSpn = !value;
                        _filterCredit = !value;
                      } else {
                        _spnVisibility = true;
                        _cashVisibility = true;
                        _creditVisibility = true;
                      }

                      setState(() {
                        _filterCash = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('SPN', style: TextStyle(fontSize: 17.0)),
                  trailing: Checkbox(
                    value: _filterSpn,
                    onChanged: (value) {
                      if (value) {
                        _spnVisibility = true;
                        _cashVisibility = false;
                        _creditVisibility = false;
                        _filterCash = !value;
                        _filterCredit = !value;
                      } else {
                        _spnVisibility = true;
                        _cashVisibility = true;
                        _creditVisibility = true;
                      }
                      setState(() {
                        _filterSpn = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Credit', style: TextStyle(fontSize: 17.0)),
                  trailing: Checkbox(
                    value: _filterCredit,
                    onChanged: (value) {
                      if (value) {
                        _creditVisibility = true;
                        _cashVisibility = false;
                        _spnVisibility = false;
                        _filterCash = !value;
                        _filterSpn = !value;
                      } else {
                        _spnVisibility = true;
                        _cashVisibility = true;
                        _creditVisibility = true;
                      }

                      setState(() {
                        _filterCredit = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child: Text('Hide/Show Panel : ',
                      style: TextStyle(fontSize: 20.0, color: Colors.grey)),
                ),
                Divider(thickness: 2.0),
                ListTile(
                  title: Text('Delivered To', style: TextStyle(fontSize: 17.0)),
                  trailing: Checkbox(
                    value: _deliverToVisibility,
                    onChanged: (value) {
                      setState(() {
                        _deliverToVisibility = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _dataReceived
          ? BottomAppBar(
              color: kBodyBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 18.0, 4, 18.0),
                child: Row(
                  children: [
                    Visibility(
                      visible: _cashVisibility,
                      child: Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Icon(Icons.monetization_on,
                                    color: Colors.green)),
                            Expanded(
                              flex: 8,
                              child: Text(
                                _totalCashRiyal.toString(),
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _spnVisibility,
                      child: Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Icon(Icons.point_of_sale,
                                    color: Colors.blue)),
                            Expanded(
                              flex: 8,
                              child: Text(
                                _totalSpnRiyal.toString(),
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _creditVisibility,
                      child: Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Icon(Icons.monetization_on,
                                    color: Colors.red)),
                            Expanded(
                              flex: 8,
                              child: Text(
                                _totalCreditRiyal.toString(),
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      backgroundColor: kBodyBackgroundColor,
      appBar: AppBar(
        title: Text('Delivery Report Panel'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text(
                    '${_dateSelected.day}/${_dateSelected.month}/${_dateSelected.year}',
                    style: TextStyle(color: kPrimaryColor, fontSize: 35.0),
                  ),
                  onPressed: () async {
                    final _datePicked = await showDatePicker(
                        context: context,
                        initialDate: _dateSelected,
                        firstDate: DateTime(2015, 1),
                        lastDate: DateTime(2100));
                    if (_datePicked != null && _datePicked != _dateSelected)
                      setState(() {
                        _dateSelected = _datePicked;
                        _dataReceived = false;
                      });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 85,
              child: Builder(builder: (BuildContext context) {
                if (_dataReceived) {
                  if (_deliveryData[0].id != '404') {
                    _sortedData = _deliveryData;
                    _clearSum();
                    _sum(_deliveryData);
                    if (_filterCash) {
                      _tempSort.clear();
                      _deliveryData.forEach((element) {
                        if (element.cashRiyal != '0')
                          _tempSort.add(element);
                        else if (element.cashHalala != '0')
                          _tempSort.add(element);
                      });
                      _tempSort.sort((a, b) => int.parse(a.serialNumber)
                          .compareTo(int.parse(b.serialNumber)));

                      _sortedData = _tempSort;
                    }

                    if (_filterSpn) {
                      _tempSort.clear();
                      _deliveryData.forEach((element) {
                        if (element.spnRiyal != '0')
                          _tempSort.add(element);
                        else if (element.spnHalala != '0')
                          _tempSort.add(element);
                      });
                      _tempSort.sort((a, b) => int.parse(a.serialNumber)
                          .compareTo(int.parse(b.serialNumber)));

                      _sortedData = _tempSort;
                    }

                    if (_filterCredit) {
                      _tempSort.clear();
                      _deliveryData.forEach((element) {
                        if (element.creditRiyal != '0')
                          _tempSort.add(element);
                        else if (element.creditHalala != '0')
                          _tempSort.add(element);
                      });
                      _tempSort.sort((a, b) => int.parse(a.serialNumber)
                          .compareTo(int.parse(b.serialNumber)));
                      _sortedData = _tempSort;
                    }

                    if (_filterStaff && _selectedStaffName != null) {
                      _tempSortForStaff.clear();
                      _sortedData.forEach((element) {
                        if (element.staff == _selectedStaffName)
                          _tempSortForStaff.add(element);
                      });
                      _sortedData = _tempSortForStaff;

                      if (_doubleSetStateProtection == false)
                        Future.delayed(Duration(microseconds: 3))
                            .then((value) => setState(() {
                                  _clearSum();
                                  _sum(_sortedData);
                                }));
                      _doubleSetStateProtection = !_doubleSetStateProtection;
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutputHeading(
                            key: _outputHeading,
                            cashVisibility: _cashVisibility,
                            spnVisibility: _spnVisibility,
                            creditVisibility: _creditVisibility,
                            deliverToVisibility: _deliverToVisibility,
                            staffNameVisibility: _staffNameVisibility,
                          ),
                          Expanded(
                            flex: 9,
                            child: FutureBuilder(
                                future: _getOutputHeadingWidth(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<double> snapshot) {
                                  return (snapshot.hasData)
                                      ? Container(
                                          alignment: Alignment.topLeft,
                                          width: snapshot.data,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: _sortedData.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return OutputCard(
                                                  deliverToVisibility:
                                                      _deliverToVisibility,
                                                  staffNameVisibility:
                                                      _staffNameVisibility,
                                                  cashVisibility:
                                                      _cashVisibility,
                                                  spnVisibility: _spnVisibility,
                                                  creditVisibility:
                                                      _creditVisibility,
                                                  deliveryData:
                                                      _sortedData[index],
                                                  editButtonOnChanged: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DeliveryPanelScreen(
                                                                  dateTime:
                                                                      _dateSelected,
                                                                  userName: widget
                                                                      .userName,
                                                                  fromDeliveryReportScreen:
                                                                      true,
                                                                  deliveryData:
                                                                      _sortedData[
                                                                          index],
                                                                )));
                                                  },
                                                );
                                              }),
                                        )
                                      : Container();
                                }),
                          ),
                        ],
                      ),
                    );
                  } else
                    return Text('No Records found for this date',
                        style: TextStyle(color: Colors.red, fontSize: 20.0));
                } else
                  return FutureBuilder(
                      future: Staff.getDeliveryDetails(_dateSelected),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<DeliveryData>> snapshot) {
                        if (snapshot.hasData) {
                          _deliveryData = snapshot.data;
                          _deliveryData.sort((a, b) => int.parse(a.serialNumber)
                              .compareTo(int.parse(b.serialNumber)));
                          _clearSum();
                          _sum(_deliveryData);
                          Future.delayed(Duration(milliseconds: 1))
                              .then((_) => setState(() {
                                    _dataReceived = true;
                                  }));
                          return Text('Data Fetched');
                        } else
                          return Column(
                            children: [
                              SizedBox(height: Screen.height * 0.05),
                              Text('Fetching Data from server..',
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18.0)),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SpinKitPouringHourglass(
                                    color: kPrimaryColor),
                              ),
                            ],
                          );
                      });
              }),
            )
          ],
        ),
      ),
    );
  }
}
