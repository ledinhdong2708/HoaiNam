import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';

class EditChiTietXinNghiPhepScreen extends StatefulWidget {
  final Map? item;
  const EditChiTietXinNghiPhepScreen({Key? key, this.item}) : super(key: key);

  @override
  State<EditChiTietXinNghiPhepScreen> createState() =>
      _EditChiTietXinNghiPhepScreenState();
}

class _EditChiTietXinNghiPhepScreenState
    extends State<EditChiTietXinNghiPhepScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  dynamic data = {};
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
        title: Text(
          "Cập nhật",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: () {
              // data.add({
              //   "id": 0,
              //   "content": contentEditingController.text,
              //   "fromDate":
              //   DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
              //       .format(selectedDateFrom),
              //   "toDate": DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
              //       .format(selectedDateTo),
              //   "createDate": "",
              //   "updateDate": "",
              //   "userId": 0,
              //   "studentId": widget.studentId
              // });
              data = {
                "id": widget.item!["id"],
                "content": contentEditingController.text,
                "fromDate":
                    DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                        .format(selectedDateFrom),
                "toDate": DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
                    .format(selectedDateTo),
                "createDate": widget.item!["createDate"],
                "updateDate": widget.item!["updateDate"],
                "userId": widget.item!["userId"],
                "studentId": widget.item!["studentId"],
                "addnew": widget.item!["addnew"]
              };
              Navigator.pop(context, data);
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
}
