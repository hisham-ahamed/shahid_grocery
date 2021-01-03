import 'package:flutter/material.dart';
import 'package:shahid_grocery_admin/common_services/screen_service.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

class OutputHeading extends StatefulWidget {
  final bool cashVisibility;
  final bool spnVisibility;
  final bool creditVisibility;
  final bool deliverToVisibility;
  final bool staffNameVisibility;
  OutputHeading(
      {Key key,
      this.cashVisibility = true,
      this.spnVisibility = true,
      this.creditVisibility = true,
      this.deliverToVisibility = true,
      this.staffNameVisibility = true})
      : super(key: key);

  @override
  _OutputHeadingState createState() => _OutputHeadingState();
}

class _OutputHeadingState extends State<OutputHeading> {
  double _screenWidth = Screen.width * 0.235;

  double _screenHeight = Screen.height * 0.08;

  Decoration _decoration = BoxDecoration(
    border: Border(
      top: BorderSide(width: 0.5, color: Colors.grey),
      bottom: BorderSide(width: 0.5, color: Colors.grey),
      right: BorderSide(width: 0.5, color: Colors.grey),
      // left: BorderSide(width: 0.5, color: Colors.grey),
    ),
    color: kBodyBackgroundColor,
  );

  Widget heading(IconData iconData, String heading, [Color iconColor]) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        iconData,
        color: iconColor == null ? Colors.grey : iconColor,
      ),
      Text(heading,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: _decoration,
            width: Screen.width * 0.1,
            height: _screenHeight,
            child: Center(child: null)),
        Container(
            decoration: _decoration,
            width: Screen.width * 0.15,
            height: _screenHeight,
            child: Center(
              child: heading(Icons.qr_code, 'S.No'),
            )),
        Visibility(
          visible: widget.cashVisibility,
          child: Container(
              decoration: _decoration,
              width: _screenWidth,
              height: _screenHeight,
              child: Center(
                  child: heading(
                      Icons.monetization_on, 'Cash', Color(0xFF15632a)))),
        ),
        Visibility(
          visible: widget.spnVisibility,
          child: Container(
              decoration: _decoration,
              width: _screenWidth,
              height: _screenHeight,
              child: Center(
                  child:
                      heading(Icons.point_of_sale, 'SPN', Color(0xFF154463)))),
        ),
        Visibility(
          visible: widget.creditVisibility,
          child: Container(
              decoration: _decoration,
              width: _screenWidth,
              height: _screenHeight,
              child: Center(
                  child: heading(
                      Icons.monetization_on, 'Credit', Color(0xFF9c1010)))),
        ),
        Visibility(
          visible: widget.deliverToVisibility,
          child: Container(
              decoration: _decoration,
              width: Screen.width * 0.4,
              height: _screenHeight,
              child: Center(
                child: heading(Icons.home, 'Delivered to'),
              )),
        ),
        Visibility(
          visible: widget.staffNameVisibility,
          child: Container(
              decoration: _decoration,
              width: Screen.width * 0.4,
              height: _screenHeight,
              child: Center(child: heading(Icons.person, 'Staff Name'))),
        ),
      ],
    );
  }
}
