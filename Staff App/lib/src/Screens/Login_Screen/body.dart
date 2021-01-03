import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shahid_grocery_staff/common_services/screen_service.dart';
import 'package:shahid_grocery_staff/common_services/snackbar_service.dart';
import 'package:shahid_grocery_staff/common_services/staff_services.dart';
import 'package:shahid_grocery_staff/models/staff_data_model.dart';
import 'package:shahid_grocery_staff/src/Screens/Home_Screen/home_screen.dart';
import 'package:shahid_grocery_staff/src/common_components/rounded_button.dart';
import 'package:shahid_grocery_staff/src/common_components/rounded_password_field.dart';
import 'package:shahid_grocery_staff/src/common_components/text_field_container.dart';
import 'package:shahid_grocery_staff/utilities/constants.dart';

import 'background.dart';

class Body extends StatefulWidget {
  final List<StaffData> staffData;
  final String token;
  Body({@required this.staffData, @required this.token});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _passwordInput;
  String _truePasswordOfStaff;
  String _dropDownTitle = kDropDownTitle;
  List<DropdownMenuItem<String>> _items = [];

  void _passwordCorrect({@required String username}) async {
    await Staff.saveUserName(name: username);
    bool _tokenSaved = await Staff.saveJwtToken(token: widget.token);
    if (_tokenSaved)
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    userName: username,
                  )));
  }

  @override
  void initState() {
    super.initState();
    widget.staffData.forEach((element) {
      DropdownMenuItem<String> model = DropdownMenuItem(
        child: Text(element.username),
        value: element.password,
        onTap: () {
          setState(() {
            _dropDownTitle = element.username;
          });
        },
      );
      _items.add(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorizeAnimatedTextKit(
                  text: ["Shahid Grocery"],
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    fontFamily: "Horizon",
                    fontWeight: FontWeight.w900,
                  ),
                  colors: [
                    Colors.green,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                  repeatForever: true,
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
              SizedBox(height: Screen.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: Screen.height * 0.35,
              ),
              SizedBox(height: Screen.height * 0.03),
              TextFieldContainer(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                  child: DropdownButton(
                    items: _items,
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: kPrimaryColor,
                    ),
                    iconSize: 25.0,
                    isExpanded: true,
                    hint: Text(
                      _dropDownTitle,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: _dropDownTitle == kDropDownTitle
                            ? Color(0xFF635F6A)
                            : kPrimaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                      print(_dropDownTitle);
                      _truePasswordOfStaff = value;
                    },
                  ),
                ),
              ),
              RoundedPasswordField(
                hintText: "Please enter your password",
                onChanged: (value) {
                  _passwordInput = value;
                },
              ),
              RoundedButton(
                fontSize: 16.0,
                text: "LOGIN",
                onClick: () {
                  (_truePasswordOfStaff == null || _truePasswordOfStaff == '')
                      ? SnackBarService.warning(
                          context: context, message: 'Please select a username')
                      : (_passwordInput == null || _passwordInput == '')
                          ? SnackBarService.warning(
                              context: context,
                              message: 'Kindly provide a password')
                          : (_passwordInput == _truePasswordOfStaff)
                              ? _passwordCorrect(username: _dropDownTitle)
                              : SnackBarService.alert(
                                  context: context,
                                  message:
                                      'Wrong Password,Try Again or ask Admin');
                },
              ),
              SizedBox(height: Screen.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
