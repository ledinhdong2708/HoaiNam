import 'dart:convert';

import 'package:appflutter_one/_components/models/student_model.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:appflutter_one/main.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dropdown_student.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class SoBeNgoanService {
  static Future<List<DropdownStudent>?> FetchHocSinh(classid) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiStudents}/$classid';
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
      final result = json as  List<dynamic>;
      // return result;
      final users = result.map((e) {
        if(e["chieuCao"] == null) {
          e["chieuCao"] = 0;
        }
        if(e["canNang"] == null) {
          e["canNang"] = 0;
        }
        return DropdownStudent.fromMap(e);
      }).toList();
      return users;
    } else {
      return null;
    }
  }

  static Future<dynamic> FetchHocSinhById(id) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiStudents}/byId?UserID=${body['userID']}&StudentID=$id';
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

  static Future<List?> FetchByYearAndClass(year, idclass, month) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    final url =
        '${SERVER_IP}${apiSoBeNgoans}/byyearclass?year=$year&classId=$idclass&month=$month';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
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


  static Future<List?> FetchSoBeNgoan() async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    final url = '${SERVER_IP}${apiSoBeNgoans}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
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
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiSoBeNgoans}';
    final uri = Uri.parse(url);
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

    final url = '${SERVER_IP}${apiSoBeNgoans}/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    body["appID"] = token['appID'];
    final response = await http.put(uri,
        body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiSoBeNgoans}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<dynamic> PH_FetchByStudent(String month, String year) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiSoBeNgoans}/ph/byId?StudentID=${body['studentID']}&month=$month&year=$year';
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