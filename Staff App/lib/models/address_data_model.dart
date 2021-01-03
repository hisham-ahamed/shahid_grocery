import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddressData {
  final String id;
  final String name;
  final String mobileNumber;
  final String buildingNumber;
  final String streetName;
  final String postalCode;
  final String additional;
  final String date;
  AddressData(
      {this.id,
      @required this.name,
      @required this.mobileNumber,
      this.buildingNumber,
      this.streetName,
      this.postalCode,
      this.additional,
      this.date});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
        id: json['_id'] as String,
        name: json['name'] as String,
        mobileNumber: json['mobileNumber'] as String,
        buildingNumber: json['buildingNumber'] as String,
        streetName: json['streetName'] as String,
        postalCode: json['postalCode'] as String,
        additional: json['additional'] as String,
        date: json['date'] as String);
  }

  factory AddressData.values(
      String name,
      String mobileNumber,
      String buildingNumber,
      String streetName,
      String postalCode,
      String additional) {
    return AddressData(
        name: name,
        mobileNumber: mobileNumber,
        buildingNumber: buildingNumber,
        streetName: streetName,
        postalCode: postalCode,
        additional: additional);
  }

  static Map<String, dynamic> toJson(AddressData addressData) {
    Map<String, dynamic> json = Map();
    json['_id'] = addressData.id;
    json['name'] = addressData.name;
    json['mobileNumber'] = addressData.mobileNumber;
    json['postalCode'] = addressData.postalCode;
    json['streetName'] = addressData.streetName;
    json['buildingNumber'] = addressData.buildingNumber;
    json['additional'] = addressData.additional;
    json['date'] = addressData.date;
    return json;
  }

  static String toJsonString(List<AddressData> addressData) {
    String _fullString = '[';
    addressData.forEach((element) {
      if (addressData.indexOf(element) != 0) _fullString += ',';
      _fullString += jsonEncode(AddressData.toJson(element));
    });
    _fullString += ']';
    return _fullString;
  }
}
