import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../shared/UrlAPI/API_General.dart';

class DiemDanhTheoLopService {
  static Future<List?> FetchByKhoaHocAndClassDay(
      idkhoahoc, idclass, day, month, year) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiReport}/byday?khoaHocId=$idkhoahoc&classId=$idclass&days=$day&months=$month&years=$year';
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
      final result = json['reportDiemDanhRequests'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List?> FetchByKhoaHocAndClassMonth(
      idkhoahoc, idclass, month, year) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiReport}/bymonth?khoaHocId=$idkhoahoc&classId=$idclass&months=$month&years=$year';
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
      final result = json['reportDiemDanhRequests'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List?> FetchByGVDay(day, month, year) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiReport}/gvbyday?days=$day&months=$month&years=$year';
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
      final result = json['reportDiemDanhRequests'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List<dynamic>?> FetchListStudent() async {
    final url = '${SERVER_IP}${apiReport}/getallstudent';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');

    if (value == null) {
      return null;
    }

    final body = json.decode(value);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null && jsonResponse is Map<String, dynamic>) {
        return jsonResponse['students'] as List<dynamic>?;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<dynamic>?> FetchListGV() async {
    final url = '${SERVER_IP}${apiReport}/getallgiaovien';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');

    if (value == null) {
      return null;
    }

    final body = json.decode(value);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null && jsonResponse is Map<String, dynamic>) {
        return jsonResponse['giaoViens'] as List<dynamic>?;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List?> FetchByGVMonth(month, year) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiReport}/gvbymonth?months=$month&years=$year';
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
      final result = json['reportDiemDanhRequests'] as List;
      return result;
    } else {
      return null;
    }
  }
}
