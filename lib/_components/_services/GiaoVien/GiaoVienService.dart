import 'dart:convert';
import 'dart:io';
import 'package:appflutter_one/_components/models/GiaoVienModel.dart';
import 'package:appflutter_one/_components/models/student_model.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../shared/UrlAPI/API_General.dart';

// const String api = '/api/Students';
// const String apiUser = '/api/Users';

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class GiaoVienService {
  static Future<List<GiaoVienModel>> FetchGiaoVien() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiUser}/giaovien';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => GiaoVienModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<dynamic> AddHocPhiALL(
      String selectedClassId,
      String selectedKhoaHoc,
      String tienHocPhiController,
      String? selectedMonth,
      String? selectedYear,
      String tienAnController,
      giaTienMoiBuoi,
      giaTienAnMoiBuoi) async {
    String Gia1BuoiHoc = giaTienMoiBuoi.toString().replaceAll('.0', '');
    String GiaTienAn1Buoi = giaTienAnMoiBuoi.toString().replaceAll('.0', '');
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiHocPhiModel}/newHocPhiAll';
    final uri = Uri.parse(url).replace(
      queryParameters: {
        'classID': selectedClassId,
        'khoaID': selectedKhoaHoc,
        'tienHocPhi': tienHocPhiController,
        'month': selectedMonth,
        'tienAn': tienAnController,
        'year': selectedYear,
        'Gia1BuoiHoc': Gia1BuoiHoc,
        'GiaTienAn1Buoi': GiaTienAn1Buoi,
      },
    );

    final response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      return {};
    }
  }

  static Future<dynamic> FetchByIDStudent(String id) async {
    // final SharedPreferences prefs = await _prefs;

    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiStudents}/byId?StudentID=$id';
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      return {};
    }
  }

  static Future<List<GiaoVienModel>> FetchPhuHuynh() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiUser}/phuhuynh';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => GiaoVienModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<List?> FetchByKhoaHocAndClass(idkhoahoc, idclass) async {
    final url =
        '${SERVER_IP}${apiStudents}/bykhoahocclass?khoaHocId=$idkhoahoc&classId=$idclass';
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

  static Future<List?> FetchByKhoaHocAndClassDate(days, months, years) async {
    final url =
        '${SERVER_IP}${apiDiemDanhGiaoVien}/getbygiaovien?day=$days&month=$months&year=$years';
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
      print(json);
      final result = json["users"] as List;
      print("đasadasdsa");
      print(result);
      return result;
    } else {
      return null;
    }
  }

  // static Future<List?> FetchGiaoVien() async {
  //   final url = '${SERVER_IP}${apiUser}';
  //   final uri = Uri.parse(url);
  //   String? value = await storage.read(key: 'jwt');
  //   final body = json.decode(value!);
  //   Map<String, String> headers = {
  //     "Authorization": "Bearer ${body['accessToken']}",
  //   };
  //
  //   final response = await http.get(uri, headers: headers);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     final result = json as List;
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  static Future<List?> FetchHocSinh() async {
    // final SharedPreferences prefs = await _prefs;
    final url = '${SERVER_IP}${apiStudents}';
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

  static Future<dynamic> FetchStudentClass() async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url = '${SERVER_IP}${apiStudents}/StudentClass';
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json;
      return result;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<bool> submitData(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiStudents}';
    final uri = Uri.parse(url);
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
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

  static Future<bool> createPhuHuynhWithStudent(Map body) async {
    // final SharedPreferences prefs = await _prefs;
    const url = '${SERVER_IP}${apiUser}/signup';
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

    final url = '${SERVER_IP}${apiStudents}/$id';
    final uri = Uri.parse(url);

    body["appID"] = token['appID'];
    // ${body['userID']
    final response =
        await http.put(uri, body: jsonEncode(body), headers: headers);

    return response.statusCode == 200;
  }

  static Future<bool> updateImage(String id, File file) async {
    // final SharedPreferences prefs = await _prefs;
    var resJson;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer ${token['accessToken']}",
    };

    final url = '${SERVER_IP}${apiStudents}/UploadFile?studentId=$id';
    final uri = Uri.parse(url);

    var stream = new http.ByteStream(file.openRead());
    stream.cast();

    var request = new http.MultipartRequest('POST', uri);

    request.fields["FileName"] = "Static FileName";

    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded");
      return response.statusCode == 200;
    } else {
      print("Failed");
      return response.statusCode == 400;
    }
  }

  static Future<bool> deleteById(String id) async {
    final url = '${SERVER_IP}${apiStudents}/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<dynamic> FetchIdByStudent() async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url =
        '${SERVER_IP}${apiStudents}/byId?UserID=${body['userID']}&StudentID=${body['studentID']}';
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

  static Future<dynamic> Detail_FetchIdByStudent(id) async {
    // final SharedPreferences prefs = await _prefs;
    // String? value = await prefs.getString('jwt');
    String? value = await storage.read(key: 'jwt');
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    final url =
        '${SERVER_IP}${apiStudents}/byId?UserID=${body['userID']}&StudentID=$id';
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
}
