import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shahid_grocery_staff/models/address_data_model.dart';
import 'package:shahid_grocery_staff/models/delivery_data_model.dart';
import 'package:shahid_grocery_staff/models/server_response_model.dart';
import 'package:shahid_grocery_staff/models/staff_data_model.dart';
import 'package:shahid_grocery_staff/utilities/url.dart';

import 'http_services.dart';

class Staff {
  static final _storage = FlutterSecureStorage();
  static String _tokenKey = 'token';
  static String _nameKey = 'name';

  static Future<ServerResponse> initBackend() async {
    Map<String, dynamic> _response = await HttpService.get(kInitUrl);
    return ServerResponse.fromJson(_response);
  }

  static Future<ServerResponse> getStaffToken() async {
    Map<String, dynamic> _response = await HttpService.post(kGetTokenUrl, {});
    return ServerResponse.fromJson(_response);
  }

  static Future<bool> saveJwtToken({@required String token}) async {
    await _storage.write(key: _tokenKey, value: token);
    String tokenSavedNow = await readJwtToken(key: _tokenKey);
    return tokenSavedNow != null ? true : false;
  }

  static Future<bool> saveUserName({@required String name}) async {
    await _storage.write(key: _nameKey, value: name);
    String tokenSavedNow = await readJwtToken(key: _nameKey);
    return tokenSavedNow != null ? true : false;
  }

  static Future<String> readJwtToken({@required String key}) async {
    String token = await _storage.read(key: key);
    return token != null ? token : null;
  }

  static Future<bool> deleteToken({@required String key}) async {
    await _storage.delete(key: key);
    return true;
  }

  static Future<bool> doesTokenExist({@required String key}) async {
    String token = await _storage.read(key: key);
    return token != null ? true : false;
  }

  static Future<List<StaffData>> getStaffDetails() async {
    List<dynamic> _staffDetailsBody = await HttpService.get(kGetStaffUrl);
    List<StaffData> _staffData = _staffDetailsBody
        .map((dynamic jsonData) => StaffData.fromJson(jsonData))
        .toList();
    return _staffData;
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

  static Future<ServerResponse> addDeliveryDetails(
      DeliveryData deliveryData) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {
      "name": deliveryData.name,
      "mobileNumber": deliveryData.mobileNumber,
      "serialNumber": deliveryData.serialNumber,
      "cashRiyal": deliveryData.cashRiyal,
      "cashHalala": deliveryData.cashHalala,
      "spnRiyal": deliveryData.spnRiyal,
      "spnHalala": deliveryData.spnHalala,
      "creditRiyal": deliveryData.creditRiyal,
      "creditHalala": deliveryData.creditHalala,
      'staff': deliveryData.staff
    };
    Map<String, dynamic> response =
        await HttpService.post(kAddDeliveryDetailsUrl, _data, _token);
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

  static Future<ServerResponse> editDeliveryDetails(
      DeliveryData deliveryData) async {
    String _token = await readJwtToken(key: _tokenKey);
    Map<String, dynamic> _data = {
      "id": deliveryData.id,
      "name": deliveryData.name,
      "mobileNumber": deliveryData.mobileNumber,
      "serialNumber": deliveryData.serialNumber,
      "cashRiyal": deliveryData.cashRiyal,
      "cashHalala": deliveryData.cashHalala,
      "spnRiyal": deliveryData.spnRiyal,
      "spnHalala": deliveryData.spnHalala,
      "creditRiyal": deliveryData.creditRiyal,
      "creditHalala": deliveryData.creditHalala,
      'staff': deliveryData.staff
    };
    Map<String, dynamic> response =
        await HttpService.post(kEditDeliveryDetails, _data, _token);
    return ServerResponse.fromJson(response);
  }
}
