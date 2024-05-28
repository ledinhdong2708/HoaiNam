import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../models/DinhDuongModel.dart';
import '../../shared/UrlAPI/API_General.dart';
import 'package:http/http.dart' as http;

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class DinhDuongService {
  static Future<dynamic> FetchDinhDuong(int day, int month, int year, String khoahocid, String classid) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiDinhDuong}/date?UserID=${body['userID']}&day=${day.toString()}&month=${month.toString()}&year=${year.toString()}&khoahocid=$khoahocid&classid=$classid';
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json;
      return result;
    } else {
      return {};
    }
  }


  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiDinhDuong}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    body["appID"] = token['appID'];
    final response = await http.post(uri,
        body: jsonEncode(body), headers: headers);
    return response.statusCode == 200;
  }

  static Future<bool> updateData(String id, Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiDinhDuong}/$id';
    final uri = Uri.parse(url);

    body["appID"] = token['appID'];
    // ${body['userID']
    final response = await http.put(uri,
        body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiDinhDuong}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }
  static Future<dynamic> PH_FetchDinhDuongByStudent(int day, int month, int year) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiDinhDuong}/ph/date?day=${day.toString()}&month=${month.toString()}&year=${year.toString()}';
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json;
      return result;
    } else {
      return {};
    }
  }
}