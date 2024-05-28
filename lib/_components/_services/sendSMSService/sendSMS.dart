import 'dart:convert';

import 'package:appflutter_one/_components/models/DiemDanhModel.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

class sendSMSDiemDanhService {
  static Future<dynamic> sendSMSDDs(idClass, idKhoahoc) async {
    final url = '${SERVER_IP}${sendSMS}/SendSMSDD';
    final uri = Uri.parse(url).replace(
      queryParameters: {
        'classID': idClass,
        'khoahocID': idKhoahoc,
      },
    );

    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final response = await http.post(uri, headers: headers);
    return response.statusCode == 200;
  }

  static Future<dynamic> sendSMSTBhocphiAll(selectedMonth, Map body) async {
    String month = selectedMonth.toString();
    final url = '${SERVER_IP}${sendSMS}/sendSMSTBhocphiAll';
    final uri = Uri.parse(url).replace(
      queryParameters: {
        'month': month,
      },
    );

    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<dynamic> sendSMSTBNH(Map body) async {
    final url = '${SERVER_IP}${sendSMS}/SendSMSTBNH';
    final uri = Uri.parse(url);

    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<dynamic> sendSMSHocPhiKhoa(
      idClass, idKhoahoc, selectedMonth, Map body) async {
    String month = selectedMonth.toString();
    final url = '${SERVER_IP}${sendSMS}/sendSMSHocPhiKhoa';
    final uri = Uri.parse(url).replace(
      queryParameters: {
        'classID': idClass,
        'khoahocID': idKhoahoc,
        'month': month,
      },
    );

    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }
}
