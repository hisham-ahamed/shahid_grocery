import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shahid_grocery_staff/models/address_data_model.dart';

class Offline {
  static String address = 'address';
  static bool _fileExists;
  static File _jsonFile;
  static Directory _directory;

  static Future<bool> doFileExist(String fileName) async {
    String _completeFileName = fileName + '.json';
    _directory = await getApplicationDocumentsDirectory();
    _jsonFile = File(_directory.path + '/' + _completeFileName);
    _fileExists = _jsonFile.existsSync();
    return _fileExists;
  }

  static void saveToLocal(String fileName, String contentToSave) async {
    String _completeFileName = fileName + '.json';
    _directory = await getApplicationDocumentsDirectory();
    _jsonFile = File(_directory.path + '/' + _completeFileName);
    _jsonFile.createSync();
    _jsonFile.writeAsStringSync(contentToSave);
  }

  static Future<String> readFromLocal(String fileName) async {
    String _completeFileName = fileName + '.json';
    _directory = await getApplicationDocumentsDirectory();
    _jsonFile = File(_directory.path + '/' + _completeFileName);
    _jsonFile.createSync();
    String _returnData = _jsonFile.readAsStringSync();
    return _returnData;
  }

  static String addressDataListToJsonString(List<AddressData> addressData) {
    String _jsonString = AddressData.toJsonString(addressData);
    return _jsonString;
  }

  static List<AddressData> jsonStringToAddressDataList(String jsonString) {
    List<dynamic> _tempListDynamic = jsonDecode(jsonString);
    List<AddressData> _returnList = _tempListDynamic
        .map((dynamic jsonData) => AddressData.fromJson(jsonData))
        .toList();
    return _returnList;
  }
}
