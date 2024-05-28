import 'dart:convert';

import 'package:appflutter_one/_components/models/HocPhiModel.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class HocPhiService {
  static Future<List> FetchHocPhi() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHocPhi}';
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
      final results = json['hocPhis'] as List<dynamic>;
      ;
      final users = results.map((e) {
        return e;
        // return HocPhiModel.fromMap(e);
      }).toList();
      return users;
    } else {
      return [];
    }
  }

  static Future<bool> updateData_HocPhi(String id, Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiHocPhi}/hocphi_detail?id=${id}';
    final uri = Uri.parse(url);

    // ${body['userID']
    body["appID"] = token['appID'];
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<void> UpdateGiaTien(int id, Map body) async {
    try {
      final url = 'https://localhost:7194/api/GiaTien/UpdateGiaTien/${id}';
      // Gửi request lên back-end
      final uri = Uri.parse(url);
      final response = await http.put(uri, body: jsonEncode(body));
    } catch (error) {
      // Xử lý lỗi khi gọi API
      print("Lỗi khi gọi API: $error");
    }
  }

  static Future<List?> FetchByYearAndClass(year, idclass) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    final url =
        '${SERVER_IP}${apiHocPhi}/byyearclassstudent?year=$year&classId=$idclass';
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

  static Future<dynamic> FetchChiTietHocPhiTheoMonth(id) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    final url =
        '${SERVER_IP}${apiHocPhi}/chitiettheomonth?idchitiethocphitheomonth=$id';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
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

  static Future<dynamic> FetchHocPhibyId(id) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url =
        '${SERVER_IP}${apiHocPhi}/id?UserID=${body['userID']}&HocPhiID=$id';
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
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiHocPhi}';
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

  static Future<bool> updateData(String id, Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiHocPhi}/$id';
    final uri = Uri.parse(url);
    body["appID"] = token['appID'];

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiHocPhi}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<dynamic> PH_FetchHocPhiByStudent() async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiHocPhi}/ph?id=${body['studentID']}';
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

  static Future<bool> updateStatusThanhToan(String id, String body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    var valueBody = "";
    if (body == "0") {
      valueBody = "false";
    } else {
      valueBody = "true";
    }
    final url = '${SERVER_IP}${apiHocPhi}/statusHocPhi/$valueBody?id=$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response = await http.put(uri, headers: headers);

    return response.statusCode == 200;
  }
}
