import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/models/delivery_data_model.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class OutputCard extends StatefulWidget {
  final bool cashVisibility;
  final bool spnVisibility;
  final bool creditVisibility;
  final bool deliverToVisibility;
  final bool staffNameVisibility;
  final DeliveryData deliveryData;
  final Function editButtonOnChanged;
  OutputCard(
      {Key key,
      this.cashVisibility = true,
      this.spnVisibility = true,
      this.creditVisibility = true,
      this.deliverToVisibility = true,
      this.staffNameVisibility = true,
      this.deliveryData,
      this.editButtonOnChanged})
      : super(key: key);

  @override
  _OutputCardState createState() => _OutputCardState();
}

class _OutputCardState extends State<OutputCard> {
  double _screenWidth = Screen.width * 0.235;

  double _screenHeight = Screen.height * 0.08;

  Decoration _decoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 0.5, color: Colors.grey),
      right: BorderSide(width: 0.5, color: Colors.grey),
    ),
    color: kBodyBackgroundColor,
  );

  Widget widgetToShow(String money, String subMoney, Color color) {
    int _riyal = int.parse(money);
    int _halala = int.parse(subMoney);
    return (_riyal != 0 || _halala != 0)
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  money,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: color,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    subMoney,
                    style: TextStyle(fontSize: 20, color: color),
                  ),
                ),
              ],
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  decoration: _decoration,
                  width: Screen.width * 0.1,
                  height: _screenHeight,
                  child: Center(
                      child: FlatButton(
                    splashColor: kPrimaryColor.withOpacity(0.5),
                    child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        )),
                    onPressed: widget.editButtonOnChanged,
                  ))),
              Container(
                  decoration: _decoration,
                  width: Screen.width * 0.15,
                  height: _screenHeight,
                  child: Center(
                    child: Text(
                      widget.deliveryData.serialNumber,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    ),
                  )),
              Visibility(
                visible: widget.cashVisibility,
                child: Container(
                    decoration: _decoration,
                    width: _screenWidth,
                    height: _screenHeight,
                    child: widgetToShow(widget.deliveryData.cashRiyal,
                        widget.deliveryData.cashHalala, Colors.green)),
              ),
              Visibility(
                visible: widget.spnVisibility,
                child: Container(
                    decoration: _decoration,
                    width: _screenWidth,
                    height: _screenHeight,
                    child: widgetToShow(widget.deliveryData.spnRiyal,
                        widget.deliveryData.spnHalala, Colors.blue)),
              ),
              Visibility(
                visible: widget.creditVisibility,
                child: Container(
                    decoration: _decoration,
                    width: _screenWidth,
                    height: _screenHeight,
                    child: widgetToShow(widget.deliveryData.creditRiyal,
                        widget.deliveryData.creditHalala, Colors.red)),
              ),
              Visibility(
                visible: widget.deliverToVisibility,
                child: Container(
                    decoration: _decoration,
                    width: Screen.width * 0.4,
                    height: _screenHeight,
                    child: Center(
                      child: Text(
                        widget.deliveryData.name,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    )),
              ),
              Visibility(
                visible: widget.staffNameVisibility,
                child: Container(
                    decoration: _decoration,
                    width: Screen.width * 0.4,
                    height: _screenHeight,
                    child: Center(
                      child: Text(
                        widget.deliveryData.staff,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
