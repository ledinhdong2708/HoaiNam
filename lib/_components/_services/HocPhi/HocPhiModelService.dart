import 'dart:convert';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';
import 'package:http/http.dart' as http;

class HocPhiModelService {
  static Future<List?> FetchDataByStudent(int id) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHocPhiModel}/byStudent?id=$id';
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
      final result = json["hocPhiModels"] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List?> FetchDataByMaterHocPhi() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiMaterHocPhi}';
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

  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiHocPhiModel}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    body["appID"] = token['appID'];
    // body["studentId"] = body['studentID'];
    body["userId"] = token['userID'];
    List data = [];
    for (int i = 0; i < body["hocPhiChiTietModels"].length; i++) {
      data.add({
        "id": 0,
        "userId": token['userID'],
        "studentId": body['studentId'],
        "createDate":
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T02:08:11.311Z",
        "content": body["hocPhiChiTietModels"][i]["content"],
        "appID": token['appID'],
        "total": body["hocPhiChiTietModels"][i]["total"],
        "materHocPhiId": body["hocPhiChiTietModels"][i]["id"],
        "quantity": body["hocPhiChiTietModels"][i]["quantity"] != null
            ? (body["hocPhiChiTietModels"][i]["quantity"])
            : "1",
        "Gia1BuoiHoc": body["Gia1BuoiHoc"],
        "GiaTienAn1Buoi": body["GiaTienAn1Buoi"],
      });
    }
    body["hocPhiChiTietModels"] = data;
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

    body["appID"] = token['appID'];
    List data = [];
    for (int i = 0; i < body["hocPhiChiTietModels"].length; i++) {
      data.add({
        "id": body["hocPhiChiTietModels"][i]["materHocPhiId"] == null
            ? 0
            : body["hocPhiChiTietModels"][i]['id'],
        "userId": token['userID'],
        "studentId": body['studentId'],
        "createDate":
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T02:08:11.311Z",
        "content": body["hocPhiChiTietModels"][i]["content"],
        "appID": token['appID'],
        "total": body["hocPhiChiTietModels"][i]["total"],
        "materHocPhiId": body["hocPhiChiTietModels"][i]["materHocPhiId"] == null
            ? body["hocPhiChiTietModels"][i]["id"]
            : body["hocPhiChiTietModels"][i]["materHocPhiId"],
        "quantity": body["hocPhiChiTietModels"][i]["quantity"] != null
            ? body["hocPhiChiTietModels"][i]["quantity"]
            : "1",
        "Gia1BuoiHoc": body["Gia1BuoiHoc"] ?? 0,
        "GiaTienAn1Buoi": body["GiaTienAn1Buoi"] ?? 0,
      });
    }
    body["hocPhiChiTietModels"] = data;
    final url = '${SERVER_IP}${apiHocPhiModel}/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHocPhiModel}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<bool> updateStatusThanhToan(String id, int body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    var valueBody = "";
    if (body == 0) {
      valueBody = "true";
    } else {
      valueBody = "false";
    }
    final url = '${SERVER_IP}${apiHocPhiModel}/statusHocPhi/$valueBody?id=$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response = await http.put(uri, headers: headers);

    return response.statusCode == 200;
  }

  static Future<List?> PH_FetchDataByStudent() async {
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiHocPhiModel}/ph/byStudent?id=${body["studentID"]}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["hocPhiModels"] as List;
      return result;
    } else {
      return null;
    }
  }
}
