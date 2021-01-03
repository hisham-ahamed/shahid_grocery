import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static Future<dynamic> get(String url, [String token]) async {
    final http.Response res = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'token': token
    });
    return jsonDecode(res.body);
  }

  static Future<dynamic> getWithoutDecode(String url, [String token]) async {
    final http.Response res = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'token': token
    });
    return res.body;
  }

  static Future<dynamic> post(String url, Map<String, dynamic> data,
      [String token]) async {
    String body = json.encode(data);
    final http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'token': token,
        },
        body: body);
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> put(String url, Map<String, dynamic> data,
      [String token]) async {
    String body = json.encode(data);
    final http.Response res = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'token': token,
        },
        body: body);
    return jsonDecode(res.body);
  }
}
