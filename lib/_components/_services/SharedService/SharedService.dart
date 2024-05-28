import 'dart:convert';

import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';
// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class SharedSerivce {
  static Future<List<KhoaHocModel>> FetchListKhoaHoc() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiKhoaHoc}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => KhoaHocModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<List<ClasssModel>> FetchListClasss() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiClass}';
    final uri = Uri.parse(url);
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => ClasssModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<bool> SendPushNotification(body) async {

    // final SharedPreferences prefs = await _prefs;
    const url = 'https://fcm.googleapis.com/fcm/send';
    final uri = Uri.parse(url);
    String serverKey = '';
    serverKey = await getServerKey().then((value) => value.toString());
    // Map<String, String> headers = {
    //   "Content-Type": "application/json; charset=UTF-8",
    //   "Authorization": "key=AAAAjX7yewc:APA91bGl26CIVtoN9K1j7laidXi3im-0iGHBkinguRdMyelk7j1emJ4MvCkSDaKxEwvuIRZj4NHlpGErZlv9u0V3PAqYpC9UYPRDu9CEsD2-NZLlcbnrV8Q3RlMh0DP5enoyhbbqo7Uv",
    // };
    if(serverKey == null || serverKey == "") {
      return false;
    }else {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "key=${serverKey}",
      };
      final response = await http.post(uri, body: jsonEncode(body), headers: headers);
      return response.statusCode == 200;
    }
  }

  static Future<String> getServerKey() async {
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);

    Map<String, String> headers = {
      "Authorization": "Bearer ${token['accessToken']}",
    };
    final url = '${SERVER_IP}${apiAppID}/byId?TinTucID=${token['appID']}';
    var uri = Uri.parse(url);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var convertDataToJson = json.decode(response.body);
      // var item =convertDataToJson['field1'];
      return convertDataToJson['field1'].toString();
    } else {
      return "Failed";
    }
  }
}