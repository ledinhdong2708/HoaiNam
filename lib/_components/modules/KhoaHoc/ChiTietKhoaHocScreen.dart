import 'package:appflutter_one/_components/_services/KhoaHoc/KhoaHocService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class ChiTietKhoaHocScreen extends StatefulWidget {
  final Map? item;
  const ChiTietKhoaHocScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietKhoaHocScreen> createState() => _ChiTietKhoaHocScreenState();
}

class _ChiTietKhoaHocScreenState extends State<ChiTietKhoaHocScreen> {
  NotificationService _notificationService = NotificationService();
  bool isEdit = false;
  bool isLoading = false;
  final TextEditingController fromDateEditingController =
      TextEditingController();
  final TextEditingController toDateEditingController = TextEditingController();
  List items = [];

  void initState() {
    super.initState();
    final _khoaHoc = widget.item;
    if (_khoaHoc != null) {
      isEdit = true;
      fromDateEditingController.text = _khoaHoc["fromYear"].toString();
      toDateEditingController.text = _khoaHoc["toYear"].toString();
    }
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
          (isEdit
              ? ("${widget.item!["fromYear"].toString()}-${widget.item!["toYear"].toString()}")
              : "Thêm mới"),
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
        ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: fromDateEditingController,
              decoration: new InputDecoration(labelText: "Từ năm"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            SizedBox(height: 20),
            TextField(
              controller: toDateEditingController,
              decoration: new InputDecoration(labelText: "Đến năm"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ],
        ),
      ]),
    );
  }

  Future<void> submitData() async {
    final isSuccess = await KhoaHocService.submitData(body);

    if (isSuccess) {
      fromDateEditingController.text = '';
      toDateEditingController.text = '';
      Navigator.pop(context);
      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
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
    final isSuccess = await KhoaHocService.updateData(id.toString(), body);

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
      "fromYear": fromDateEditingController.text,
      "toYear": toDateEditingController.text,
      "CreateDate": "",
      "is_completed": true,
    };
  }
}
