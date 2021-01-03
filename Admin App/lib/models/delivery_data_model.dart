import 'package:flutter/foundation.dart';

class DeliveryData {
  final String id;
  final String name;
  final String mobileNumber;
  final String serialNumber;
  final String cashRiyal;
  final String cashHalala;
  final String spnRiyal;
  final String spnHalala;
  final String creditRiyal;
  final String creditHalala;
  final String staff;
  final bool checkValue;
  DeliveryData(
      {this.id,
      @required this.name,
      @required this.mobileNumber,
      @required this.serialNumber,
      @required this.cashRiyal,
      @required this.cashHalala,
      @required this.spnRiyal,
      @required this.spnHalala,
      @required this.creditRiyal,
      @required this.creditHalala,
      @required this.staff,
      @required this.checkValue});

  factory DeliveryData.values(
      String id,
      String name,
      String mobileNumber,
      int serialNumber,
      int cashRiyal,
      int cashHalala,
      int spnRiyal,
      int spnHalala,
      int creditRiyal,
      int creditHalala,
      String staff,
      bool checkValue) {
    return DeliveryData(
        id: id,
        name: name,
        mobileNumber: mobileNumber,
        serialNumber: serialNumber.toString(),
        cashRiyal: cashRiyal.toString(),
        cashHalala: cashHalala.toString(),
        spnRiyal: spnRiyal.toString(),
        spnHalala: spnHalala.toString(),
        creditRiyal: creditRiyal.toString(),
        creditHalala: creditHalala.toString(),
        staff: staff,
        checkValue: checkValue);
  }

  factory DeliveryData.onlyCheckValue(DeliveryData deliveryData, bool value) {
    return DeliveryData(
        name: deliveryData.name,
        mobileNumber: deliveryData.mobileNumber,
        serialNumber: deliveryData.serialNumber,
        cashRiyal: deliveryData.cashRiyal,
        cashHalala: deliveryData.cashHalala,
        spnRiyal: deliveryData.spnRiyal,
        spnHalala: deliveryData.spnHalala,
        creditRiyal: deliveryData.creditRiyal,
        creditHalala: deliveryData.creditHalala,
        staff: deliveryData.staff,
        checkValue: value);
  }

  factory DeliveryData.fromJson(Map<String, dynamic> json) {
    return DeliveryData(
        id: json['_id'],
        name: json['name'],
        mobileNumber: json['mobileNumber'],
        serialNumber: json['serialNumber'],
        cashRiyal: json['cashRiyal'],
        cashHalala: json['cashHalala'],
        spnRiyal: json['spnRiyal'],
        spnHalala: json['spnHalala'],
        creditRiyal: json['creditRiyal'],
        creditHalala: json['creditHalala'],
        staff: json['staff'],
        checkValue: json['checkValue']);
  }
}
