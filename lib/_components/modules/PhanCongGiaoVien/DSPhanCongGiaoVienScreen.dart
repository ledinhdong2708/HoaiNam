import 'package:appflutter_one/_components/_services/PhanCongGiaoVien/PhanCongGiaoVienService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/PhanCongGiaoVien/PhanCongGiaoVienCardScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/DiemDanh/DiemDanhService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/dropdown_student.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'ChiTietPhanCongGiaoVienScreen.dart';
import 'AddNewGiaoVien.dart';

class DSPhanCongGiaoVienScreen extends StatefulWidget {
  String img;
  String text;
  DSPhanCongGiaoVienScreen(this.img, this.text);

  @override
  State<DSPhanCongGiaoVienScreen> createState() =>
      _DSPhanCongGiaoVienScreenState();
}

class _DSPhanCongGiaoVienScreenState extends State<DSPhanCongGiaoVienScreen> {
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
    FetchGiaoVien();

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
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewGiaoVien()),
              );
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
            onRefresh: FetchGiaoVien,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(16),
                          itemCount: items.length,
                          shrinkWrap: false,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            return PhanCongGiaoVienCardScreen(
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

  Future<void> FetchGiaoVien() async {
    final response = await PhanCongGiaoVienService.FetchGiaoVien();
    if (response != null) {
      setState(() {
        items = response;
        print(response);
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
      builder: (context) => ChiTietPhanCongGiaoVienScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchGiaoVien();
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

  Future<void> FetchChangeListAll(String classID, String khoahocID) async {
    if (khoahocID == null ||
        classID == null ||
        khoahocID == "" ||
        classID == "") {
      isLoading = false;
      return;
    }
    final response = await PhanCongGiaoVienService.FetchAllPhanCongGiaoVien(
        classID, khoahocID);
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
