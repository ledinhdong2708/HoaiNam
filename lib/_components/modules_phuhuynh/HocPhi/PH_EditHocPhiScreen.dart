import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';

class PH_EditHocPhiScreen extends StatefulWidget {
  final Map item;
  // const PH_EditHocPhiScreen({Key? key,this.item}) : super(key: key);
  PH_EditHocPhiScreen(this.item);
  @override
  State<PH_EditHocPhiScreen> createState() => _PH_EditHocPhiScreenState();
}

class _PH_EditHocPhiScreenState extends State<PH_EditHocPhiScreen> {
  NotificationService _notificationService = NotificationService();
  List data = [];
  String valueSumString = "0";
  double total = 0;

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'ko',
    decimalDigits: 0,
    symbol: '',
  );
  void initState() {
    super.initState();
    data = widget.item["hocPhiChiTietModels"];
    print(data);
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
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Chi tiết",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemCount: data.length,
                    shrinkWrap: false,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = data[index] as Map;
                      return Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.yellow.withOpacity(1.0),
                        // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        //     .withOpacity(1.0),
                        elevation: 30,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: data[index]["content"]),
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      readOnly: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff000000),
                                      ),
                                      decoration: InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        labelText:
                                            "Tên (${data[index]["DonViTinh"]})",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        filled: false,
                                        fillColor: Color(0xfff2f2f3),
                                        isDense: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: TextField(
                                        // controller: TextEditingController(text: data[index]["value"].toString()),
                                        controller: TextEditingController(
                                            text: _formatter.format(data[index]
                                                    ["total"]
                                                .toString()
                                                .replaceAll('.0', ''))),
                                        obscureText: false,
                                        readOnly: true,
                                        textAlign: TextAlign.start,
                                        inputFormatters: [
                                          CurrencyTextInputFormatter(
                                            locale: 'ko',
                                            decimalDigits: 0,
                                            symbol: '',
                                          )
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // ChangeValueInList(value, index);
                                          // total = totalList(data).toString();
                                        },
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          labelText: "Giá trị",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: false,
                                          fillColor: Color(0xfff2f2f3),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                        ),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: "Số lượng"),
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      readOnly: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff000000),
                                      ),
                                      decoration: InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        filled: false,
                                        fillColor: Color(0xfff2f2f3),
                                        isDense: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: TextField(
                                        // controller: TextEditingController(text: data[index]["value"].toString()),
                                        controller: TextEditingController(
                                            text: data[index]["quantity"]
                                                .toString()),
                                        // text: _formatter.format(
                                        //     data[index]["quantity"].toString())),
                                        obscureText: false, readOnly: true,
                                        textAlign: TextAlign.start,
                                        inputFormatters: [
                                          CurrencyTextInputFormatter(
                                            locale: 'ko',
                                            decimalDigits: 0,
                                            symbol: '',
                                          )
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // ChangeValueInList(value, index);
                                          // ChangeValueQuantityInList(value, index);
                                        },
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          labelText: "Giá trị",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: false,
                                          fillColor: Color(0xfff2f2f3),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text("Số buổi nghỉ trong tháng")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(_formatter.format(widget
                                  .item["sobuoioff"]
                                  .toString()
                                  .replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Tổng cộng")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(_formatter.format(widget.item["total"]
                                  .toString()
                                  .replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Trừ phí nghỉ")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(_formatter.format(widget
                                  .item["phiOff"]
                                  .toString()
                                  .replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Còn lại")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              // child: Text(_formatter.format((
                              //     totalOff_Controller.text + total
                              // ).toString())),
                              child: Text(_formatter.format(widget
                                  .item["conLai"]
                                  .toString()
                                  .replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                    ],
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
