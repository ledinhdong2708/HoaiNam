import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/PhanCongGiaoVien/AddChiTietPhanCongGiaoVienScreen.dart';
import 'package:appflutter_one/_components/modules/PhanCongGiaoVien/ChiTietPhanCongGiaoVienCardScreen.dart';
import 'package:appflutter_one/_components/modules_giaovien/HoatDong/GV_HoatDongSreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/PhanCongGiaoVien/PhanCongGiaoVienService.dart';
import '../../shared/utils/snackbar_helper.dart';

class GV_HoatDongSreen extends StatefulWidget {
  String img;
  String text;
  GV_HoatDongSreen(this.img, this.text);

  @override
  State<GV_HoatDongSreen> createState() =>
      _ChiTietPhanCongGiaoVienScreenState();
}

class _ChiTietPhanCongGiaoVienScreenState extends State<GV_HoatDongSreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  int id = 0;
  // List
  List items = [];
  @override
  void initState() {
    super.initState();
    FetchPhanCongGiaoVien();

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
        title: const Text(
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
        FetchPhanCongGiaoVien();
      });
  }

  Future<void> FetchPhanCongGiaoVien() async {
    final response = await PhanCongGiaoVienService.DSHoatDong();
    if (response != null) {
      setState(() {
        items = response;

        // Lặp qua mảng dữ liệu để lấy giá trị userAdd
        for (var item in response) {
          id = item['userAdd']; // Lấy giá trị của trường userAdd
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

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => GV_HoatDongScreen(studentID: id),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchPhanCongGiaoVien();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => GV_HoatDongScreen(
        item: item,
        studentID: id,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchPhanCongGiaoVien();
  }
}
