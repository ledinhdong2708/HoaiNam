import 'package:appflutter_one/_components/_services/KhoaHoc/KhoaHocService.dart';
import 'package:appflutter_one/_components/_services/MaterHocPhi/MaterHocPhiService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../_services/Classs/ClassService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class ChiTietMaterHocPhiScreen extends StatefulWidget {
  final Map? item;
  const ChiTietMaterHocPhiScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietMaterHocPhiScreen> createState() =>
      _ChiTietMaterHocPhiScreenState();
}

class _ChiTietMaterHocPhiScreenState extends State<ChiTietMaterHocPhiScreen> {
  NotificationService _notificationService = NotificationService();
  bool isEdit = false;
  bool isLoading = false;
  String? typeOff;
  final TextEditingController contentEditingController =
      TextEditingController();
  final TextEditingController donViTinhEditingController =
      TextEditingController();
  List items = [];
  bool isTextcontent = true;
  bool isTextdonViTinh = true;
  void initState() {
    super.initState();
    final _class = widget.item;
    if (_class != null) {
      isEdit = true;
      contentEditingController.text = _class["content"].toString();
      donViTinhEditingController.text = _class["donViTinh"].toString();
      if (_class["isCompleted"] == true) {
        typeOff = "0";
      } else if (_class["isCompleted"] == false) {
        typeOff = "1";
      }
    }
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  bool isAllFieldsValid() {
    return contentEditingController.text.isNotEmpty &&
        donViTinhEditingController.text.isNotEmpty &&
        isTextcontent &&
        isTextdonViTinh;
  }

  bool isTextValid(String inputText) {
    // Sử dụng biểu thức chính quy để kiểm tra xem chuỗi không chứa các ký tự đặc biệt, nhưng vẫn chấp nhận các ký tự chữ cái có dấu
    String textRegex = r'^[a-zA-ZÀ-ỹ\s]*$';
    return RegExp(textRegex).hasMatch(inputText);
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
          (isEdit ? ("${widget.item!["content"]}") : "Thêm mới"),
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap:
                isAllFieldsValid() ? (isEdit ? updateData : submitData) : null,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                isAllFieldsValid()
                    ? (isEdit ? Icons.edit : Icons.save)
                    : Icons.error,
                color: isAllFieldsValid() ? Color(0xFF674AEF) : Colors.red,
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
              controller: contentEditingController,
              obscureText: false,
              onChanged: (contentEditingController) {
                setState(() {
                  isTextcontent = isTextValid(contentEditingController);
                });
              },
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
                labelText: "Nội dung",
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
            if (!isTextcontent)
              Text(
                'Vui lòng không nhập số là kí tự đặt biết ',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            SizedBox(height: 10),
            TextField(
              controller: donViTinhEditingController,
              obscureText: false,
              textAlign: TextAlign.start,
              onChanged: (donViTinhEditingController) {
                setState(() {
                  isTextdonViTinh = isTextValid(donViTinhEditingController);
                });
              },
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
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                labelText: "Đơn vị",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                  color: Colors.red,
                ),
                filled: false,
                fillColor: Color(0x00ff0004),
                isDense: false,
                contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
              ),
            ),
            if (!isTextdonViTinh)
              Text(
                'Vui lòng không nhập số là kí tự đặt biết ',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "Trạng thái: ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    )),
                Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile(
                          title: Text("Hiển thị"),
                          value: "0",
                          groupValue: typeOff,
                          onChanged: (value) {
                            setState(() {
                              typeOff = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text("Không hiển thị"),
                          value: "1",
                          groupValue: typeOff,
                          onChanged: (value) {
                            setState(() {
                              typeOff = value.toString();
                            });
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Future<void> submitData() async {
    final isSuccess = await MaterHocPhiService.submitData(body);

    if (isSuccess) {
      contentEditingController.text = '';
      donViTinhEditingController.text = '';
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
    final isSuccess = await MaterHocPhiService.updateData(id.toString(), body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
    return {
      "content": contentEditingController.text,
      "donViTinh": donViTinhEditingController.text,
      "isCompleted": typeOff == "0" ? true : false,
      "CreateDate": "",
    };
  }
}
