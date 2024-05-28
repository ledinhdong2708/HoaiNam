import 'package:appflutter_one/_components/_services/DiemDanh/DiemDanhService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class ChiTietDiemDanhScreen extends StatefulWidget {
  final Map? item;
  const ChiTietDiemDanhScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietDiemDanhScreen> createState() => _ChiTietDiemDanhScreenState();
}

class _ChiTietDiemDanhScreenState extends State<ChiTietDiemDanhScreen> {
  NotificationService _notificationService = NotificationService();
  String? typeOff;
  bool isLoading = false;
  Map itemDiemDanh = {};

  void initState() {
    super.initState();
    FetchDiemDanhItem();
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
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Điểm danh",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: submitData,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.save,
                color: Color(0xFF674AEF),
              ),
            ),
          ),
          InkWell(
            onTap: updateData,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.edit,
                color: Color(0xFF674AEF),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Bé hôm nay có đi học không?",
                style: TextStyle(fontSize: 18),
              ),
              Divider(),
              RadioListTile(
                title: Text("Đến lớp"),
                value: "1",
                groupValue: typeOff,
                onChanged: (value) {
                  setState(() {
                    typeOff = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text("Có phép"),
                value: "2",
                groupValue: typeOff,
                onChanged: (value) {
                  setState(() {
                    typeOff = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text("Không phép"),
                value: "3",
                groupValue: typeOff,
                onChanged: (value) {
                  setState(() {
                    typeOff = value.toString();
                  });
                },
              )
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> FetchDiemDanhItem() async {
    final response =
        await DiemDanhService.FetchStudentIdWithDate(widget.item!["id"]);
    if (response != null) {
      setState(() {
        itemDiemDanh = response;
        print("ádjhashdajsd");
        print(itemDiemDanh);
        setState(() {
          if (itemDiemDanh["denLop"] == true) {
            typeOff = "1";
          } else if (itemDiemDanh["coPhep"] == true) {
            typeOff = "2";
          } else if (itemDiemDanh["khongPhep"] == true) {
            typeOff = "3";
          }
        });
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitData() async {}
  Future<void> updateData() async {}
  Map get body {
    DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
    return {
      // "UserId": 0,
      // "Role": 1,
      "studentId": widget.item!["id"],
      "content": '',
      "denLop": typeOff == '1' ? true : false,
      "coPhep": typeOff == '2' ? true : false,
      "khongPhep": typeOff == '3' ? true : false,
      "CreateDate": "",
      "is_completed": true
    };
  }
}
