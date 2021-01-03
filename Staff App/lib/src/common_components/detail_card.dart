import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool visibility;
  final bool additionalText;
  final String text1;
  final String text2;
  final Function onDeletePressed;
  const DetailCard({
    Key key,
    @required this.title,
    @required this.subTitle,
    this.additionalText = false,
    this.text1 = '',
    this.text2 = '',
    this.onDeletePressed,
    this.visibility = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        child: Container(
          width: double.infinity,
          height: Screen.height * 0.14,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: kPrimaryLightColor,
                  radius: 30.0,
                  child: Text(
                    title[0].toUpperCase(),
                    style: TextStyle(fontSize: 40.0, color: kPrimaryColor),
                  ),
                ),
              ),
              SizedBox(width: Screen.width * 0.01),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                    Visibility(
                      visible: additionalText,
                      child: Text(
                        text1,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Visibility(
                      visible: additionalText,
                      child: Text(
                        text2,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Visibility(
                      visible: visibility,
                      child: SpinKitCircle(
                        color: kPrimaryColor,
                        size: 35.0,
                      ),
                    ),
                    Visibility(
                      visible: !visibility,
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Icon(
                            Icons.delete_outline,
                            color: Color(0xFFFB0A0A),
                            size: 26.0,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !visibility,
                      child: FlatButton(
                        height: double.infinity,
                        splashColor: kPrimaryColor.withOpacity(0.8),
                        onPressed: onDeletePressed,
                        child: null,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
