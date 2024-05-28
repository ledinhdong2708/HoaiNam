import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';

class NhatKyService {
  static Future<List?> FetchNhatKy() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiNhatKy}';
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
      final result = json["nhatKys"] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<List?> PH_FetchNhatKy() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiNhatKy}/ph/nhatky';
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
      final result = json["nhatKys"] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<Object> updateImage(file) async {
    // final SharedPreferences prefs = await _prefs;
    var resJson;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiNhatKy}/UploadMultipleFile';
    final uri = Uri.parse(url);
    var request = new http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    List<http.MultipartFile> _dataList = [];
    for (var img in file) {
      if (img != "") {
        MultipartFile multipartFile = await http.MultipartFile.fromBytes(
            'fileNhatKyModel', img,
            filename: 'Demo');
        _dataList.add(multipartFile);
      }
    }
    request.files.addAll(_dataList);
    var response = await request.send();

    if (response.statusCode == 200) {
      var item = "${await response.stream.bytesToString()}";
      return item;
    } else {
      return "Failed";
    }
  }

  static Future<Object> updateImageAndVideo(file) async {
    // final SharedPreferences prefs = await _prefs;
    var resJson;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiNhatKy}/UploadMultipleFileVideo';
    final uri = Uri.parse(url);

    var request = new http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);

    List<http.MultipartFile> _dataList = [];
    for (var img in file) {
      if (img["data"] != "") {
        MultipartFile multipartFile = await http.MultipartFile.fromBytes(
            'fileNhatKyModel', img["data"],
            filename: img['fileName']);
        _dataList.add(multipartFile);
      }
    }
    request.files.addAll(_dataList);
    var response = await request.send();

    if (response.statusCode == 200) {
      var item = "${await response.stream.bytesToString()}";
      return item;
    } else {
      return "Failed";
    }
  }

  static Future<Object> updateImageAndVideoMobile(file) async {
    // final SharedPreferences prefs = await _prefs;
    var resJson;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiNhatKy}/UploadMultipleFileVideo';
    final uri = Uri.parse(url);

    var request = new http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);

    List<http.MultipartFile> _dataList = [];
    for (var img in file) {
      if (img["data"] != "") {
        // request.files.add(await http.MultipartFile.fromPath('fileNhatKyModel', img['data']));
        MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'fileNhatKyModel', img["data"],
            filename: img['fileName']);
        _dataList.add(multipartFile);
      }
    }
    request.files.addAll(_dataList);
    var response = await request.send();

    if (response.statusCode == 200) {
      var item = "${await response.stream.bytesToString()}";
      return item;
    } else {
      return "Failed";
    }
  }

  static Future<bool> submitData(Map body, selectedStudent) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    final url = '${SERVER_IP}${apiNhatKy}?studentId=${selectedStudent}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    body["appID"] = token['appID'];
    body["studentId"] = selectedStudent;

    for (int i = 0; i < body["tableImages"].length; i++) {
      body["tableImages"][i]["studentId"] = int.parse(selectedStudent);
    }

    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);
    return response.statusCode == 200;
  }

  static Future<bool> submitLike(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiTableLike}';
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

  static Future<bool> deleteById(String id) async {
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final url = '${SERVER_IP}${apiTableLike}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri, headers: headers);
    return response.statusCode == 200;
  }

  static Future<List?> FetchBinhLuan(id) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiTableBinhLuan}/byidnhatky?NhatKyId=$id';
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
      final result = json["binhLuans"] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> submitComent(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiTableBinhLuan}';
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
}
