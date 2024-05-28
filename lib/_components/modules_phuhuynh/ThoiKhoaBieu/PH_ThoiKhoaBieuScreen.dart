import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/ThoiKhoaBieu/ThoiKhoaBieuService.dart';
import '../../shared/utils/snackbar_helper.dart';

class PH_ThoiKhoaBieuScreen extends StatefulWidget {
  String img;
  String text;
  PH_ThoiKhoaBieuScreen(this.img, this.text);
  // const PH_ThoiKhoaBieuScreen({Key? key}) : super(key: key);

  @override
  State<PH_ThoiKhoaBieuScreen> createState() => _PH_ThoiKhoaBieuScreenState();
}

class _PH_ThoiKhoaBieuScreenState extends State<PH_ThoiKhoaBieuScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  List items = [];
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
  void initState() {
    super.initState();
    PH_FetchTodo();

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
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        SizedBox(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                          readOnly: true,
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
                  ],
                ),
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
      ]),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2055),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        PH_FetchTodo();
      });
  }

  Future<void> PH_FetchTodo() async {
    final response = await ThoiKhoaBieuService.PH_FetchByStudent(
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString());
    if (response != null) {
      setState(() {
        time06300720EditingController.text = response['time06300720'] ?? "";
        time07200730EditingController.text = response['time07200730'] ?? "";
        time08150845EditingController.text = response['time08150845'] ?? "";
        time08450900EditingController.text = response['time08450900'] ?? "";
        time09000930EditingController.text = response['time09000930'] ?? "";
        time09301015EditingController.text = response['time09301015'] ?? "";
        time10151115EditingController.text = response['time10151115'] ?? "";
        time11151400EditingController.text = response['time11151400'] ?? "";
        time14001415EditingController.text = response['time14001415'] ?? "";
        time14151500EditingController.text = response['time14151500'] ?? "";
        time15001515EditingController.text = response['time15001515'] ?? "";
        time15151540EditingController.text = response['time15151540'] ?? "";
        time15301630EditingController.text = response['time15301630'] ?? "";
        time16301730EditingController.text = response['time16301730'] ?? "";
        time17301815EditingController.text = response['time17301815'] ?? "";
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }
}
