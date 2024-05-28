import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:appflutter_one/_components/_services/HocSinh/HocSinhService.dart';
import 'package:appflutter_one/_components/_services/NhatKy/NhatKyService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/models/student_model.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddBangTinScreen extends StatefulWidget {
  const AddBangTinScreen({Key? key}) : super(key: key);

  @override
  State<AddBangTinScreen> createState() => _AddBangTinScreenState();
}

class _AddBangTinScreenState extends State<AddBangTinScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  bool isLoading = false;
  final ImagePicker imagePicker = ImagePicker();

  String nameValueclass = "";
  String selectedValueclass = "";
  List<ClasssModel> listClasss = <ClasssModel>[];

  String student = "";
  String selectedStudent = "";
  List listStudent = [];

  String nameValueYear = "";
  String selectedValueYear = "";
  List<KhoaHocModel> listYear = <KhoaHocModel>[];

  File _file = File("zz");
  Uint8List webImage = Uint8List(10);
  List<XFile>? imageFileList = [];
  List<Uint8List>? imageFileListWebPage = [];
  List<Uint8List>? videoFileListWebPage = [];
  List items = [];
  TextEditingController contentEditingController = new TextEditingController();
  List<Uint8List>? _aboutToPostVideo = <Uint8List>[];

  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService
        .getDeviceToken()
        .then((value) => {tokenDevice = value});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thêm mới",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: submitData,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.save,
                color: Color(0xFF674AEF),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Adjust as needed
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: OutlinedButton(
                      onPressed: () => _classItems(context),
                      child: Text(
                        nameValueclass.isNotEmpty
                            ? nameValueclass
                            : 'Chọn Lớp ',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: OutlinedButton(
                      onPressed: () => _YearItems(context),
                      child: Text(
                        nameValueYear.isNotEmpty ? nameValueYear : 'Chọn Khóa ',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: OutlinedButton(
                      onPressed: () => _StudentItems(context),
                      child: Text(
                        student.isNotEmpty ? student : 'Chọn Học Sinh ',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                child: TextField(
                  controller: contentEditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    labelText: "Nội dung",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 25,
                      color: Colors.red,
                    ),
                    filled: false,
                    fillColor: Color(0x00ff0004),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                Text("Thêm hình ảnh"),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     // selectImages();
              //     uploadImage();
              //   },
              //   child: Text('Chọn hình ảnh'),
              // ),
              // SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: imageFileListWebPage!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        if (!kIsWeb) {
                          // return Image.file(
                          //   File(imageFileList![index].path),
                          //   fit: BoxFit.cover,
                          // );
                          return Image.memory(imageFileListWebPage![index],
                              fit: BoxFit.cover);
                        } else if (kIsWeb) {
                          return Image.memory(imageFileListWebPage![index],
                              fit: BoxFit.cover);
                        }
                      }),
                ),
              ),
              SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     // selectImages();
              //     _pickVideo();
              //   },
              //   child: Text('Chọn video'),
              // ),
              // SizedBox(height: 10),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: _videoURL != null
              //         ? _videoPreviewWidget()
              //         : Text("No Video Selected !"),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      uploadImage();
                    },
                    tooltip: "Chọn hình ảnh",
                    child: Icon(Icons.image),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['mp4', 'avi', 'mpeg', 'mpg'],
                              allowMultiple: true);
                      if (result != null) {
                        // Uint8List? fileBytes = result.files.first.bytes;
                        for (int i = 0; i < result.files.length; i++) {
                          Uint8List? fileBytes = result.files[i].bytes;
                          Uint8List? assetbytedata =
                              await File(result.files[i].path!).readAsBytes();
                          if (kIsWeb) {
                            _aboutToPostVideo!.add(fileBytes!);
                            items.add({
                              'fileName': result.files[i].name,
                              'data': fileBytes! as Uint8List
                            });
                          } else {
                            _aboutToPostVideo!.add(assetbytedata!);
                            items.add({
                              'fileName': result.files[i].name,
                              'data': assetbytedata! as Uint8List
                            });
                          }
                        }
                        setState(() {
                          _aboutToPostVideo;
                        });
                      }
                    },
                    tooltip: "Chọn Video",
                    child: Icon(Icons.video_library),
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: _aboutToPostVideo!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        if (!kIsWeb) {
                          return Image.asset('images/Music Course.png',
                              fit: BoxFit.cover);
                          // return Image.file(
                          //   File(imageFileList![index].path),
                          //   // File(imageFileList![index].path),
                          //   fit: BoxFit.cover,
                          // );
                          // return Image.memory(_aboutToPostVideo![index],
                          //     fit: BoxFit.cover);
                        } else if (kIsWeb) {
                          return Image.memory(_aboutToPostVideo![index],
                              fit: BoxFit.cover);
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> FetchClasss() async {
    List<ClasssModel> lsClasss = [];
    final response = await SharedSerivce.FetchListClasss();
    if (response != null) {
      setState(() {
        lsClasss = response as List<ClasssModel>;
      });
    }
    setState(() {
      listClasss = lsClasss;
      isLoading = false;
    });
  }

  Future<void> FetchKhoaHoc() async {
    List<KhoaHocModel> lsKhoaHoc = [];
    final response = await SharedSerivce.FetchListKhoaHoc();
    if (response != null) {
      setState(() {
        lsKhoaHoc = response as List<KhoaHocModel>;
      });
    }
    setState(() {
      listYear = lsKhoaHoc;
      isLoading = false;
    });
  }

  Future<void> FetchStudent() async {
    final response = await HocSinhService.FetchByKhoaHocAndClass(
        selectedValueYear, selectedValueclass);
    print(response);
    if (response != null) {
      setState(() {
        listStudent = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _StudentItems(BuildContext context) async {
    await FetchStudent();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn Học Sinh'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listStudent.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      listStudent[index]['nameStudent'] ?? ""), // Adjusted here
                  onTap: () {
                    setState(() {
                      selectedStudent = listStudent[index]['id'].toString();
                      student = listStudent[index]['nameStudent'] ??
                          ""; // Adjusted here
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _YearItems(BuildContext context) async {
    await FetchKhoaHoc();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn Khóa'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listYear.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(listYear[index].name ?? ""),
                  onTap: () {
                    setState(() {
                      selectedValueYear = listYear[index].id.toString();
                      nameValueYear = listYear[index].name ?? "";
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _classItems(BuildContext context) async {
    await FetchClasss();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn lớp'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listClasss.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(listClasss[index].name ?? ""),
                  onTap: () {
                    setState(() {
                      selectedValueclass = listClasss[index].id.toString();
                      nameValueclass = listClasss[index].name ?? "";
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  uploadImage() async {
    var permissionStatus = requestPermissions();

    // MOBILE
    // if (!kIsWeb && await permissionStatus.isGranted) {
    // if (!kIsWeb) {
    //   final ImagePicker _picker = ImagePicker();
    //   List<XFile>? image = await _picker.pickMultiImage();
    //   if (image != null) {
    //     List<Uint8List> a = [];
    //     for(int i = 0 ; i< image.length; i++) {
    //       var f = await image[i].readAsBytes();
    //       a!.add(f);
    //     }
    //     setState(() {
    //       imageFileListWebPage = a;
    //     });
    //   } else {
    //     showErrorMessage(context, message: "No file selected");
    //   }
    // }
    // WEB
    // else if (kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? image = await _picker.pickMultiImage();
    if (image != null) {
      List<Uint8List> a = [];
      for (int i = 0; i < image.length; i++) {
        var f = await image[i].readAsBytes();
        a!.add(f);
      }
      setState(() {
        imageFileListWebPage = a;
      });
    } else {
      showErrorMessage(context, message: "No file selected");
    }
    // } else {
    //   showErrorMessage(context, message: "Permission not granted");
    // }
  }

  Future<PermissionStatus> requestPermissions() async {
    await Permission.photos.request();
    return Permission.photos.status;
  }

  Future<void> submitData() async {
    // if (kIsWeb) {
    var newList = new List.from(imageFileListWebPage!)
      ..addAll(_aboutToPostVideo!);
    if (imageFileListWebPage!.length < 0 || items.length < 0) {
      return;
    }
    final isSuccess = await NhatKyService.updateImage(imageFileListWebPage!);
    final isSuccessVideo;
    if (kIsWeb) {
      isSuccessVideo = await NhatKyService.updateImageAndVideo(items);
    } else {
      isSuccessVideo = await NhatKyService.updateImageAndVideo(items);
    }
    if (isSuccess != "Failed" && isSuccessVideo != 'Failed') {
      String dataString = isSuccess.toString();
      String dataStringVideo = isSuccessVideo.toString();
      final result = json.decode(dataString);
      final resultVideo = json.decode(dataStringVideo);
      final data = [];
      for (int i = 0; i < result.length; i++) {
        data.add({
          "id": 0,
          "imageName": result[i]["imageName"],
          "imagePatch": result[i]["imagePatch"],
          "createDate": result[i]["createDate"],
          "status": true,
          "nhatKyId": 0,
          "userId": result[i]["userId"],
          "studentId": selectedStudent,
          "appID": result[i]["appID"]
        });
      }
      for (int i = 0; i < resultVideo.length; i++) {
        data.add({
          "id": 0,
          "imageName": resultVideo[i]["imageName"],
          "imagePatch": resultVideo[i]["imagePatch"],
          "createDate": resultVideo[i]["createDate"],
          "status": true,
          "nhatKyId": 0,
          "userId": resultVideo[i]["userId"],
          "studentId": selectedStudent,
          "appID": resultVideo[i]["appID"]
        });
      }
      final body = {
        "id": 0,
        "content": contentEditingController.text,
        "createDate": "2024-01-12T04:32:19.998Z",
        "updateDate": "2024-01-12T04:32:19.998Z",
        "status": true,
        "userId": 0,
        "tableLikeId": 0,
        "tableImageId": 0,
        "classId": selectedValueclass,
        "khoaId": selectedValueYear,
        "studentId": selectedStudent,
        "binhLuanId": 0,
        "tableImages": data
      };
      final isSuccessSubmitData =
          await NhatKyService.submitData(body, selectedStudent);

      if (isSuccessSubmitData) {
        var InsertbodyFirebase = {
          "to": tokenDevice,
          "priority": "high",
          "notification": {
            "title": "Thêm mới bảng tin",
            "body": "Bảng tin đã được tạo mới !"
          }
        };
        _notificationService.getDeviceToken().then((value) async =>
            {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
        Navigator.pop(context);
        showSuccessMessage(context, message: 'Thêm mới thành công');
      } else {
        showErrorMessage(context, message: 'Thêm mới thất bại');
      }
    }
    // } else {
    //   final isSuccess = await NhatKyService.updateImage(imageFileList!);
    // }
  }
}
