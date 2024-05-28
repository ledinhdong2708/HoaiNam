import 'dart:convert';

import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class ThoiKhoaBieuService {
  static Future<List?> FetchThoiKhoaBieu() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiThoiKhoaBieus}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json as List;
      return result;
    } else {
      return null;
    }
  }
  static Future<List?> FetchByDateAndClass(day, month, year, idclass) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiThoiKhoaBieus}/bydateclass?day=$day&month=$month&year=$year&classId=$idclass';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json as List;
      return result;
    } else {
      return null;
    }
  }
  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiThoiKhoaBieus}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
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
    final url = '${SERVER_IP}${apiThoiKhoaBieus}/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }
  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiThoiKhoaBieus}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }
  static Future<dynamic> PH_FetchByStudent(day,month, year) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiThoiKhoaBieus}/ph/byId?day=$day&month=$month&year=$year&StudentID=${body['studentID']}';
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
