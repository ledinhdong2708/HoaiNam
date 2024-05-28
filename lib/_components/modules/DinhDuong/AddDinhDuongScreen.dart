import 'package:appflutter_one/_components/_services/DinhDuong/DinhDuongService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/HoatDong/HoatDongService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/KhoaHocModel.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddDinhDuongScreen extends StatefulWidget {
  // final Map? item;
  DateTime _date;
  bool isEdit;
  int status;
  String? classId;
  String? khoaHocId;

  AddDinhDuongScreen(
      this._date, this.isEdit, this.status, this.classId, this.khoaHocId);
  @override
  State<AddDinhDuongScreen> createState() => _AddDinhDuongScreenState();
}

class _AddDinhDuongScreenState extends State<AddDinhDuongScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
  late int id;

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

  bool isEdit = false;
  bool isLoading = false;
  final TextEditingController buoiSangEditingController =
      TextEditingController();
  final TextEditingController buoiTruaEditingController =
      TextEditingController();
  final TextEditingController buoiChinhChieuEditingController =
      TextEditingController();
  final TextEditingController buoiPhuChieuEditingController =
      TextEditingController();
  final TextEditingController buoiDamEditingController =
      TextEditingController();
  final TextEditingController buoiDamDinhMucEditingController =
      TextEditingController();
  final TextEditingController buoiBeoEditingController =
      TextEditingController();
  final TextEditingController buoiBeoDinhMucEditingController =
      TextEditingController();
  final TextEditingController buoiDuongEditingController =
      TextEditingController();
  final TextEditingController buoiDuongDinhMucEditingController =
      TextEditingController();
  final TextEditingController buoiNangLuongEditingController =
      TextEditingController();
  final TextEditingController buoiNangLuongDinhMucEditingController =
      TextEditingController();
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  List<ClasssModel> listClasss = <ClasssModel>[];

  String selectedValueclass = "";
  String selectedValueYear = "";
  final TextEditingController classController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final _status = widget.status;
    FetchKhoaHoc();
    FetchClasss();
    if (_status == 2) {
      isEdit = true;
      selectedDate = widget._date;
      selectedValueYear = widget.khoaHocId.toString();
      selectedValueclass = widget.classId.toString();
      // buoiSangEditingController.text = " ";
      // buoiTruaEditingController.text = " ";
      // buoiChinhChieuEditingController.text = " ";
      // buoiPhuChieuEditingController.text = " ";
      // buoiDamEditingController.text = " ";
      // buoiDamDinhMucEditingController.text = " ";
      // buoiBeoEditingController.text = " ";
      // buoiBeoDinhMucEditingController.text = " ";
      // buoiDuongEditingController.text = " ";
      // buoiDuongDinhMucEditingController.text = " ";
      // buoiNangLuongEditingController.text = " ";
      // buoiNangLuongDinhMucEditingController.text = " ";
      FetchDinhDuong();
    }
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
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
          (widget.isEdit ? "Cập nhật" : "Thêm mới"),
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: isEdit ? updateData : submitData,
            child: Padding(
              padding: EdgeInsets.all(10),
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                    borderRadius: BorderRadius.circular(100.0),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: DropdownMenu<KhoaHocModel>(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    controller: yearController,
                                    enableFilter: true,
                                    requestFocusOnTap: true,
                                    leadingIcon: const Icon(Icons.search),
                                    label: const Text('Search'),
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                            filled: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                            border: OutlineInputBorder(),
                                            fillColor: Colors.transparent),
                                    onSelected: (KhoaHocModel? icon) {
                                      setState(() {
                                        selectedValueYear = icon!.id.toString();
                                        // FetchDinhDuong();
                                      });
                                    },
                                    dropdownMenuEntries: listYearStudent
                                        .map<DropdownMenuEntry<KhoaHocModel>>(
                                      (KhoaHocModel icon) {
                                        return DropdownMenuEntry<KhoaHocModel>(
                                          value: icon,
                                          label: icon.name.toString(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: DropdownMenu<ClasssModel>(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    controller: classController,
                                    enableFilter: true,
                                    requestFocusOnTap: true,
                                    leadingIcon: const Icon(Icons.search),
                                    label: const Text('Search'),
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                            filled: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                            border: OutlineInputBorder(),
                                            fillColor: Colors.transparent),
                                    onSelected: (ClasssModel? icon) {
                                      setState(() {
                                        selectedValueclass =
                                            icon!.id.toString();
                                        // FetchDinhDuong();
                                      });
                                    },
                                    dropdownMenuEntries: listClasss
                                        .map<DropdownMenuEntry<ClasssModel>>(
                                      (ClasssModel icon) {
                                        return DropdownMenuEntry<ClasssModel>(
                                          value: icon,
                                          label: icon.name.toString(),
                                          // leadingIcon: icon.!id.toString(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: buoiSangEditingController,
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
                                borderSide:
                                    BorderSide(color: Colors.yellow, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: Colors.yellow, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: Colors.yellow, width: 1),
                              ),
                              labelText: "Buổi sáng",
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
                            controller: buoiTruaEditingController,
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
                              labelText: "Buổi trưa",
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
                          SizedBox(height: 20),
                          TextField(
                            controller: buoiChinhChieuEditingController,
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
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1),
                              ),
                              labelText: "Buổi xế chiều",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 25,
                                color: Colors.green,
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
                            controller: buoiPhuChieuEditingController,
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
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 1),
                              ),
                              labelText: "Buổi phụ chiều",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 25,
                                color: Colors.lightBlueAccent,
                              ),
                              filled: false,
                              fillColor: Color(0x00ff0004),
                              isDense: false,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 20, 12, 20),
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(
                            color: Color(0xff808080),
                            height: 10,
                            thickness: 4,
                            indent: 0,
                            endIndent: 0,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiDamEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      labelText: "Đạm",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25,
                                        color: Colors.orangeAccent,
                                      ),
                                      filled: false,
                                      fillColor: Color(0x00ff0004),
                                      isDense: false,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 20, 12, 20),
                                      suffix: Text("g",
                                          style: TextStyle(
                                              color: Colors.orangeAccent))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiDamDinhMucEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      labelText: "Định mức",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25,
                                        color: Colors.orangeAccent,
                                      ),
                                      filled: false,
                                      fillColor: Color(0x00ff0004),
                                      isDense: false,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 20, 12, 20),
                                      suffix: Text("g",
                                          style: TextStyle(
                                              color: Colors.orangeAccent))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiBeoEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 1),
                                      ),
                                      labelText: "Béo",
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
                                      suffix: Text("g",
                                          style:
                                              TextStyle(color: Colors.yellow))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiBeoDinhMucEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 1),
                                      ),
                                      labelText: "Định mức",
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
                                      suffix: Text("g",
                                          style:
                                              TextStyle(color: Colors.yellow))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiDuongEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      labelText: "Đường",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25,
                                        color: Colors.blue,
                                      ),
                                      filled: false,
                                      fillColor: Color(0x00ff0004),
                                      isDense: false,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 20, 12, 20),
                                      suffix: Text("g",
                                          style: TextStyle(color: Colors.blue))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiDuongDinhMucEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      labelText: "Định mức",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25,
                                        color: Colors.blue,
                                      ),
                                      filled: false,
                                      fillColor: Color(0x00ff0004),
                                      isDense: false,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 20, 12, 20),
                                      suffix: Text("g",
                                          style: TextStyle(color: Colors.blue))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: buoiNangLuongEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      labelText: "Năng lượng",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25,
                                        color: Colors.purple,
                                      ),
                                      filled: false,
                                      fillColor: Color(0x00ff0004),
                                      isDense: false,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 20, 12, 20),
                                      suffix: Text("kcal",
                                          style:
                                              TextStyle(color: Colors.purple))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller:
                                      buoiNangLuongDinhMucEditingController,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 1),
                                      ),
                                      labelText: "Định mức",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25,
                                        color: Colors.purple,
                                      ),
                                      filled: false,
                                      fillColor: Color(0x00ff0004),
                                      isDense: false,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 20, 12, 20),
                                      suffix: Text("kcal",
                                          style:
                                              TextStyle(color: Colors.purple))
                                      // suffixIcon: Icon(Icons.circle,
                                      //     color: Color(0xff212435), size: 24),
                                      ),
                                ),
                              )
                            ],
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
      ]),
    );
  }

  Future<void> FetchKhoaHoc() async {
    List<KhoaHocModel> lsKhoaHoc = [];
    List<KhoaHocModel> lsKhoaHoc1 = [];
    final response = await SharedSerivce.FetchListKhoaHoc();
    if (response != null) {
      setState(() {
        lsKhoaHoc = response as List<KhoaHocModel>;
        for (int i = 0; i < lsKhoaHoc.length; i++) {
          lsKhoaHoc1.add(lsKhoaHoc[i]);
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      // listYearStudent = lsKhoaHoc1;
      listYearStudent = lsKhoaHoc1;
      if (isEdit) {
        listYearStudent.forEach((element) {
          if (element.id.toString() == widget.khoaHocId) {
            selectedValueYear = element.id.toString();
            yearController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> FetchClasss() async {
    List<ClasssModel> lsClasss = [];
    List<ClasssModel> lsClasss1 = [];
    final response = await SharedSerivce.FetchListClasss();
    if (response != null) {
      setState(() {
        lsClasss = response as List<ClasssModel>;
        for (int i = 0; i < lsClasss.length; i++) {
          lsClasss1.add(lsClasss[i]);
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listClasss = lsClasss1;
      if (isEdit) {
        listClasss.forEach((element) {
          if (element.id.toString() == widget.classId) {
            selectedValueclass = element.id.toString();
            classController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> FetchDinhDuong() async {
    // if (selectedValueYear == null ||
    //     selectedValueYear == null ||
    //     selectedValueclass == "" ||
    //     selectedValueclass == "") {
    //   isLoading = false;
    //   return;
    // }
    final response = await DinhDuongService.FetchDinhDuong(
        selectedDate.day,
        selectedDate.month,
        selectedDate.year,
        selectedValueYear!,
        selectedValueclass!);
    if (response != null) {
      setState(() {
        selectedValueYear = response["khoaHocID"].toString();
        selectedValueclass = response["classID"].toString();
        id = response["id"] == null ? 0 : response["id"];
        buoiSangEditingController.text = response["buoiSang"] == null
            ? "Không nội dung"
            : response["buoiSang"];
        buoiTruaEditingController.text = response["buoiTrua"] == null
            ? "Không nội dung"
            : response["buoiTrua"];
        buoiChinhChieuEditingController.text =
            response["buoiChinhChieu"] == null
                ? "Không nội dung"
                : response["buoiChinhChieu"];
        buoiPhuChieuEditingController.text = response["buoiPhuChieu"] == null
            ? "Không nội dung"
            : response["buoiPhuChieu"];
        buoiDamEditingController.text =
            response["dam"] == null ? "0" : response["dam"];
        buoiDamDinhMucEditingController.text =
            response["damDinhMuc"] == null ? "0" : response["damDinhMuc"];
        buoiBeoEditingController.text =
            response["beo"] == null ? "0" : response["beo"];
        buoiBeoDinhMucEditingController.text =
            response["beoDinhMuc"] == null ? "0" : response["beoDinhMuc"];
        buoiDuongEditingController.text =
            response["duong"] == null ? "0" : response["duong"];
        buoiDuongDinhMucEditingController.text =
            response["duongDinhMuc"] == null ? "0" : response["duongDinhMuc"];
        buoiNangLuongEditingController.text =
            response["nangLuong"] == null ? "0" : response["nangLuong"];
        buoiNangLuongDinhMucEditingController.text =
            response["nangLuongDinhMuc"] == null
                ? "0"
                : response["nangLuongDinhMuc"];
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitData() async {
    final isSuccess = await DinhDuongService.submitData(body);

    if (isSuccess) {
      selectedDate = DateTime.now();
      buoiSangEditingController.text = " ";
      buoiTruaEditingController.text = " ";
      buoiChinhChieuEditingController.text = " ";
      buoiPhuChieuEditingController.text = " ";
      buoiDamEditingController.text = " ";
      buoiDamDinhMucEditingController.text = " ";
      buoiBeoEditingController.text = " ";
      buoiBeoDinhMucEditingController.text = " ";
      buoiDuongEditingController.text = " ";
      buoiDuongDinhMucEditingController.text = " ";
      buoiNangLuongEditingController.text = " ";
      buoiNangLuongDinhMucEditingController.text = " ";
      Navigator.pop(context);
      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> updateData() async {
    final itemUpdate = widget.status;
    if (itemUpdate != 2) {
      print('You can not call update without todo data');
      return;
    }
    // final id = id.toString();
    // final isCompleted = todo['is_completed'];
    final isSuccess = await DinhDuongService.updateData(id.toString(), body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    String formattedDate = DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
        .format(selectedDate);
    return {
      "docDate": formattedDate,
      "buoiSang": buoiSangEditingController.text,
      "buoiTrua": buoiTruaEditingController.text,
      "buoiChinhChieu": buoiChinhChieuEditingController.text,
      "buoiPhuChieu": buoiPhuChieuEditingController.text,
      "dam": buoiDamEditingController.text,
      "damDinhMuc": buoiDamDinhMucEditingController.text,
      "beo": buoiBeoEditingController.text,
      "beoDinhMuc": buoiBeoDinhMucEditingController.text,
      "duong": buoiDuongEditingController.text,
      "duongDinhMuc": buoiDuongDinhMucEditingController.text,
      "nangLuong": buoiNangLuongEditingController.text,
      "nangLuongDinhMuc": buoiNangLuongDinhMucEditingController.text,
      "createDate": "",
      "isCompleted": true,
      "classID": selectedValueclass,
      "khoaHocID": selectedValueYear
    };
  }
}
