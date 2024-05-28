import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/_services/XinNghiPhep/XinNghiPhepService.dart';
import 'package:appflutter_one/_components/_services/XinNghiPhepGv/XinNghiPhepGvService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/shared/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';

class GV_EditChiTietXinNghiPhepScreen extends StatefulWidget {
  final Map? item;
  const GV_EditChiTietXinNghiPhepScreen({Key? key, this.item})
      : super(key: key);

  @override
  State<GV_EditChiTietXinNghiPhepScreen> createState() =>
      _GV_EditChiTietXinNghiPhepScreenState();
}

class _GV_EditChiTietXinNghiPhepScreenState
    extends State<GV_EditChiTietXinNghiPhepScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  dynamic data = {};
  String? tokenDevice = "";
  final TextEditingController contentEditingController =
      TextEditingController();
  void initState() {
    super.initState();
    selectedDateFrom = DateTime.parse(widget.item!["fromDate"]);
    selectedDateTo = DateTime.parse(widget.item!["toDate"]);
    contentEditingController.text = widget.item!["content"];
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Cập nhật",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: () {
              data = {
                "id": widget.item!["id"],
                "userId": widget.item!["userId"],
                "studentId": widget.item!["studentId"],
                "xinNghiPhepId": widget.item!["xinNghiPhepId"],
                "createDate": widget.item!["createDate"],
                "updateDate": widget.item!["updateDate"],
                "content": contentEditingController.text,
                "fromDate":
                    DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                        .format(selectedDateFrom),
                "toDate": DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                    .format(selectedDateTo),
                "appID": widget.item!["appID"],
              };
              ischeck();
              // updateData();
            },
            child: const Padding(
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
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () => _selectDateFrom(context),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff4ca3ff),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${selectedDateFrom.day}/${selectedDateFrom.month}/${selectedDateFrom.year}",
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () => _selectDateTo(context),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xff4ca3ff),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${selectedDateTo.day}/${selectedDateTo.month}/${selectedDateTo.year}",
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contentEditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    labelText: "Nội dung",
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 25,
                      color: Colors.red,
                    ),
                    filled: false,
                    fillColor: const Color(0x00ff0004),
                    isDense: false,
                    contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
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

  Map? dsNghiPhep;
  Future<void> ischeck() async {
    int idPhep = widget.item!["id"];
    print(idPhep);
    final isSuccess = await XinNghiPhepService.ischeck(idPhep);
    print('oke');
    if (isSuccess != null) {
      setState(() {
        Map responseData = isSuccess["data"];
        List<dynamic> chiTietXinNghiPheps = responseData["chiTietXinNghiPheps"];
        chiTietXinNghiPheps.forEach((element) {
          element["content"] = contentEditingController.text;
          element["fromDate"] =
              DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                  .format(selectedDateFrom);
          element["toDate"] =
              DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                  .format(selectedDateTo);
        });
        print(responseData);
        responseData["chiTietXinNghiPheps"] = chiTietXinNghiPheps;
        dsNghiPhep = responseData;
        print("ahhfjs");
        print(dsNghiPhep);

        updateData();
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
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

  Future<void> updateData() async {
    int idPhep = widget.item!["id"];
    final isSuccess =
        await XinNghiPhepGvService.updateDataGV(idPhep, dsNghiPhep!);

    if (isSuccess == true) {
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(UpdatebodyFirebase)});
      Navigator.pop(context, data);
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật xin nghỉ",
        "body": "Xin nghỉ từ phụ huynh đã được cập nhật !"
      }
    };
  }
}
