import 'package:appflutter_one/_components/_services/DanThuoc/DanThuocService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/DanThuoc/ChiTietDanThuocCardScreen.dart';
import 'package:appflutter_one/_components/modules/DanThuoc/ChiTietDanThuocScreen.dart';
import 'package:appflutter_one/_components/modules/DanThuoc/DanThuocCardScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../_services/DiemDanh/DiemDanhService.dart';
import '../../_services/HocSinh/HocSinhService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/classs.dart';
import '../../models/dropdown_student.dart';
import '../../models/student_years.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'AddChiTietDanThuocScreen.dart';

class DSDanThuocScreen extends StatefulWidget {
  //final Map? item;
  String img;
  String text;
  DSDanThuocScreen(this.img, this.text);

  @override
  State<DSDanThuocScreen> createState() => _DSDanThuocScreenState();
}

class _DSDanThuocScreenState extends State<DSDanThuocScreen> {
  bool _showData = false;

  DateTime selectedDate = DateTime.now();
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  String? selectedValueclass = "1";
  String? selectedValueStudent = "0";
  String selectYearValueStudent = "";
  late DropdownStudent selectItemStudent;
  final TextEditingController studentEditingController =
      TextEditingController();
  final TextEditingController classEditingController = TextEditingController();
  // List
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  List<ClasssModel> listClasss = <ClasssModel>[];
  List<DropdownStudent> itemStudents = [
    DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
  ];
  final TextEditingController studentYearController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  //API
  List items = [];
  void initState() {
    super.initState();
    FetchKhoaHoc();
    FetchClasss();
    // FetchTodo();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     if(listYearStudent.length > 0) {
    //       FetchChangeListAll(listYearStudent.first.id.toString(),
    //           listClasss.first.id.toString());
    //     }
    //   });
    // });

    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

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
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
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
            onRefresh: FetchListStudent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownMenu<KhoaHocModel>(
                                width: MediaQuery.of(context).size.width * 0.40,
                                controller: studentYearController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Khóa Học'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (KhoaHocModel? icon) {
                                  setState(() {
                                    selectedValueStudent = icon!.id.toString();
                                    FetchListStudent();
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
                              label: const Text('Lớp'),
                              inputDecorationTheme: const InputDecorationTheme(
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.transparent),
                              onSelected: (ClasssModel? icon) {
                                setState(() {
                                  selectedValueclass = icon!.id.toString();
                                  FetchListStudent();
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
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.all(0),
                                    padding: const EdgeInsets.all(0),
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4ca3ff),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          color: const Color(0x4d9e9e9e),
                                          width: 1),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                  width: 10,
                                ),
                                MaterialButton(
                                  onPressed: () => _selectDate(context),
                                  color: const Color(0xff498fff),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: const BorderSide(
                                        color: Color(0xff808080), width: 1),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(
                                    "images/20.png",
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                  textColor: const Color(0xffffffff),
                                  height: 40,
                                  minWidth: 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                      child: _showData
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(16),
                              itemCount: items.length,
                              shrinkWrap: false,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = items[index] as Map;
                                return DanThuocCardScreen(
                                    index: index,
                                    item: item,
                                    navigationEdit: navigateToEditPage);
                              })
                          : Container(
                              child: Text("Không có dữ liệu"),
                            )),
                ],
              ),
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
      lastDate: DateTime(2035),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        FetchListStudent();
      });
  }

  Future<void> FetchListStudent() async {
    if (selectedValueStudent == null ||
        selectedValueStudent == null ||
        selectedValueclass == "" ||
        selectedValueclass == "") {
      isLoading = false;
      return;
    }
    final response = await DanThuocService.FetchDanThuoc(
        selectedValueclass!,
        selectedValueStudent!,
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString());
    if (response != null) {
      setState(() {
        items = response;
        _showData = true;
        print(items);
      });
    } else {
      _showData = false;
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddChiTietDanThuocScreen(
        item: item,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchListStudent();
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

  Future<void> FetchChangeListAll(String studentID, String classID) async {
    if (studentID == null ||
        classID == null ||
        studentID == "" ||
        classID == "") {
      isLoading = false;
      return;
    }
    final response =
        await HocSinhService.FetchByKhoaHocAndClass(studentID, classID);
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
}
