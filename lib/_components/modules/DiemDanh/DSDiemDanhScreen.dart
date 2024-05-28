import 'package:appflutter_one/_components/_services/DiemDanh/DiemDanhService.dart';
import 'package:appflutter_one/_components/_services/sendEmail/sendDD.dart';
import 'package:appflutter_one/_components/_services/sendSMSService/sendSMS.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/DiemDanh/DiemDanhCardScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/KhoaHocModel.dart';
import 'ChiTietDiemDanhScreen.dart';
import '../../_services/HocSinh/HocSinhService.dart';
import '../../_services/SoBeNgoan/SoBeNgoanService.dart';
import '../../models/classs.dart';
import '../../models/dropdown_student.dart';
import '../../models/student_years.dart';
import '../../shared/utils/snackbar_helper.dart';
import '../DSHocSinh/HocSinhCardScreen.dart';
import 'dart:math' as math;

class DSDiemDanhScreen extends StatefulWidget {
  String img;
  String text;
  DSDiemDanhScreen(this.img, this.text);

  @override
  State<DSDiemDanhScreen> createState() => _DSDiemDanhScreenState();
}

class _DSDiemDanhScreenState extends State<DSDiemDanhScreen> {
  NotificationService _notificationService = NotificationService();
  // Avaiable
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  bool isEdit = false;
  String? selectedValueclass;
  String? selectedValueStudent;
  String? selectYearValueStudent;
  late DropdownStudent selectItemStudent;
  final TextEditingController studentEditingController =
      TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  // List
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  List<ClasssModel> listClasss = <ClasssModel>[];
  List<DropdownStudent> itemStudents = [
    DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
  ];

