import 'package:appflutter_one/_components/_services/HocSinh/HocSinhService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/PhanCongGiaoVien/ChiTietPhanCongGiaoVienCardScreen.dart';
import 'package:appflutter_one/_components/modules_giaovien/HoatDong/GV_HoatDongSreen.dart';
import 'package:appflutter_one/_components/modules_phuhuynh/HoatDong/PH_ChiTietHoatDongScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/PhanCongGiaoVien/PhanCongGiaoVienService.dart';
import '../../shared/utils/snackbar_helper.dart';

class PH_DSPhanCongSreen extends StatefulWidget {
  String img;
  String text;
  PH_DSPhanCongSreen(this.img, this.text);

  @override
  State<PH_DSPhanCongSreen> createState() => _PH_DSPhanCongSreen();
}

class _PH_DSPhanCongSreen extends State<PH_DSPhanCongSreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  // List
  List items = [];
  Map? Class;
  String IdClass1 = "";
  String IdKhoaHoc1 = "";
  String IdClass2 = "";
  String IdKhoaHoc2 = "";
  String IdClass3 = "";
  String IdKhoaHoc3 = "";
  int id = 0;
  @override
  void initState() {
    super.initState();
    FetchStudent();
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
          "Danh sách",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(0),
                  itemCount: items.length,
                  shrinkWrap: false,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = items[index] as Map;
                    return ChiTietPhanCongGiaoVienCardScreen(
                        index: index,
                        item: item,
                        navigationEdit: navigateToEditPage);
                  },
                ),
              ),
            ],
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
        FetchPHPhanCong(
            IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3);
      });
  }

  Future<void> FetchPHPhanCong(
      IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3) async {
    final response = await PhanCongGiaoVienService.DSHoatDongPH(
        IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3);
    if (response != null) {
      setState(() {
        items = response;
        for (var item in response) {
          id = item['userAdd'];
          print("userAdd: $id");
        }
        print("userAdd: $id");
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> FetchStudent() async {
    final response = await HocSinhService.FetchStudentClass();
    if (response != null) {
      setState(() {
        Class = response["studentClass"];
        print(Class);
        IdClass1 = Class!["class1"];
        IdKhoaHoc1 = Class!["year1"];
        IdClass2 = Class!["class2"] ?? "0";
        IdKhoaHoc2 = Class!["year2"] ?? "0";
        IdClass3 = Class!["class3"] ?? "0";
        IdKhoaHoc3 = Class!["year3"] ?? "0";
        FetchPHPhanCong(
            IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3);
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => PH_ChiTietHoatDongScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchPHPhanCong(
        IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3);
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => PH_ChiTietHoatDongScreen(
        item: item,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchPHPhanCong(
        IdClass1, IdKhoaHoc1, IdClass2, IdKhoaHoc2, IdClass3, IdKhoaHoc3);
  }
}
