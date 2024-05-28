import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/_services/XinNghiPhep/XinNghiPhepService.dart';
import 'package:appflutter_one/_components/_services/XinNghiPhepGv/XinNghiPhepGvService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/shared/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';

class GV_AddChiTietXinNghiPhep extends StatefulWidget {
  final String studentId;
  final List item;
  final bool isEdit;
  const GV_AddChiTietXinNghiPhep(
      {Key? key,
      required this.studentId,
      required this.item,
      required this.isEdit})
      : super(key: key);

  @override
  State<GV_AddChiTietXinNghiPhep> createState() =>
      _GV_AddChiTietXinNghiPhepState();
}

class _GV_AddChiTietXinNghiPhepState extends State<GV_AddChiTietXinNghiPhep> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  List data = [];
  final TextEditingController contentEditingController =
      TextEditingController();
  void initState() {
    super.initState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Thêm mới",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: () {
              data.add({
                "id": widget.isEdit ? data.last["id"] + 1 : 0,
                "content": contentEditingController.text,
                "fromDate":
                    DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                        .format(selectedDateFrom),
                "toDate": DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                    .format(selectedDateTo),
                "createDate": "",
                "updateDate": "",
                "userId": 0,
                "studentId": widget.studentId,
                "addnew": "0"
              });

              submitData();
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.save,
                color: Color(0xFF674AEF),
              ),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Từ ngày: ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () => _selectDateFrom(context),
                          child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xff4ca3ff),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${selectedDateFrom.day}/${selectedDateFrom.month}/${selectedDateFrom.year}",
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Đến ngày: ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () => _selectDateTo(context),
                          child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xff4ca3ff),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${selectedDateTo.day}/${selectedDateTo.month}/${selectedDateTo.year}",
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: contentEditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  _selectDateFrom(BuildContext context) async {
    final DateTime? pickedFrom = await showDatePicker(
      context: context,
      initialDate: selectedDateFrom,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedFrom != null && pickedFrom != selectedDateFrom)
      setState(() {
        selectedDateFrom = pickedFrom;
        // FetchDinhDuong();
      });
  }

  _selectDateTo(BuildContext context) async {
    final DateTime? pickeTo = await showDatePicker(
      context: context,
      initialDate: selectedDateTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickeTo != null && pickeTo != selectedDateTo)
      setState(() {
        selectedDateTo = pickeTo;
        // FetchDinhDuong();
      });
  }

  Future<void> submitData() async {
    final isSuccess = await XinNghiPhepGvService.submitDataGV(body);
    print("đâsdadadad");
    if (isSuccess == true) {
      var InsertbodyFirebase = {
        "to": tokenDevice,
        "priority": "high",
        "notification": {
          "title": "Thêm mới xin nghỉ",
          "body": "Có thông báo xin nghỉ phép mới !"
        }
      };
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
      // Quay lại trang trước đó
      Navigator.pop(context, data);

      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      data.clear();
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> FetchXinNghiPhepbyId() async {
    final response = await XinNghiPhepGvService.PH_FetchHocPhiByStudent();
    if (response != null) {
      setState(() {
        for (var item in response["data"]) {
          if (item["chiTietXinNghiPheps"] != null &&
              item["chiTietXinNghiPheps"] is List) {
            data.addAll(item["chiTietXinNghiPheps"]);
          }
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }

  Map get body {
    DateTime now = DateTime.now();
    return {
      "id": 0,
      "role": 0,
      "content": "",
      "studentId": widget.studentId,
      "userId": 0,
      "createDate":
          DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(now),
      "updateDate":
          DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(now),
      "isCompleted": true,
      "chiTietXinNghiPheps": data
    };
  }
}
