import 'dart:math';

import 'package:appflutter_one/_components/_services/ThoiKhoaBieu/ThoiKhoaBieuService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/KhoaHocModel.dart';
import '../../models/classs.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddThoiKhoaBieuScreen extends StatefulWidget {
  final Map? item;
  const AddThoiKhoaBieuScreen({Key? key, this.item}) : super(key: key);

  @override
  State<AddThoiKhoaBieuScreen> createState() => _ThoiKhoaBieuScreenState();
}

class _ThoiKhoaBieuScreenState extends State<AddThoiKhoaBieuScreen> {
  NotificationService _notificationService = NotificationService();
  bool isEdit = false;
  DateTime selectedDate = DateTime.now();
  List<ClasssModel> listClasss = <ClasssModel>[];
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];

  String? selectedValueClass;
  String selectedValueYear = "";
  final TextEditingController classEditingController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController ghiChuEditingController = TextEditingController();

  final TextEditingController time06300720EditingController =
      TextEditingController();
  final TextEditingController time07200730EditingController =
      TextEditingController();
  final TextEditingController time07300815EditingController =
      TextEditingController();
  final TextEditingController time08150845EditingController =
      TextEditingController();
  final TextEditingController time08450900EditingController =
      TextEditingController();
  final TextEditingController time09000930EditingController =
      TextEditingController();
  final TextEditingController time09301015EditingController =
      TextEditingController();
  final TextEditingController time10151115EditingController =
      TextEditingController();
  final TextEditingController time11151400EditingController =
      TextEditingController();
  final TextEditingController time14001415EditingController =
      TextEditingController();
  final TextEditingController time14151500EditingController =
      TextEditingController();
  final TextEditingController time15001515EditingController =
      TextEditingController();
  final TextEditingController time15151540EditingController =
      TextEditingController();
  final TextEditingController time15301630EditingController =
      TextEditingController();
  final TextEditingController time16301730EditingController =
      TextEditingController();
  final TextEditingController time17301815EditingController =
      TextEditingController();

  @override
  void dispose() {
    classEditingController.dispose();
    nameEditingController.dispose();
    ghiChuEditingController.dispose();

    time06300720EditingController.dispose();
    time07200730EditingController.dispose();
    time07300815EditingController.dispose();
    time08150845EditingController.dispose();
    time08450900EditingController.dispose();
    time09000930EditingController.dispose();
    time09301015EditingController.dispose();
    time10151115EditingController.dispose();
    time11151400EditingController.dispose();
    time14001415EditingController.dispose();
    time14151500EditingController.dispose();
    time15001515EditingController.dispose();
    time15151540EditingController.dispose();
    time15301630EditingController.dispose();
    time16301730EditingController.dispose();
    time17301815EditingController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    FetchKhoaHoc();
    FetchClasss();
    final tkb = widget.item;
    if (tkb != null) {
      isEdit = true;
      selectedDate = DateTime.parse(
          '${tkb['years']}-${tkb['months'].toString().padLeft(2, '0')}-${tkb['days'].toString().padLeft(2, '0')}');
      classEditingController.text = tkb['classTKB'] ?? "";
      nameEditingController.text = tkb['nameTKB'] ?? "";
      ghiChuEditingController.text = tkb['command'] ?? "";
      time06300720EditingController.text = tkb['time06300720'] ?? "";
      time07200730EditingController.text = tkb['time07200730'] ?? "";
      time07300815EditingController.text = tkb['time07300815'] ?? "";
      time08150845EditingController.text = tkb['time08150845'] ?? "";
      time08450900EditingController.text = tkb['time08450900'] ?? "";
      time09000930EditingController.text = tkb['time09000930'] ?? "";
      time09301015EditingController.text = tkb['time09301015'] ?? "";
      time10151115EditingController.text = tkb['time10151115'] ?? "";
      time11151400EditingController.text = tkb['time11151400'] ?? "";
      time14001415EditingController.text = tkb['time14001415'] ?? "";
      time14151500EditingController.text = tkb['time14151500'] ?? "";
      time15001515EditingController.text = tkb['time15001515'] ?? "";
      time15151540EditingController.text = tkb['time15151540'] ?? "";
      time15301630EditingController.text = tkb['time15301630'] ?? "";
      time16301730EditingController.text = tkb['time16301730'] ?? "";
      time17301815EditingController.text = tkb['time17301815'] ?? "";
    }

    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            (isEdit ? (widget.item?["nameTKB"]) : "Thêm mới"),
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
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            backgroundImage(),
            backgroundColor(context),
            ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(16),
              shrinkWrap: false,
              physics: ScrollPhysics(),
              children: [
                // Ngày --------------------------------------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Text(
                            'Ngày',
                            style: TextStyle(
                              fontSize: 25,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Colors.green[600]!,
                            ),
                          ),
                          Text(
                            'Ngày',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.lightGreenAccent[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _selectDate(context),
                              borderRadius: BorderRadius.circular(50),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.asset(
                                  "images/20.png",
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // Khóa học --------------------------------------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Text(
                            'Khóa',
                            style: TextStyle(
                              fontSize: 25,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Colors.green[600]!,
                            ),
                          ),
                          Text(
                            'Khóa',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.lightGreenAccent[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: DropdownMenu<KhoaHocModel>(
                          width: MediaQuery.of(context).size.width * 0.45,
                          controller: yearController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Search'),
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (KhoaHocModel? icon) {
                            setState(() {
                              selectedValueYear = icon!.id.toString();
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
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // Class -----------------------------------------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Text(
                            'Lớp',
                            style: TextStyle(
                              fontSize: 25,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Colors.green[600]!,
                            ),
                          ),
                          Text(
                            'Lớp',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.lightGreenAccent[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: DropdownMenu<ClasssModel>(
                          width: MediaQuery.of(context).size.width * 0.45,
                          controller: classEditingController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Search'),
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (ClasssModel? icon) {
                            setState(() {
                              selectedValueClass = icon!.id.toString();
                            });
                          },
                          dropdownMenuEntries:
                              listClasss.map<DropdownMenuEntry<ClasssModel>>(
                            (ClasssModel icon) {
                              return DropdownMenuEntry<ClasssModel>(
                                value: icon,
                                label: icon.name.toString(),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // // Name TKB --------------------------------------------------------
                // Stack(
                //   children: [
                //     Text(
                //       'Tên',
                //       style: TextStyle(
                //         fontSize: 25,
                //         foreground: Paint()
                //           ..style = PaintingStyle.stroke
                //           ..strokeWidth = 5
                //           ..color = Colors.green[600]!,
                //       ),
                //     ),
                //     // Solid text as fill.
                //     Text(
                //       'Tên',
                //       style: TextStyle(
                //         fontSize: 25,
                //         color: Colors.lightGreenAccent[200],
                //       ),
                //     ),
                //   ],
                // ),
                // Divider(
                //   color: Color(0xff808080),
                //   height: 20,
                //   thickness: 4,
                //   indent: 0,
                //   endIndent: 300,
                // ),
                // TextField(
                //   controller: nameEditingController,
                //   obscureText: false,
                //   textAlign: TextAlign.start,
                //   maxLines: 5,
                //   style: TextStyle(
                //     fontWeight: FontWeight.w400,
                //     fontStyle: FontStyle.normal,
                //     fontSize: 14,
                //     color: Color(0xff000000),
                //   ),
                //   decoration: InputDecoration(
                //     disabledBorder: InputBorder.none,
                //     focusedBorder: InputBorder.none,
                //     enabledBorder: InputBorder.none,
                //     filled: false,
                //     fillColor: Color(0xfff2f2f3),
                //     isDense: false,
                //     contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                //   ),
                // ),
                // DottedLine(
                //   direction: Axis.horizontal,
                //   lineLength: double.infinity,
                //   lineThickness: 1.0,
                //   dashLength: 4.0,
                //   dashColor: Colors.black,
                //   dashRadius: 0.0,
                //   dashGapLength: 4.0,
                //   dashGapColor: Colors.transparent,
                //   dashGapRadius: 0.0,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // // Name TKB --------------------------------------------------------
                // Ghi chú --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      'Ghi chú',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'Ghi chú',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: ghiChuEditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // Ghi chú --------------------------------------------------------
                // 06h30 - 07h20 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '06h30 - 07h20',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '06h30 - 07h20',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time06300720EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 7h20 - 7h30 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '07h20 - 07h30',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '07h20 - 07h30',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time07200730EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 7h30 - 8h15 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '07h30 - 08h15',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '07h30 - 08h15',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time07300815EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 8h15 - 8h45 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '08h15 - 08h45',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '08h15 - 08h45',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time08150845EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 8h45 - 09h00 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '08h45 - 09h00',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '08h45 - 09h00',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time08450900EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 09h00 – 09h30--------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '09h00 – 09h30',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '09h00 – 09h30',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time09000930EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 09h30 – 10h15 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '09h30 – 10h15',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '09h30 – 10h15',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time09301015EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 20,
                ),
                // 10h15 – 11h15 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '10h15 – 11h15',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '10h15 – 11h15',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time10151115EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),

                // 11h15 – 14h00 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '11h15 – 14h00',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '11h15 – 14h00',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time11151400EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 14h00 – 14h15 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '14h00 – 14h15',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '14h00 – 14h15',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time14001415EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 14h15 – 15h00 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '14h15 – 15h00',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '14h15 – 15h00',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time14151500EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 15h00 – 15h15 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '15h00 – 15h15',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '15h00 – 15h15',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time15001515EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 15h15 – 15h40 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '15h15 – 15h40',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '15h15 – 15h40',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time15151540EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 15h30 – 16h30 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '15h30 – 16h30',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '15h30 – 16h30',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time15301630EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 16h30 –  17h30 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '16h30 –  17h30',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '16h30 –  17h30',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time16301730EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),
                // 17h30 – 18h15 --------------------------------------------------------
                Stack(
                  children: [
                    Text(
                      '17h30 – 18h15',
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.green[600]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      '17h30 – 18h15',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.lightGreenAccent[200],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 20,
                  thickness: 4,
                  indent: 0,
                  endIndent: 300,
                ),
                TextField(
                  controller: time17301815EditingController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  maxLines: 5,
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
                    hintText: "Hoạt động",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(.5),
                    ),
                    filled: false,
                    fillColor: Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                SizedBox(
                  height: 40,
                ),

                // Container(
                //     child: FloatingActionButton.extended(
                //         onPressed: isEdit ? updateData : submitData,
                //         icon: Icon(Icons.save),
                //         label: Text(isEdit ? 'Cập nhật' : 'Lưu')))
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image(
                image: AssetImage("images/17.png"),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(.7),
              ),
            ),
          ],
        ),
      ),
    );
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
        lsClasss1.forEach((element) {
          if (element.id.toString() == widget.item!['classTKB']) {
            selectedValueClass = element.id.toString();
            classEditingController.text = element.name.toString();
          }
        });
      }
    });
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
      listYearStudent = lsKhoaHoc1;
      if (isEdit) {
        listYearStudent.forEach((element) {
          if (element.id.toString() == widget.item!['khoaHocId'].toString()) {
            selectedValueYear = element.id.toString();
            yearController.text = element.name.toString();
          }
        });
      }
    });
  }

  Future<void> submitData() async {
    final isSuccess = await ThoiKhoaBieuService.submitData(body);

    if (isSuccess) {
      classEditingController.text = '';
      nameEditingController.text = '';
      ghiChuEditingController.text = '';
      time06300720EditingController.text = "";
      time07200730EditingController.text = "";
      time07300815EditingController.text = "";
      time08150845EditingController.text = "";
      time08450900EditingController.text = "";
      time09000930EditingController.text = "";
      time09301015EditingController.text = "";
      time10151115EditingController.text = "";
      time11151400EditingController.text = "";
      time14001415EditingController.text = "";
      time14151500EditingController.text = "";
      time15001515EditingController.text = "";
      time15151540EditingController.text = "";
      time15301630EditingController.text = "";
      time16301730EditingController.text = "";
      time17301815EditingController.text = "";
      Navigator.pop(context);
      showSuccessMessage(context, message: 'Thêm mới thành công');
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
    final isSuccess = await ThoiKhoaBieuService.updateData(id.toString(), body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    return {
      // "UserId": 0,
      // "Role": 1,
      "classTKB": selectedValueClass,
      "nameTKB": nameEditingController.text,
      "command": ghiChuEditingController.text,
      "time06300720": time06300720EditingController.text,
      "time07200730": time07200730EditingController.text,
      "time07300815": time07300815EditingController.text,
      "time08150845": time08150845EditingController.text,
      "time08450900": time08450900EditingController.text,
      "time09000930": time09000930EditingController.text,
      "time09301015": time09301015EditingController.text,
      "time10151115": time10151115EditingController.text,
      "time11151400": time11151400EditingController.text,
      "time14001415": time14001415EditingController.text,
      "time14151500": time14151500EditingController.text,
      "time15001515": time15001515EditingController.text,
      "time15151540": time15151540EditingController.text,
      "time15301630": time15301630EditingController.text,
      "time16301730": time16301730EditingController.text,
      "time17301815": time17301815EditingController.text,
      "createDate": "",
      "is_completed": true,
      "khoaHocId": selectedValueYear,
      "days": selectedDate.day.toString(),
      "months": selectedDate.month.toString(),
      "years": selectedDate.year.toString()
    };
  }
}
