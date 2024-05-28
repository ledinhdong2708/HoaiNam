import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class PhanCongGiaoVienService {
  static Future<List?> FetchGiaoVien() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiUser}/giaovien';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
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

  static Future<List?> FetchAllPhanCongGiaoVien(classId, khoahocId) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiPhanCongGiaoVien}?classid=$classId&khoahocid=$khoahocId';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
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

  static Future<List?> FetchPhanCongGiaoVien(int id) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiPhanCongGiaoVien}/byStudent?id=$id';
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

  static Future<List?> DSHoatDong() async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiPhanCongGiaoVien}/dsHoatDong';
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

  static Future<List?> DSHoatDongPH(
      IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3) async {
    int IdClassStudent1 = int.parse(IdClass1);
    int IdKhoaHocStudent1 = int.parse(IdKhoaHoc1);
    int IdClassStudent2 = int.parse(IdClass2);
    int IdKhoaHocStudent2 = int.parse(IdKhoaHoc2);
    int IdClassStudent3 = int.parse(IdClass3);
    int IdKhoaHocStudent3 = int.parse(IdKhoaHoc3);
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url =
        '${SERVER_IP}${apiPhanCongGiaoVien}/dsHoatDongPH?ClassId1=${IdClassStudent1}&KhoaHocId1=${IdKhoaHocStudent1}&ClassId2=${IdClassStudent2}&KhoaHocId2=${IdKhoaHocStudent2}&ClassId3=${IdClassStudent3}&KhoaHocId3=${IdKhoaHocStudent3}';
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

  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiPhanCongGiaoVien}';
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
    const url = '${SERVER_IP}${apiPhanCongGiaoVien}/ph';
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

    final url = '${SERVER_IP}${apiPhanCongGiaoVien}/$id';
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

    final url = '${SERVER_IP}${apiPhanCongGiaoVien}/ph/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiPhanCongGiaoVien}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> PH_FetchPhanCongGiaoVien(int id) async {
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiPhanCongGiaoVien}/ph/byStudent?studentId=${body['studentID']}';
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
