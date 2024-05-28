import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/MaterBieuDo/MaterBieuDoCardScreen.dart';
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
import 'ChiTietMaterBieuDoScreen.dart';

class DSMaterBieuDoScreen extends StatefulWidget {
  String img;
  String text;
  DSMaterBieuDoScreen(this.img, this.text);
  // const DSMaterBieuDoScreen({Key? key}) : super(key: key);

  @override
  State<DSMaterBieuDoScreen> createState() => _DSMaterBieuDoScreenState();
}

class _DSMaterBieuDoScreenState extends State<DSMaterBieuDoScreen> {
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
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     if(listYearStudent.length > 0) {
    //       FetchChangeListAll(listYearStudent.first.id.toString(),
    //           listClasss.first.id.toString());
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
                            // DropdownMenu<StudentYear>(
                            //   width: MediaQuery.of(context).size.width * 0.4,
                            //   initialSelection: list.first,
                            //   onSelected: (StudentYear? value) {
                            //     setState(() {
                            //       dropdownValueStudent = value!.id.toString();
                            //     });
                            //   },
                            //   dropdownMenuEntries: list
                            //       .map<DropdownMenuEntry<StudentYear>>(
                            //           (StudentYear value) {
                            //     return DropdownMenuEntry<StudentYear>(
                            //         label: value.name, value: value);
                            //   }).toList(),
                            // ),
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
                            return MaterBieuDoCardScreen(
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

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietMaterBieuDoScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    // FetchListStudent(listClasss.first.name);
    FetchChangeListAll(selectyearValueStudent, selectedValueclass!);
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
