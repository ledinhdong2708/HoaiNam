import 'dart:convert';

import 'package:appflutter_one/_components/models/DiemDanhModel.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

class sendThongBao {
  static Future<dynamic> sendTBhocphiKhoa(
      idClass, idKhoahoc, selectedMonth, Map body) async {
    String month = selectedMonth.toString();
    final url = '${SERVER_IP}${sendEmail}/sendTBhocphiKhoa';
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

  static Future<dynamic> sendTBNH(Map body) async {
    final url = '${SERVER_IP}${sendEmail}/sendTB';
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

  static Future<dynamic> senTBhocphiAll(selectedMonth, Map body) async {
    String month = selectedMonth.toString();
    final url = '${SERVER_IP}${sendEmail}/sendTBhocphiAll';
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
}
