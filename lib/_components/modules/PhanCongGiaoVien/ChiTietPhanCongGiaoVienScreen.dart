import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/PhanCongGiaoVien/ChiTietPhanCongGiaoVienCardScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/PhanCongGiaoVien/PhanCongGiaoVienService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'AddChiTietPhanCongGiaoVienScreen.dart';

class ChiTietPhanCongGiaoVienScreen extends StatefulWidget {
  final Map? item;
  const ChiTietPhanCongGiaoVienScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietPhanCongGiaoVienScreen> createState() =>
      _ChiTietPhanCongGiaoVienScreenState();
}

class _ChiTietPhanCongGiaoVienScreenState
    extends State<ChiTietPhanCongGiaoVienScreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  // List
  List items = [
    // {"id": "1", "name": "Thảo ABC"},
    // {"id": "2", "name": "Thảo XYZ"}
  ];
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
        actions: [
          InkWell(
            onTap: navigateToAddPage,
            child: Padding(
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
        Padding(
          padding: EdgeInsets.all(20),
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
    print("widget.item![" "]");
    print(widget.item!["id"]);
    final response =
        await PhanCongGiaoVienService.FetchPhanCongGiaoVien(widget.item!["id"]);
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

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) =>
          AddChiTietPhanCongGiaoVienScreen(studentID: widget.item!["id"]),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchPhanCongGiaoVien();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddChiTietPhanCongGiaoVienScreen(
        item: item,
        studentID: widget.item!["id"],
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchPhanCongGiaoVien();
  }
}
