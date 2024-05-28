import 'dart:convert';

import 'package:appflutter_one/_components/_services/HocPhi/HocPhiModelService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/HocPhi/AddHocPhiAllScereen.dart';
import 'package:appflutter_one/_components/modules/HocPhi/HocPhiCardScreen.dart';
import 'package:appflutter_one/_components/modules/sendEmail/sendThongBaol.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../_services/HocSinh/HocSinhService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/KhoaHocModel.dart';
import '../../models/dropdown_student.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'DSChiTietHocPhiScreen.dart';
import 'package:http/http.dart' as http;

class DSHocPhiScreen extends StatefulWidget {
  String img;
  String text;
  DSHocPhiScreen(this.img, this.text, {super.key});
  // const DSHocPhiScreen({Key? key}) : super(key: key);

  @override
  State<DSHocPhiScreen> createState() => _DSHocPhiScreenState();
}

class _DSHocPhiScreenState extends State<DSHocPhiScreen> {
  NotificationService _notificationService = NotificationService();
  // Avarible
  bool isLoading = false;
  String? selectedValueclass = "1";
  String? selectedValueStudent = "0";
  String selectyearValueStudent = "";
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
  List apiData = [];
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

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'ko',
    decimalDigits: 0,
    symbol: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Cập Nhật Học Phí",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              if (choice == 'Thêm học phí mới') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ADDHocPhiAllScreen()),
                );
              } else if (choice == 'Thông báo') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sendEmail()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Thêm học phí mới', 'Thông báo'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
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
            onRefresh: FetchData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                            child: DropdownMenu<KhoaHocModel>(
                              width: MediaQuery.of(context).size.width * 0.40,
                              controller: studentEditingController,
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
                                  selectyearValueStudent = icon!.id.toString();
                                  FetchChangeListAll(selectyearValueStudent,
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
                            width: MediaQuery.of(context).size.width * 0.40,
                            controller: classEditingController,
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
                                FetchChangeListAll(selectyearValueStudent,
                                    selectedValueclass!);
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
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(16),
                          itemCount: items.length,
                          shrinkWrap: false,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            return HocPhiCardScreen(
                                index: index,
                                item: item,
                                navigationEdit: navigateToEditPage);
                          })),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> FetchData() async {
    final response = await HocSinhService.FetchByKhoaHocAndClass(
        selectyearValueStudent, selectedValueclass!);
    if (selectyearValueStudent == null ||
        selectedValueclass == null ||
        selectyearValueStudent == "" ||
        selectedValueclass == "") {
      isLoading = false;
      return;
    }
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

  Future<void> navigateToEditPage(Map item) async {
    print("object");
    print(item);
    final route = MaterialPageRoute(
      builder: (context) => DSChiTietHocPhiScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchChangeListAll(selectyearValueStudent, selectedValueclass!);
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
