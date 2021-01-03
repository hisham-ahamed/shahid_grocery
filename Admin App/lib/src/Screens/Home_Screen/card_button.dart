import 'package:flutter/material.dart';
import 'package:shahid_grocery_admin/utilities/constants.dart';

class CardButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final Icon icon;
  final Text text;
  CardButton({
    this.color = kPrimaryColor,
    this.onPressed,
    this.icon,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Container(child: icon),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    children: [
                      Divider(
                        height: 1.0,
                        color: Colors.grey,
                        thickness: 1.3,
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(child: text),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            splashColor: color.withOpacity(0.5),
            onPressed: onPressed,
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
