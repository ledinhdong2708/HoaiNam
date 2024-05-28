import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/DinhDuong/DinhDuongService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class PH_DinhDuongScreen extends StatefulWidget {
  String img;
  String text;
  PH_DinhDuongScreen(this.img, this.text);
  // const PH_DinhDuongScreen({Key? key}) : super(key: key);

  @override
  State<PH_DinhDuongScreen> createState() => _PH_DinhDuongScreenState();
}

class _PH_DinhDuongScreenState extends State<PH_DinhDuongScreen> {
  NotificationService _notificationService = NotificationService();

  String buoiSang = " ";
  String buoiTrua = " ";
  String buoiChinhChieu = " ";
  String buoiPhuChieu = " ";
  String dam = " ";
  String damDinhMuc = " ";
  String beo = " ";
  String beoDinhMuc = " ";
  String duong = " ";
  String duongDinhMuc = " ";
  String nangLuong = " ";
  String nangLuongDinhMuc = " ";
  void initState() {
    super.initState();
    FetchDinhDuong();
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
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Colors.black26, width: 1),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      color: Color(0xffffffff),
                      shadowColor: Color(0xff000000),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.purple, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: Alignment(-1.0, 0.2),
                                      child: Text(
                                        "Bữa sáng",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Colors.purple),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        buoiSang.isEmpty
                                            ? "Không nội dung"
                                            : buoiSang,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image(
                                    image: AssetImage("images/sang.png"),
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      color: Color(0xffffffff),
                      shadowColor: Color(0xff000000),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Color(0xffff0000), width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: Alignment(-1.0, 0.2),
                                      child: Text(
                                        "Bữa trưa",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffff0000)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        buoiTrua.isEmpty
                                            ? "Không nội dung"
                                            : buoiTrua,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image(
                                    image: AssetImage("images/trua.png"),
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      color: Color(0xffffffff),
                      shadowColor: Color(0xff000000),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Color(0xff05cd20), width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: Alignment(-1.0, 0.2),
                                      child: Text(
                                        "Bữa xế",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff05cd20)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        buoiChinhChieu.isEmpty
                                            ? "Không nội dung"
                                            : buoiChinhChieu,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image(
                                    image: AssetImage("images/chinhchieu.png"),
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      color: Color(0xffffffff),
                      shadowColor: Color(0xff000000),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Color(0xff0077dd), width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: Alignment(-1.0, 0.2),
                                      child: Text(
                                        "Bữa phụ chiều",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff0077dd)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        buoiPhuChieu.isEmpty
                                            ? "Không nội dung"
                                            : buoiPhuChieu,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image(
                                    image: AssetImage("images/phuchieu.png"),
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: 215,
                      decoration: BoxDecoration(
                        color: Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                      margin: EdgeInsets.all(4),
                                      color: Color(0xffffffff),
                                      shadowColor: Color(0xff000000),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xffff9f00), width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(0),
                                              width: 140,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0x00ffffff),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 0, 0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        "Đạm",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xffff9f00),
                                                        ),
                                                      ),
                                                      Text(
                                                        dam.isEmpty ? "0" : dam,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xffff9f00),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Định mức",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xffff9f00),
                                                        ),
                                                      ),
                                                      Text(
                                                        damDinhMuc.isEmpty
                                                            ? "0"
                                                            : damDinhMuc,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xffff9f00),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                margin: EdgeInsets.all(0),
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5, 5, 0),
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Color(0x00ffffff),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                child: Image(
                                                  image: AssetImage(
                                                      "images/dam.png"),
                                                  height: 56,
                                                  width: 60,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                      margin: EdgeInsets.all(4),
                                      color: Color(0xffffffff),
                                      shadowColor: Color(0xff000000),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                margin: EdgeInsets.all(0),
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 5, 0, 0),
                                                width: 54,
                                                height: 54,
                                                decoration: BoxDecoration(
                                                  color: Color(0x00ffffff),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                child: Image(
                                                  image: AssetImage(
                                                      "images/beo.png"),
                                                  width: 54,
                                                  height: 54,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(0),
                                              width: 200,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0x00ffffff),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 5, 10, 0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        "Béo",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                      Text(
                                                        beo.isEmpty ? "0" : beo,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Định mức",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                      Text(
                                                        beoDinhMuc.isEmpty
                                                            ? "0"
                                                            : beoDinhMuc,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                      margin: EdgeInsets.all(4),
                                      color: Color(0xffffffff),
                                      shadowColor: Color(0xff000000),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xff003aff), width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(0),
                                              width: 200,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0x00ffffff),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 0, 0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        "Đường",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff003aff),
                                                        ),
                                                      ),
                                                      Text(
                                                        duong.isEmpty
                                                            ? "0"
                                                            : duong,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff003aff),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Định mức",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff003aff),
                                                        ),
                                                      ),
                                                      Text(
                                                        duongDinhMuc.isEmpty
                                                            ? "0"
                                                            : duongDinhMuc,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff003aff),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                margin: EdgeInsets.all(0),
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5, 5, 5),
                                                width: 54,
                                                height: 54,
                                                decoration: BoxDecoration(
                                                  color: Color(0x00ffffff),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                child: Image(
                                                  image: AssetImage(
                                                      "images/duong.png"),
                                                  height: 54,
                                                  width: 54,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                      margin: EdgeInsets.all(4),
                                      color: Color(0xffffffff),
                                      shadowColor: Color(0xff000000),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xff6c00ff), width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                margin: EdgeInsets.all(0),
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                width: 54,
                                                height: 54,
                                                decoration: BoxDecoration(
                                                  color: Color(0x00ffffff),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                child:

                                                    ///***If you have exported images you must have to copy those images in assets/images directory.
                                                    Image(
                                                  image: AssetImage(
                                                      "images/nangluong.png"),
                                                  height: 54,
                                                  width: 54,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(0),
                                              width: 200,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0x00ffffff),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 5, 10, 0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        "Năng lượng",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff6c00ff),
                                                        ),
                                                      ),
                                                      Text(
                                                        nangLuong.isEmpty
                                                            ? "0"
                                                            : nangLuong,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff6c00ff),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Định mức",
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff6c00ff),
                                                        ),
                                                      ),
                                                      Text(
                                                        nangLuongDinhMuc.isEmpty
                                                            ? "0"
                                                            : nangLuongDinhMuc,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff6c00ff),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> FetchDinhDuong() async {
    DateTime date = DateTime.now();
    final response = await DinhDuongService.PH_FetchDinhDuongByStudent(
        date.day, date.month, date.year);
    if (response != null) {
      setState(() {
        buoiSang = response["buoiSang"] == null
            ? "Không nội dung"
            : response["buoiSang"];
        buoiTrua = response["buoiTrua"] == null
            ? "Không nội dung"
            : response["buoiTrua"];
        buoiChinhChieu = response["buoiChinhChieu"] == null
            ? "Không nội dung"
            : response["buoiChinhChieu"];
        buoiPhuChieu = response["buoiPhuChieu"] == null
            ? "Không nội dung"
            : response["buoiPhuChieu"];
        dam = response["dam"] == null ? "0" : response["dam"];
        damDinhMuc =
            response["damDinhMuc"] == null ? "0" : response["damDinhMuc"];
        beo = response["beo"] == null ? "0" : response["beo"];
        beoDinhMuc =
            response["beoDinhMuc"] == null ? "0" : response["beoDinhMuc"];
        duong = response["duong"] == null ? "0" : response["duong"];
        duongDinhMuc =
            response["duongDinhMuc"] == null ? "0" : response["duongDinhMuc"];
        nangLuong = response["nangLuong"] == null ? "0" : response["nangLuong"];
        nangLuongDinhMuc = response["nangLuongDinhMuc"] == null
            ? "0"
            : response["nangLuongDinhMuc"];
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }
}
