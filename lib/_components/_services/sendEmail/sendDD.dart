import 'dart:convert';

import 'package:appflutter_one/_components/models/DiemDanhModel.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

class sendDiemDanhService {
  static Future<dynamic> sendEmailDD(idClass, idKhoahoc) async {
    final url = '${SERVER_IP}${sendEmail}/sendDiemDanh';
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
}
