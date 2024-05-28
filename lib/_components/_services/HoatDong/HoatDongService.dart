import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';
import 'package:http/http.dart' as http;

class HoatDongService {
  static Future<List?> FetchHoatDong() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHoatDong}';
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
      final result = json["hoatDongModels"] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> GV_FetchHoatDong() async {
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHoatDong}/gv?UserID=${body['userID']}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["hoatDong"];
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> PH_FetchHoatDong() async {
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    print("object");

    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    print(body['userID']);
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHoatDong}/ph/hd?UserID=${body['userID']}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["hoatDong"];
      return result;
    } else {
      return null;
    }
  }

  static Future<List?> FetchByKhoaHocAndClass(idkhoahoc, idclass) async {
    // final SharedPreferences prefs = await _prefs;
    final url =
        '${SERVER_IP}${apiHoatDong}/bykhoahocclass?khoaHocId=$idkhoahoc&classId=$idclass';
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
      final result = json["hoatDongModels"] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    const url = '${SERVER_IP}${apiHoatDong}';
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

    body["appID"] = token['appID'];
    body["studentId"] = token['studentID'];
    final url = '${SERVER_IP}${apiHoatDong}/$id';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> deleteById(String id) async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiHoatDong}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<String> updateImage(File file, String filename) async {
    // final SharedPreferences prefs = await _prefs;
    var resJson;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    // final url = '${SERVER_IP}${apiHoatDong}/uploadfile';
    // var uri = Uri.parse(url);
    // var request = new http.MultipartRequest("POST", uri);
    // request.fields["FileName"] = "Static FileName";
    // request.files.add(await http.MultipartFile.fromPath(
    //     'package',
    //     file.path
    // ));
    // var response = await request.send();

    final url = '${SERVER_IP}${apiHoatDong}/uploadfile';
    final uri = Uri.parse(url);

    //
    // var stream = new http.ByteStream(file.openRead());
    // stream.cast();

    var request = new http.MultipartRequest('POST', uri);

    request.fields["FileName"] = "Static FileName";

    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    print(request);
    var response = await request.send();
    //
    // if(response.statusCode == 200) {
    //   print("Image uploaded");
    //   print(response);
    //   return response.statusCode == 200;
    // } else {
    //   print("Failed");
    //   return response.statusCode == 400;
    // }
    if (response.statusCode == 200) {
      var item = "${await response.stream.bytesToString()}";
      return item;
    } else {
      return "Failed";
    }
  }

  // Post file Unit8List
  static Future<String> updateImageUint8List(file, String filename) async {
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final url = '${SERVER_IP}${apiHoatDong}/uploadfile';
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.fields["FileName"] = "Static FileName";
    request.headers.addAll(headers);
    // Uint8List data = await file.readAsBytes();
    // List<int> list = file.cast();
    request.files.add(
        await http.MultipartFile.fromBytes('file', file, filename: filename));
    var response = await request.send();
    if (response.statusCode == 200) {
      var item = "${await response.stream.bytesToString()}";
      return item;
    } else {
      return "Failed";
    }
    // if(response.statusCode == 200) {
    //   print("Image uploaded");
    //   return response.statusCode == 200;
    // } else {
    //   print("Failed");
    //   return response.statusCode == 400;
    // }
  }
}