  //API
  List items = [];
  void initState() {
    super.initState();
    FetchKhoaHoc();
    FetchClasss();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.text,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
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
        Visibility(
            visible: isLoading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
            replacement: RefreshIndicator(
              onRefresh: FetchTodo,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => _selectDate(context),
                                borderRadius: BorderRadius.circular(50),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    "images/20.png",
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
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
                                controller: yearController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Search'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (KhoaHocModel? icon) {
                                  setState(() {
                                    selectYearValueStudent =
                                        icon!.id.toString();
                                    FetchChangeListAll(selectYearValueStudent!,
                                        selectedValueclass!);
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
                                  FetchChangeListAll(selectYearValueStudent!,
                                      selectedValueclass!);
                                });
                              },
                              dropdownMenuEntries: listClasss
                                  .map<DropdownMenuEntry<ClasssModel>>(
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
                    Expanded(
                        flex: 1,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(16),
                            itemCount: items.length,
                            shrinkWrap: false,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = items[index] as Map;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                                        padding: EdgeInsets.all(0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        decoration: item["status"] == "0"
                                            ? BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.green[100]!,
                                                  Colors.green[900]!,
                                                ]),
                                                boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0, 0),
                                                      color: Colors.green[100]!,
                                                      blurRadius: 16.0,
                                                    ),
                                                    BoxShadow(
                                                      offset: Offset(0, 0),
                                                      color: Colors.green[200]!,
                                                      blurRadius: 16.0,
                                                    ),
                                                    BoxShadow(
                                                      offset: Offset(0, 0),
                                                      color: Colors.green[300]!,
                                                      blurRadius: 16.0,
                                                    ),
                                                  ])
                                            : BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.red[100]!,
                                                  Colors.red[900]!,
                                                ]),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 0),
                                                    color: Colors.red[100]!,
                                                    blurRadius: 16.0,
                                                  ),
                                                  BoxShadow(
                                                    offset: Offset(0, 0),
                                                    color: Colors.red[200]!,
                                                    blurRadius: 16.0,
                                                  ),
                                                  BoxShadow(
                                                    offset: Offset(0, 0),
                                                    color: Colors.red[300]!,
                                                    blurRadius: 16.0,
                                                  ),
                                                ],
                                              ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item["nameStudent"]!,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 12),
                                              child: Text(
                                                "${item["class1"]} (${item["year1"]})",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ), //CheckboxListTile
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          RadioListTile(
                                            title: const Text("Đến lớp",
                                                style: TextStyle(fontSize: 12)),
                                            value: "0",
                                            groupValue: item["status"],
                                            onChanged: (value) {
                                              setState(() {
                                                item["status"] =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: const Text("Không phép",
                                                style: TextStyle(fontSize: 12)),
                                            value: "1",
                                            groupValue: item["status"],
                                            onChanged: (value) {
                                              setState(() {
                                                item["status"] =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          RadioListTile(
                                            title: const Text("Có phép",
                                                style: TextStyle(fontSize: 12)),
                                            value: "2",
                                            groupValue: item["status"],
                                            onChanged: (value) {
                                              setState(() {
                                                item["status"] =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ), //Container
                              );
                              // return DiemDanhCardScreen(
                              //     index: index,
                              //     item: item,
                              //     navigationEdit: navigateToEditPage);
                            })),
                  ],
                ),
              ),
            )),
      ]),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2055),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    if ((selectYearValueStudent == null && selectedValueclass == null)) {
      return;
    } else {
      FetchChangeListAll(selectYearValueStudent!, selectedValueclass!);
    }
  }

  Future<void> FetchListStudent(classname) async {
    final response = await DiemDanhService.FetchClassNameStudent(classname);
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> FetchTodo() async {}

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietDiemDanhScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchChangeListAll(selectYearValueStudent!, selectedValueclass!);
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
      isLoading = false;
    });
  }

  Future<void> FetchDiemDanhStatusUpdate() async {
    final response = await DiemDanhService.FetchDiemDanhStatusUpdate(
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString());
    if (response != null) {
      setState(() {
        if (response.length > 0) {
          isEdit = true;
        } else {
          isEdit = false;
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> FetchChangeListAll(String studentID, String classID) async {
    if ((studentID != null && classID != null) ||
        (studentID != "" && classID != "")) {
      final response = await HocSinhService.FetchByKhoaHocAndClassDate(
          studentID,
          classID,
          selectedDate.day.toString(),
          selectedDate.month.toString(),
          selectedDate.year.toString());
      if (response != null) {
        setState(() {
          FetchDiemDanhStatusUpdate();
          for (int i = 0; i < response.length; i++) {
            if (response[i]["coPhep"] == true) {
              response[i]["status"] = "2";
            } else if (response[i]["denLop"] == true) {
              response[i]["status"] = "0";
            } else if (response[i]["khongPhep"] == true) {
              response[i]["status"] = "1";
            } else {
              response[i]["status"] = "0";
            }
          }
          // FetchDiemDanhStatusUpdate();
          items = response;
        });
      } else {
        showErrorMessage(context, message: 'Something went wrong');
      }
      setState(() {
        isLoading = false;
      });
    }
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
      isLoading = false;
    });
  }

  ChangeStatusCheckBoxAndAddList(valueCheckBox, item) {
    // if (valueCheckBox) {
    //   if(postion == 0) {
    //     items[items.indexWhere((element) => element["id"] == item["id"])]["denlop"] = true;
    //   }
    //   else if(postion == 1) {
    //     items[items.indexWhere((element) => element["id"] == item["id"])]["khongphep"] = true;
    //   }
    //   else if(postion == 2) {
    //     items[items.indexWhere((element) => element["id"] == item["id"])]["cophep"] = true;
    //   }
    // } else {
    //   if(postion == 0) {
    //     items[items.indexWhere((element) => element["id"] == item["id"])]["denlop"] = false;
    //   }
    //   else if(postion == 1) {
    //     items[items.indexWhere((element) => element["id"] == item["id"])]["khongphep"] = false;
    //   }
    //   else if(postion == 2) {
    //     items[items.indexWhere((element) => element["id"] == item["id"])]["cophep"] = false;
    //   }
    // }
    // print(item);
  }
  void showErrorMessage(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> submitData() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map> body = [];
      for (int i = 0; i < items.length; i++) {
        body.add({
          "studentId": items[i]["id"],
          "content":
              "${items[i]["id"].toString()}_${DateTime.now().toString()}",
          "denLop": items[i]["status"] == "0" ? true : false,
          "coPhep": items[i]["status"] == "2" ? true : false,
          "khongPhep": items[i]["status"] == "1" ? true : false,
          "CreateDate": "",
          "is_completed": true
        });
      }
      final isSuccess = await DiemDanhService.submitData(body);
      final sendEmail = await sendDiemDanhService.sendEmailDD(
          selectedValueclass, selectYearValueStudent);
      // final sendSMS = await sendSMSDiemDanhService.sendSMSDDs(
      //     selectedValueclass, selectYearValueStudent);

      if (isSuccess && sendEmail) {
        selectedDate = DateTime.now();
        showSuccessMessage(context, message: 'Cập nhật thành công');
      } else {
        showErrorMessage(context, message: 'Gửi Email thất bại');
      }
    } catch (e) {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateData() async {
    setState(() {
      isLoading = true;
    });
    List<Map> body = [];
    for (int i = 0; i < items.length; i++) {
      body.add({
        "studentId": items[i]["id"],
        "content": "${items[i]["id"].toString()}_${DateTime.now().toString()}",
        "denLop": items[i]["status"] == "0" ? true : false,
        "coPhep": items[i]["status"] == "2" ? true : false,
        "khongPhep": items[i]["status"] == "1" ? true : false,
        "CreateDate": "",
        "is_completed": true,
        "idDiemDanh": items[i]["idDiemDanh"]
      });
    }
    final isSuccess = await DiemDanhService.updateData(body);
    final sendEmail = await sendDiemDanhService.sendEmailDD(
        selectedValueclass, selectYearValueStudent);
    // final sendSMS = await sendSMSDiemDanhService.sendSMSDDs(
    //     selectedValueclass, selectYearValueStudent);

    if (isSuccess && sendEmail) {
      selectedDate = DateTime.now();
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Gửi Email thất bại');
    }
    setState(() {
      isLoading = false;
    });
  }
}
