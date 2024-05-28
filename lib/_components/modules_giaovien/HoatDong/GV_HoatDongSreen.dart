import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/PhanCongGiaoVien/PhanCongGiaoVienService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/KhoaHocModel.dart';
import '../../models/student_years.dart';
import '../../shared/utils/snackbar_helper.dart';

class GV_HoatDongScreen extends StatefulWidget {
  final Map? item;
  final int studentID;
  const GV_HoatDongScreen({Key? key, this.item, required this.studentID})
      : super(key: key);

  @override
  State<GV_HoatDongScreen> createState() =>
      GV_HoatDongGiaoVienScreenScreenState();
}

class GV_HoatDongGiaoVienScreenScreenState extends State<GV_HoatDongScreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;
  bool isLoading = false;
  String? selectedValueclass = "1";
  String? selectedValueStudent = "0";
  String? statusValue = "1";
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  List<ClasssModel> listClasss = <ClasssModel>[];
  List<StudentYear> listStatus = <StudentYear>[
    StudentYear(id: 0, name: "Hoạt động"),
    StudentYear(id: 1, name: "Không hoạt động"),
  ];
  final TextEditingController studentYearController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  final TextEditingController statusEditingController = TextEditingController();
  // List

  @override
  void initState() {
    FetchKhoaHoc();
    FetchClasss();
    super.initState();
    final _status = widget.item;
    if (_status != null) {
      isEdit = true;
      contentEditingController.text = widget.item!["content"];
      listStatus.forEach((element) {
        if (element.id.toString() == (_status["status"] == true ? "0" : "1")) {
          statusValue = element.id.toString();
          statusEditingController.text = element.name.toString();
        }
      });
    }
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${widget.item!["content"]}',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Khóa Học: ${studentYearController.text}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Lớp: ${classController.text}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                  child: TextField(
                    controller: contentEditingController,
                    readOnly: true,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 10,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.yellow, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.yellow, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.yellow, width: 1),
                      ),
                      labelText: "Nội dung",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 25,
                        color: Colors.yellow,
                      ),
                      filled: false,
                      fillColor: Color(0x00ff0004),
                      isDense: false,
                      contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                    ),
                    enabled: isEdit,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                  child: Text(
                    'Trạng Thái: ${statusEditingController.text}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> FetchKhoaHoc() async {
    List<KhoaHocModel> lsKhoaHoc = [];
    List<KhoaHocModel> lsKhoaHoc1 = [];
    final response = await SharedSerivce.FetchListKhoaHoc();
    if (response != null) {
      setState(() {
        lsKhoaHoc = response as List<KhoaHocModel>;
        for (int i = 0; i < lsKhoaHoc.length; i++) {
          lsKhoaHoc1.add(lsKhoaHoc[i]);
        }
        // listYearStudent = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listYearStudent = lsKhoaHoc1;
      if (isEdit) {
        listYearStudent.forEach((element) {
          if (element.id.toString() == widget.item!['khoaHocId'].toString()) {
            selectedValueStudent = element.id.toString();
            studentYearController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> FetchClasss() async {
    List<ClasssModel> lsClasss = [];
    List<ClasssModel> lsClasss1 = [];
    final response = await SharedSerivce.FetchListClasss();
    if (response != null) {
      setState(() {
        lsClasss = response as List<ClasssModel>;
        for (int i = 0; i < lsClasss.length; i++) {
          lsClasss1.add(lsClasss[i]);
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listClasss = lsClasss1;
      if (isEdit) {
        listClasss.forEach((element) {
          if (element.id.toString() == widget.item!['classId'].toString()) {
            selectedValueclass = element.id.toString();
            classController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> submitData() async {
    final isSuccess = await PhanCongGiaoVienService.submitData(body);

    if (isSuccess) {
      selectedDate = DateTime.now();
      Navigator.pop(context, 'Yel !');
      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> updateData() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = itemUpdate["id"];
    // final isCompleted = todo['is_completed'];
    final isSuccess =
        await PhanCongGiaoVienService.updateData(id.toString(), body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    DateTime timeNow = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
        .format(selectedDate);
    String formattedDate_now =
        DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(timeNow);
    return {
      "content": contentEditingController.text,
      "status": statusValue == "0" ? true : false,
      "classId": selectedValueclass,
      "khoaHocId": selectedValueStudent,
      "createDate": formattedDate_now,
      "isCompleted": true,
      "userAdd": widget.studentID
    };
  }
}
