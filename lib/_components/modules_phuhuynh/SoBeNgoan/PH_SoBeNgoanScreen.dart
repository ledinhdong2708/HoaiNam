import 'package:appflutter_one/_components/_services/SoBeNgoan/SoBeNgoanService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../models/months.dart';
import '../../shared/utils/snackbar_helper.dart';

class PH_SoBeNgoanScreen extends StatefulWidget {
  String img;
  String text;
  PH_SoBeNgoanScreen(this.img, this.text);
  // const PH_SoBeNgoanScreen({Key? key}) : super(key: key);

  @override
  State<PH_SoBeNgoanScreen> createState() => _PH_SoBeNgoanScreenState();
}

class _PH_SoBeNgoanScreenState extends State<PH_SoBeNgoanScreen> {
  NotificationService _notificationService = NotificationService();
  String showYear = 'Year';
  DateTime _selectedYear = DateTime.now();
  String? selectedValuemonth;
  final TextEditingController monthEditingController = TextEditingController();
  List<Months> listMonths = <Months>[
    Months(id: 1, name: "Tháng 1"),
    Months(id: 2, name: "Tháng 2"),
    Months(id: 3, name: "Tháng 3"),
    Months(id: 4, name: "Tháng 4"),
    Months(id: 5, name: "Tháng 5"),
    Months(id: 6, name: "Tháng 6"),
    Months(id: 7, name: "Tháng 7"),
    Months(id: 8, name: "Tháng 8"),
    Months(id: 9, name: "Tháng 9"),
    Months(id: 10, name: "Tháng 10"),
    Months(id: 11, name: "Tháng 11"),
    Months(id: 12, name: "Tháng 12"),
  ];

  selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime(2025),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedYear = dateTime;
                  showYear = "${dateTime.year}";
                  PH_FetchTodo(selectedValuemonth, showYear);
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  final TextEditingController nhanXetEditingController =
      TextEditingController();
  String img_week1 = "images/3.png";
  String img_week2 = "images/3.png";
  String img_week3 = "images/3.png";
  String img_week4 = "images/3.png";
  String img_week5 = "images/3.png";
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    showYear = date.year.toString();
    selectedValuemonth = date.month.toString();
    PH_FetchTodo(date.month.toString(), date.year.toString());

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
            widget.text,
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        ),
        body: Stack(children: [
          backgroundImage(),
          backgroundColor(context),
          SafeArea(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(3, 2, 10, 2),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${showYear}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () => _selectDate(context),
                                      onTap: () => selectYear(context),
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
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownMenu<Months>(
                                width: MediaQuery.of(context).size.width * 0.46,
                                controller: monthEditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Tháng'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (Months? icon) {
                                  setState(() {
                                    selectedValuemonth = icon!.id.toString();
                                    PH_FetchTodo(selectedValuemonth, showYear);
                                  });
                                },
                                dropdownMenuEntries:
                                    listMonths.map<DropdownMenuEntry<Months>>(
                                  (Months icon) {
                                    return DropdownMenuEntry<Months>(
                                      value: icon,
                                      label: icon.name,
                                      // leadingIcon: icon.!id.toString(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 10, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Align(
                                                child: Text(
                                                  "Tuần 1",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Image.asset(img_week1,
                                                width: 100,
                                                height: 150,
                                                fit: BoxFit.cover)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 30, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Align(
                                                child: Text(
                                                  "Tuần 2",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Image.asset(img_week2,
                                                width: 100,
                                                height: 150,
                                                fit: BoxFit.cover)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 10, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Align(
                                                child: Text(
                                                  "Tuần 3",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Image.asset(img_week3,
                                                width: 100,
                                                height: 150,
                                                fit: BoxFit.cover)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 30, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Align(
                                                child: Text(
                                                  "Tuần 4",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Image.asset(img_week4,
                                                width: 100,
                                                height: 150,
                                                fit: BoxFit.cover)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Color(0xff808080),
                                height: 10,
                                thickness: 4,
                                indent: 30,
                                endIndent: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 10, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Align(
                                                child: Text(
                                                  "Cháu ngoan bác Hồ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            Image.asset(img_week5,
                                                width: 100,
                                                height: 150,
                                                fit: BoxFit.cover)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 30, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Align(
                                                child: Text(
                                                  "Nhận xét",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            TextField(
                                              controller:
                                                  nhanXetEditingController,
                                              readOnly: true,
                                              obscureText: false,
                                              textAlign: TextAlign.start,
                                              maxLines: 9,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                              ),
                                              decoration: InputDecoration(
                                                disabledBorder:
                                                    InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14,
                                                  color: Color(0xff000000),
                                                ),
                                                filled: false,
                                                fillColor: Color(0xfff2f2f3),
                                                isDense: false,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  Future<void> _selectWeekShowImg(String week, bool showhide) async {
    if (week == '1') {
      if (showhide) {
        img_week1 = "images/21.png";
      } else {
        img_week1 = "images/3.png";
      }
    }
    if (week == '2') {
      if (showhide) {
        img_week2 = "images/21.png";
      } else {
        img_week2 = "images/3.png";
      }
    }
    if (week == '3') {
      if (showhide) {
        img_week3 = "images/21.png";
      } else {
        img_week3 = "images/3.png";
      }
    }
    if (week == '4') {
      if (showhide) {
        img_week4 = "images/21.png";
      } else {
        img_week4 = "images/3.png";
      }
    }
    if (week == '5') {
      if (showhide) {
        img_week5 = "images/22.png";
      } else {
        img_week5 = "images/3.png";
      }
    }
  }

  Future<void> PH_FetchTodo(month, year) async {
    if (month == null || year == null || month == "" || year == "") {
      return;
    }
    final response = await SoBeNgoanService.PH_FetchByStudent(month, year);

    if (response != null) {
      if (response == {}) {
        return;
      } else {
        _selectWeekShowImg('1', response["tuan1"] ?? false);
        _selectWeekShowImg('2', response["tuan2"] ?? false);
        _selectWeekShowImg('3', response["tuan3"] ?? false);
        _selectWeekShowImg('4', response["tuan4"] ?? false);
        _selectWeekShowImg('5', response["tuan5"] ?? false);
        nhanXetEditingController.text = response["nhanXet"] ?? "";
      }
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {});
  }
}
