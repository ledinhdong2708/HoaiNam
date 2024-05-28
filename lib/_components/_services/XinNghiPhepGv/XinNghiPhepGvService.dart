import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class XinNghiPhepGvService {
  static Future<List> FetchXinNghiPhep() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiXinNghiPhep}';
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
      final results = json['xinNghiPheps'] as List<dynamic>;

      final users = results.map((e) {
        return e;
        // return HocPhiModel.fromMap(e);
      }).toList();
      return users;
    } else {
      return [];
    }
  }

  static Future<dynamic> FetchXinNghiPhepByDate(
      int day, int month, int year) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url =
        '${SERVER_IP}${apiXinNghiPhep}/dateGV?UserID=${body['userID']}&day=${day.toString()}&month=${month.toString()}&year=${year.toString()}';
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
    const url = '${SERVER_IP}${apiXinNghiPhep}/gv';
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

  static Future<bool> submitDataGV(body) async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiXinNghiPhep}/gv';
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
    final url = '${SERVER_IP}${apiXinNghiPhep}/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> updateDataGV(int id, Map body) async {
    print("body: ");
    print(body);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    body["appID"] = token['appID'];
    final url = '${SERVER_IP}${apiXinNghiPhep}/gv$id';
    final uri = Uri.parse(url);
    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> updateData_HocPhi(String id, Map body) async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    body["appID"] = token['appID'];
    final url =
        '${SERVER_IP}${apiXinNghiPhep}/xinnghiphep_detail/${id}?id=${token['userID']}';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiXinNghiPhep}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<dynamic> PH_FetchHocPhiByStudent() async {
    try {
      String? value = await storage.read(key: 'jwt');
      final body = json.decode(value!);
      Map<String, String> headers = {
        "Authorization": "Bearer ${body['accessToken']}",
      };
      final url = '${SERVER_IP}${apiXinNghiPhep}/gv?id=${body['userID']}';
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final result = json;
        print(result);
        return result;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch data');
    }
  }

  static Future<dynamic> ischeck(id) async {
    print("nshdhsjidsujd");
    final url = '${SERVER_IP}${apiXinNghiPhep}/phXinphep?id=${id}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json;
      print(result);
      return result;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
