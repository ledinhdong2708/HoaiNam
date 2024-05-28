import 'dart:convert';

import 'package:appflutter_one/_components/models/DiemDanhModel.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class DiemDanhService {
  static Future<List?> FetchClassNameStudent(className) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiClassNameStudents}/$className';
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

  static Future<dynamic> FetchStudentIdWithDate(idStudent) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiDiemDanh}/studentId?StudentID=$idStudent';
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
      final result = json;
      return result;
    } else {
      return {};
    }
  }

  static Future<List?> FetchDiemDanhStatusUpdate(day, month, year) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiDiemDanh}/statusupdate?day=$day&month=$month&year=$year';
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

  static Future<bool> submitData(List<Map> body) async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiDiemDanh}/postmultiple';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    for (int i = 0; i < body.length; i++) {
      body[i]["appID"] = token['appID'];
    }
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);
    return response.statusCode == 200;
  }

  static Future<bool> updateData(List<Map> body) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    for (int i = 0; i < body.length; i++) {
      body[i]["appID"] = token['appID'];
    }
    final url = '${SERVER_IP}${apiDiemDanh}/updatemultiple';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiDiemDanh}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }
}
