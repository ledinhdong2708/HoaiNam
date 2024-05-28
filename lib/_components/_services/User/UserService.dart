import 'dart:convert';
import 'dart:io';

import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class UserService {
  static Future<dynamic> FetchUserById() async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiUser}/byId?UserID=${body['userID']}';
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

  static Future<dynamic> FetchUserByIdFireBase() async {
    print("nào");
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiUser}/byIdFiBase?UserID=${body['userID']}';
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

  static Future<dynamic> logout() async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiUser}/logout';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final response = await http.post(uri, headers: headers);
    // await prefs.remove("jwt");
    await storage.deleteAll();
    return response.statusCode == 200;
  }

  static Future<bool> updateData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString("jwt");
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final url = '${SERVER_IP}${apiUser}/${token['userID']}';
    final uri = Uri.parse(url);

    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> updateImage(File file) async {
    // final SharedPreferences prefs = await _prefs;
    var resJson;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiUser}/UploadFile';
    final uri = Uri.parse(url);

    var stream = new http.ByteStream(file.openRead());
    stream.cast();

    var request = new http.MultipartRequest('POST', uri);

    request.fields["FileName"] = "Static FileName";

    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      return response.statusCode == 200;
    } else {
      return response.statusCode == 400;
    }
  }
}
