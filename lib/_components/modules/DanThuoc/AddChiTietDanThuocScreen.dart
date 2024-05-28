import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';

class AddChiTietDanThuocScreen extends StatefulWidget {
  final Map? item;
  // final int studentID;
  const AddChiTietDanThuocScreen({Key? key, this.item}) : super(key: key);

  @override
  State<AddChiTietDanThuocScreen> createState() =>
      _AddChiTietDanThuocScreenScreenState();
}

class _AddChiTietDanThuocScreenScreenState
    extends State<AddChiTietDanThuocScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;
  bool isLoading = false;
  TextEditingController contentEditingController = new TextEditingController();
  // List

  @override
  void initState() {
    super.initState();
    final _status = widget.item;
    if (_status != null) {
      isEdit = true;
      selectedDate = DateTime.parse(widget.item!["docDate"]);
      contentEditingController.text = widget.item!["content"];
    }
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService
        .getDeviceToken()
        .then((value) => {tokenDevice = value});
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
          'Ngày ${DateTime.parse(widget.item!["docDate"]).day}/${DateTime.parse(widget.item!["docDate"]).month}/${DateTime.parse(widget.item!["docDate"]).year}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff4ca3ff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Họ và tên : ${widget.item!['nameStudent']}",
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
                ],
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                child: TextField(
                  controller: contentEditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 10,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 1),
                    ),
                    labelText: "Nội dung",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 25,
                      color: Colors.yellow,
                    ),
                    filled: false,
                    fillColor: Color(0x00ff0004),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
