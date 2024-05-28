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

class AddChiTietPhanCongGiaoVienScreen extends StatefulWidget {
  final Map? item;
  final int studentID;
  const AddChiTietPhanCongGiaoVienScreen(
      {Key? key, this.item, required this.studentID})
      : super(key: key);

  @override
  State<AddChiTietPhanCongGiaoVienScreen> createState() =>
      _AddChiTietPhanCongGiaoVienScreenScreenState();
}

class _AddChiTietPhanCongGiaoVienScreenScreenState
    extends State<AddChiTietPhanCongGiaoVienScreen> {
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
      print("object");
      print(widget.item);
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
          isEdit ? '${widget.item!["content"]}' : "Thêm mới",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: isEdit ? updateData : submitData,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                isEdit ? Icons.edit : Icons.save,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     Expanded(
                //       flex: 1,
                //       child: Container(
                //         margin: EdgeInsets.all(0),
                //         padding: EdgeInsets.all(0),
                //         width: MediaQuery.of(context).size.width,
                //         height: 40,
                //         decoration: BoxDecoration(
                //           color: Color(0xff4ca3ff),
                //           shape: BoxShape.rectangle,
                //           borderRadius: BorderRadius.circular(10.0),
                //           border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                //         ),
                //         child: Align(
                //           alignment: Alignment.center,
                //           child: Text(
                //             "Ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                //             textAlign: TextAlign.center,
                //             overflow: TextOverflow.clip,
                //             style: TextStyle(
                //               fontWeight: FontWeight.w700,
                //               fontStyle: FontStyle.normal,
                //               fontSize: 14,
                //               color: Color(0xffffffff),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 16,
                //       width: 10,
                //     ),
                //     MaterialButton(
                //       onPressed: () => _selectDate(context),
                //       color: Color(0xff498fff),
                //       elevation: 0,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(100.0),
                //         side: BorderSide(color: Color(0xff808080), width: 1),
                //       ),
                //       padding: EdgeInsets.all(12),
                //       child: Image.asset(
                //         "images/20.png",
                //         height: 35,
                //         width: 35,
                //         fit: BoxFit.cover,
                //       ),
                //       textColor: Color(0xffffffff),
                //       height: 40,
                //       minWidth: 40,
                //     ),
                //   ],
                // ),
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
                          child: DropdownMenu<KhoaHocModel>(
                            width: MediaQuery.of(context).size.width * 0.40,
                            controller: studentYearController,
                            enableFilter: true,
                            requestFocusOnTap: true,
                            leadingIcon: const Icon(Icons.search),
                            label: const Text('Search'),
                            inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5.0),
                                border: OutlineInputBorder(),
                                fillColor: Colors.transparent),
                            onSelected: (KhoaHocModel? icon) {
                              setState(() {
                                selectedValueStudent = icon!.id.toString();
                              });
                            },
                            dropdownMenuEntries: listYearStudent
                                .map<DropdownMenuEntry<KhoaHocModel>>(
                              (KhoaHocModel icon) {
                                return DropdownMenuEntry<KhoaHocModel>(
                                  value: icon,
                                  label: icon.name.toString(),
                                  // leadingIcon: icon.!id.toString(),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownMenu<ClasssModel>(
                          width: MediaQuery.of(context).size.width * 0.45,
                          controller: classController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Search'),
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (ClasssModel? icon) {
                            setState(() {
                              selectedValueclass = icon!.id.toString();
                            });
                          },
                          dropdownMenuEntries:
                              listClasss.map<DropdownMenuEntry<ClasssModel>>(
                            (ClasssModel icon) {
                              return DropdownMenuEntry<ClasssModel>(
                                value: icon,
                                label: icon.name.toString(),
                                // leadingIcon: icon.!id.toString(),
                              );
                            },
                          ).toList(),
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
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Trạng thái: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        )),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: DropdownMenu<StudentYear>(
                          width: MediaQuery.of(context).size.width * 0.45,
                          controller: statusEditingController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Status'),
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (StudentYear? icon) {
                            setState(() {
                              statusValue = icon!.id.toString();
                            });
                          },
                          dropdownMenuEntries:
                              listStatus.map<DropdownMenuEntry<StudentYear>>(
                            (StudentYear icon) {
                              return DropdownMenuEntry<StudentYear>(
                                value: icon,
                                label: "${icon.name}",
                                // leadingIcon: icon.!id.toString(),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    )
                  ],
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
