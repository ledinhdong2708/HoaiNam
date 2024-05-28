import 'dart:convert';

import 'package:appflutter_one/_components/_services/KhoaHoc/KhoaHocService.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../_services/Classs/ClassService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class ChiTietClassScreen extends StatefulWidget {
  final Map? item;
  const ChiTietClassScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietClassScreen> createState() => _ChiTietClassScreenState();
}

class _ChiTietClassScreenState extends State<ChiTietClassScreen> {
  NotificationService _notificationService = NotificationService();
  bool isEdit = false;
  bool isLoading = false;
  final TextEditingController nameClassEditingController =
      TextEditingController();
  List items = [];

  bool isText = true;

  String? tokenDevice = "";

  void initState() {
    super.initState();
    final _class = widget.item;
    if (_class != null) {
      isEdit = true;
      nameClassEditingController.text = _class["nameClass"].toString();
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

  bool isTextValid(String inputText) {
    // Sử dụng biểu thức chính quy để kiểm tra xem chuỗi không chứa các ký tự đặc biệt, nhưng vẫn chấp nhận các chữ cái có dấu, số và khoảng trắng
    String textRegex = r'^[a-zA-ZÀ-ỹ0-9\s]*$';
    return RegExp(textRegex).hasMatch(inputText);
  }

  bool isAllFieldsValid() {
    return isText && nameClassEditingController.text.isNotEmpty;
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
          (isEdit ? ("${widget.item!["nameClass"]}") : "Thêm mới"),
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap:
                isAllFieldsValid() ? (isEdit ? updateData : submitData) : null,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: isAllFieldsValid()
                  ? Icon(
                      isEdit ? Icons.edit : Icons.save,
                      color: Color(0xFF674AEF),
                    )
                  : const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: nameClassEditingController,
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              onChanged: (nameController) {
                setState(() {
                  isText = isTextValid(nameController);
                });
              },
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Colors.green, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Colors.green, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Colors.green, width: 1),
                ),
                labelText: "Tên lớp",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                  color: Colors.green,
                ),
                filled: false,
                fillColor: Color(0x00ff0004),
                isDense: false,
                contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Future<void> submitData() async {
    final isSuccess = await ClassService.submitData(body);

    if (isSuccess) {
      var InsertbodyFirebase = {
        "to": tokenDevice,
        "priority": "high",
        "notification": {
          "title": "Thêm mới",
          "body": "Lớp ${nameClassEditingController.text} đã được tạo mới !"
        }
      };
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
      nameClassEditingController.text = '';
      Navigator.pop(context);

      showSuccessMessage(context, message: 'Thêm mới thành công');
    } else {
      showErrorMessage(context, message: 'Thêm mới thất bại');
    }
  }

  Future<void> updateData() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = itemUpdate['id'];
    // final isCompleted = todo['is_completed'];
    final isSuccess = await ClassService.updateData(id.toString(), body);

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
      "nameClass": nameClassEditingController.text,
      "CreateDate": "",
      "is_completed": true,
    };
  }

  // Map get InsertbodyFirebase {
  //   return {
  //     "to": tokenDevice,
  //     "priority": "high",
  //     "notification": {"title": "Thêm mới", "body": "Lớp ${nameClassEditingController.text} đã được tạo mới !"}
  //   };
  // }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật",
        "body":
            "${widget.item!["nameClass"]} được cập nhật thành ${nameClassEditingController.text} !"
      }
    };
  }
}
