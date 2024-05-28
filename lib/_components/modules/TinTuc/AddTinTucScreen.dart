import 'package:appflutter_one/_components/_services/TinTuc/TinTucService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddTinTucScreen extends StatefulWidget {
  final Map? item;
  const AddTinTucScreen({Key? key, this.item}) : super(key: key);

  @override
  State<AddTinTucScreen> createState() => _AddTinTucScreenState();
}

class _AddTinTucScreenState extends State<AddTinTucScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController contentEditingController =
      TextEditingController();

  void initState() {
    super.initState();
    final tintucchitiet = widget.item;
    if (tintucchitiet != null) {
      isEdit = true;
      selectedDate = DateTime.parse(widget.item!["createDate"]);
      titleEditingController.text = widget.item!["title"];
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
            (isEdit ? "Cập nhật" : "Thêm mới"),
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          actions: [
            InkWell(
              onTap: isEdit ? updateData : submitData,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  isEdit ? Icons.edit : Icons.save,
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
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(16),
                          shrinkWrap: false,
                          physics: ScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: Color(0x4d9e9e9e), width: 1),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                    width: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: () => _selectDate(context),
                                    color: Color(0xff498fff),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      side: BorderSide(
                                          color: Color(0xff808080), width: 1),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Image.asset(
                                      "images/20.png",
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover,
                                    ),
                                    textColor: Color(0xffffffff),
                                    height: 40,
                                    minWidth: 40,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: titleEditingController,
                              obscureText: false,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.yellow, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.yellow, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.yellow, width: 1),
                                ),
                                labelText: "Tiêu đề",
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 25,
                                  color: Colors.yellow,
                                ),
                                filled: false,
                                fillColor: Color(0x00ff0004),
                                isDense: false,
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 20, 12, 20),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
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
                                  borderSide: BorderSide(
                                      color: Color(0xffff0000), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Color(0xffff0000), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Color(0xffff0000), width: 1),
                                ),
                                labelText: "Nội dung",
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 25,
                                  color: Colors.red,
                                ),
                                filled: false,
                                fillColor: Color(0x00ff0004),
                                isDense: false,
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 20, 12, 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

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

  Future<void> submitData() async {
    final isSuccess = await TinTucService.submitData(body);

    if (isSuccess) {
      selectedDate = DateTime.now();
      var InsertbodyFirebase = {
        "to": tokenDevice,
        "priority": "high",
        "notification": {
          "title": "Thêm mới tin tức",
          "body": "Tin tức ${titleEditingController.text} đã được tạo mới !"
        }
      };
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
      titleEditingController.text = " ";
      contentEditingController.text = " ";
      Navigator.pop(context);
      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> updateData() async {
    final itemUpdate = widget.item!["id"];
    print(widget.item!["id"]);
    if (itemUpdate == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = itemUpdate;
    // final isCompleted = todo['is_completed'];
    final isSuccess = await TinTucService.updateData(id.toString(), body);

    if (isSuccess) {
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(UpdatebodyFirebase)});
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    return {
      "title": titleEditingController.text,
      "content": contentEditingController.text,
      "createDate": "",
      "isCompleted": true
    };
  }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật tin tức",
        "body":
            "${widget.item!["title"]} được cập nhật thành ${titleEditingController.text} !"
      }
    };
  }
}
