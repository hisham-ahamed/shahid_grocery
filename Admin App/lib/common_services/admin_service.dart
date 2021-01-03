import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shahid_grocery_admin/common_services/snackbar_service.dart';
import 'package:shahid_grocery_admin/models/address_data_model.dart';
import 'package:shahid_grocery_admin/models/delivery_data_model.dart';
import 'package:shahid_grocery_admin/models/server_response_data_model.dart';
import 'package:shahid_grocery_admin/models/staff_data_model.dart';
import 'package:shahid_grocery_admin/utilities/url.dart';

import 'http_service.dart';

enum Validation { valid, invalid, empty }

class Admin {
  static final _storage = FlutterSecureStorage();
  static String _username = 'Mufeed';
  static String _tokenKey = 'token';

  static Validation _validatePassword(String passwordA, String passwordB) {
    return (passwordB != passwordA)
        ? Validation.invalid
        : (passwordA == null || passwordB == null)
            ? Validation.empty
            : (passwordA == '' || passwordB == '')
                ? Validation.empty
                : Validation.valid;
  }

  static Future<ServerResponse> login({@required String password}) async {
    Map<String, dynamic> _data = {'username': _username, 'password': password};
    Map<String, dynamic> _response =
        await HttpService.post(kAdminLoginUrl, _data);
    return ServerResponse.fromJson(_response);
  }

  static Future<ServerResponse> initBackend() async {
    Map<String, dynamic> _response = await HttpService.get(kInitUrl);
    return ServerResponse.fromJson(_response);
  }

  static Future<bool> saveJwtToken({@required String token}) async {
    await _storage.write(key: _tokenKey, value: token);
    String tokenSavedNow = await readJwtToken(key: _tokenKey);
    return tokenSavedNow != null ? true : false;
  }

  static Future<String> readJwtToken({@required String key}) async {
    String token = await _storage.read(key: key);
    return token != null ? token : null;
  }

  static Future<bool> doesTokenExist({@required String key}) async {
    String token = await _storage.read(key: key);
    return token != null ? true : false;
  }

  static Future<bool> deleteToken({@required String key}) async {
    await _storage.delete(key: key);
    return true;
  }

  static Future<ServerResponse> changePassword(
      {@required String passwordA,
      @required String passwordB,
      @required BuildContext context}) async {
    Validation _validation = _validatePassword(passwordA, passwordB);
    if (_validation == Validation.invalid) {
      SnackBarService.alert(
          context: context, message: 'Passwords do not match');
    }
    if (_validation == Validation.empty) {
      SnackBarService.warning(
          context: context, message: 'Password fields empty');
    }
    if (_validation == Validation.valid) {
      String _token = await readJwtToken(key: _tokenKey);
      Map<String, dynamic> response = await HttpService.post(
          kPasswordChangeUrl, {'password': passwordB}, _token);
      return ServerResponse.fromJson(response);
    } else
      return null;
  }

  static Future<List<StaffData>> getStaffDetails() async {
    List<dynamic> _staffDetailsBody = await HttpService.get(kGetStaffUrl);
    List<StaffData> _staffData = _staffDetailsBody
        .map((dynamic jsonData) => StaffData.fromJson(jsonData))
        .toList();
    return _staffData;
  }

  static Future<ServerResponse> addStaffDetails(StaffData staffData) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {
      'username': staffData.username,
      'mobileNumber': staffData.mobileNumber,
      'password': staffData.password
    };
    Map<String, dynamic> response =
        await HttpService.post(kAddStaffUrl, _data, _token);
    return ServerResponse.fromJson(response);
  }

  static Future<ServerResponse> deleteStaff(String mobileNumber) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {'mobileNumber': mobileNumber};
    Map<String, dynamic> response =
        await HttpService.post(kDeleteStaffUrl, _data, _token);
    return ServerResponse.fromJson(response);
  }

  static Future<List<AddressData>> getAddressDetails() async {
    List<dynamic> _addressDetailsBody = await HttpService.get(kGetAddressUrl);
    List<AddressData> _addressData = _addressDetailsBody
        .map((dynamic jsonData) => AddressData.fromJson(jsonData))
        .toList();
    return _addressData;
  }

  static Future<ServerResponse> deleteAddress(String mobileNumber) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {'mobileNumber': mobileNumber};
    Map<String, dynamic> response =
        await HttpService.post(kDeleteAddressUrl, _data, _token);
    return ServerResponse.fromJson(response);
  }

  static Future<ServerResponse> addAddressDetails(
      AddressData addressData) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {
      "name": addressData.name,
      "mobileNumber": addressData.mobileNumber,
      "buildingNumber": addressData.buildingNumber,
      "streetName": addressData.streetName,
      "postalCode": addressData.postalCode,
      "additional": addressData.additional
    };
    Map<String, dynamic> response =
        await HttpService.post(kAddAddressUrl, _data, _token);
    return ServerResponse.fromJson(response);
  }

  static Future<List<DeliveryData>> getDeliveryDetails(
      DateTime dateTime) async {
    DateTime _start = DateTime.utc(dateTime.year, dateTime.month, dateTime.day);
    DateTime _end =
        DateTime.utc(dateTime.year, dateTime.month, dateTime.day + 1);
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {
      "start": _start.toString(),
      "end": _end.toString()
    };
    List<dynamic> _deliveryDetailsBody =
        await HttpService.post(kDeliveryDetailsUrl, _data, _token);
    List<DeliveryData> _deliveryData = _deliveryDetailsBody
        .map((dynamic jsonData) => DeliveryData.fromJson(jsonData))
        .toList();
    return _deliveryData;
  }

  static Future<ServerResponse> updateDeliveryCheck(
      DeliveryData deliveryData, bool checkValue) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {
      "id": deliveryData.id,
      "checkValue": checkValue,
    };
    Map<String, dynamic> response =
        await HttpService.post(kUpdateDeliveryCheck, _data, _token);
    return ServerResponse.fromJson(response);
  }
}
