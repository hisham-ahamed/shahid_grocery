import 'package:flutter/cupertino.dart';

class AddressData {
  final String name;
  final String mobileNumber;
  final String buildingNumber;
  final String streetName;
  final String postalCode;
  final String additional;
  AddressData(
      {@required this.name,
      @required this.mobileNumber,
      this.buildingNumber,
      this.streetName,
      this.postalCode,
      this.additional});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
        name: json['name'] as String,
        mobileNumber: json['mobileNumber'] as String,
        buildingNumber: json['buildingNumber'] as String,
        streetName: json['streetName'] as String,
        postalCode: json['postalCode'] as String,
        additional: json['additional'] as String);
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
}
