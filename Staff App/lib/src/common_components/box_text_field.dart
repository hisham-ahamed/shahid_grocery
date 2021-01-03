import 'package:flutter/material.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

import 'text_field_container.dart';

class BoxTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Icon suffixIcon;
  final Icon prefixIcon;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  BoxTextField(
      {Key key,
      this.onChanged,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText = "Password",
      this.maxLines = 1,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      radius: 0,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          icon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
