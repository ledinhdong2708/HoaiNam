import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../shared/UrlAPI/API_General.dart';

class BaoCaoDoanhThuService {
  static Future<List?> FetchBaoCaoDoanhThu(
      id, khoaHocId, classId, selectedMonth) async {
    final url =
        '${SERVER_IP}${apiReport}/baocaodoanhthu?id=${id}&khoaHocId=${khoaHocId}&classId=${classId}&month=${selectedMonth}';
    final uri = Uri.parse(url);
    print(uri);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['baoCaoDoanhThu'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List<dynamic>?> FetchBaoCaoDoanhNew(isClosed) async {
    final url =
        '${SERVER_IP}${apiReport}/BaoCaoDoanhThuYear?ischeck=${isClosed}';
    final uri = Uri.parse(url);
    print(uri);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['baoCaoDoanhThu'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List<dynamic>?> FetchBaoCaoDoanhThuYear(selectedYear,
      selectedValueclass, selectyearValueStudent, isClosed) async {
    final url =
        '${SERVER_IP}${apiReport}/BaoCaoDoanhThuYear?year=${selectedYear}&classID=${selectedValueclass}&khoahocID=${selectyearValueStudent}&ischeck=${isClosed}';
    final uri = Uri.parse(url);
    print(uri);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['baoCaoDoanhThu'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List<dynamic>?> FetchBaoCaoDoanhGetId(data) async {
    final url = '${SERVER_IP}${apiReport}/BaoCaoDoanhThuGetId/';
    final uri = Uri.parse(url);
    print(uri);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['baoCaoDoanhThu'] as List;
      return result;
    } else {
      return null;
    }
  }
}
