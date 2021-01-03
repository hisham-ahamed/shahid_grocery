import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final Icon suffixIcon;
  final String hintText;
  final int maxLines;
  final bool lockIconVisibility;
  RoundedPasswordField(
      {Key key,
      this.onChanged,
      this.obscureText = true,
      this.suffixIcon,
      this.hintText = "Password",
      this.maxLines = 1,
      this.lockIconVisibility = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        maxLines: maxLines,
        obscureText: obscureText,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Visibility(
            visible: lockIconVisibility,
            child: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
