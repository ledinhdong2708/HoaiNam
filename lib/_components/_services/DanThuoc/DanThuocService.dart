import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class DanThuocService {
  static Future<List?> FetchDanThuoc(String idclass, String idKhoaHoc,
      String day, String month, String year) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiDanThuoc}/byStudent?classID=$idclass&idKhoaHoc=$idKhoaHoc&day=$day&month=$month&year=$year';
    final uri = Uri.parse(url);

    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['danThuocDTOs'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiDanThuoc}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    body["appID"] = token['appID'];
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);
    return response.statusCode == 200;
  }

  static Future<bool> PH_submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiDanThuoc}/ph';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    body["appID"] = token['appID'];
    body["studentId"] = token['studentID'];

    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);
    return response.statusCode == 200;
  }

  static Future<bool> updateData(String id, Map body) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    body["appID"] = token['appID'];

    final url = '${SERVER_IP}${apiDanThuoc}/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> PH_updateData(String id, Map body) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    body["appID"] = token['appID'];
    body["studentId"] = token['studentID'];

    final url = '${SERVER_IP}${apiDanThuoc}/ph/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiDanThuoc}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> PH_FetchDanThuoc(
      int id, String day, String month, String year) async {
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiDanThuoc}/ph/byStudent?studentId=${body['studentID']}&day=$day&month=$month&year=$year';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json as List;
      return result;
    } else {
      return null;
    }
  }
}
