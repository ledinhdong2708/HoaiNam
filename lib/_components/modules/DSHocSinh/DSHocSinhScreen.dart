import 'package:appflutter_one/_components/_services/HocSinh/HocSinhService.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/models/student_years.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/DSHocSinh/ChiTietHocSinhScreen.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/ChiTietHocPhiScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../models/classs.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'HocSinhCardScreen.dart';

class DSHocSinhScreen extends StatefulWidget {
  String img;
  String text;
  DSHocSinhScreen(this.img, this.text);
  // const CourseScreen({Key? key}) : super(key: key);

  @override
  State<DSHocSinhScreen> createState() => _DSHocSinhScreenState();
}

class _DSHocSinhScreenState extends State<DSHocSinhScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
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

  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];

  List<ClasssModel> listClasss = <ClasssModel>[];
  String selectYearStudentValue = "";
  String selectValueClass = "";
  bool isLoading = false;

  final TextEditingController yearStudentController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  //API
  List items = [];
  void initState() {
    super.initState();
    FetchKhoaHoc();
    FetchClasss();
    // FetchTodo();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();

    _notificationService.getDeviceToken();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     if(listYearStudent.length > 0) {
    //       FetchChangeListAll(listYearStudent.first.id.toString(),
    //           listYearStudent.first.id.toString());
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: navigateToAddPage,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.add,
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownMenu<KhoaHocModel>(
                              width: MediaQuery.of(context).size.width * 0.40,
                              controller: yearStudentController,
                              enableFilter: true,
                              requestFocusOnTap: true,
                              leadingIcon: const Icon(Icons.search),
                              label: const Text('Year'),
                              inputDecorationTheme: const InputDecorationTheme(
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.transparent),
                              onSelected: (KhoaHocModel? icon) {
                                setState(() {
                                  selectYearStudentValue = icon!.id.toString();
                                  FetchChangeListAll(
                                      selectYearStudentValue, selectValueClass);
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
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
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
                                  selectValueClass = icon!.id.toString();
                                  FetchChangeListAll(
                                      selectYearStudentValue, selectValueClass);
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
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(16),
                      itemCount: items.length,
                      shrinkWrap: false,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = items[index] as Map;
                        return HocSinhCardScreen(
                            index: index,
                            item: item,
                            navigationEdit: navigateToEditPage);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> FetchTodo() async {
    if (selectYearStudentValue == null ||
        selectValueClass == null ||
        selectYearStudentValue == "" ||
        selectValueClass == "") {
      isLoading = false;
      return;
    }
    final response = await HocSinhService.FetchByKhoaHocAndClass(
        selectYearStudentValue, selectValueClass);
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

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietHocSinhScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    // FetchTodo();
    FetchChangeListAll(selectYearStudentValue, selectValueClass);
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietHocSinhScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    // FetchTodo();
    FetchChangeListAll(selectYearStudentValue, selectValueClass);
  }
}
