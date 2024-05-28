import 'package:appflutter_one/_components/_services/Reports/DiemDanhTheoLop/DiemDanhTheoLopService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'dart:math' as math;
import '../../../_services/Notification/NotificationService.dart';
import '../../../_services/SharedService/SharedService.dart';
import '../../../models/ClasssModel.dart';
import '../../../models/KhoaHocModel.dart';
import '../../../models/event_calendar.dart';
import '../../../models/months.dart';
import '../../../models/student_years.dart';
import '../../../shared/utils/snackbar_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class DiemDanhTheoLopScreen extends StatefulWidget {
  final String title;
  const DiemDanhTheoLopScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<DiemDanhTheoLopScreen> createState() => _DiemDanhTheoLopScreenState();
}

class _DiemDanhTheoLopScreenState extends State<DiemDanhTheoLopScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  String? selectedValueclass;
  String? selectyearValueStudent;
  String? selectedValueMonth;
  String dayMonth = "0";
  // DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  // Store Event Calendar
  Map<DateTime, List<EventCalendar>> events = {};
  late final ValueNotifier<List<EventCalendar>> _selectedEvents;
  final TextEditingController khoaHocController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController monthController = TextEditingController();

  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  List<ClasssModel> listClasss = <ClasssModel>[];

  List items = [];
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
  List<StudentYear> listDayMonth = <StudentYear>[
    StudentYear(id: 0, name: "Xem Ngày"),
    StudentYear(id: 1, name: "Xem Tháng"),
  ];

  @override
  void initState() {
    super.initState();
    FetchKhoaHoc();
    FetchClasss();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
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
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Visibility(
          visible: isLoading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
          replacement: RefreshIndicator(
            onRefresh: FetchToDo,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Expanded(
                  //         flex: 1,
                  //         child: DropdownMenu<StudentYear>(
                  //           width: MediaQuery.of(context).size.width * 0.43,
                  //           controller: TextEditingController(),
                  //           enableFilter: true,
                  //           requestFocusOnTap: true,
                  //           leadingIcon: const Icon(Icons.search),
                  //           label: const Text('Chọn'),
                  //           inputDecorationTheme: const InputDecorationTheme(
                  //               filled: true,
                  //               contentPadding:
                  //                   EdgeInsets.symmetric(vertical: 5.0),
                  //               border: OutlineInputBorder(),
                  //               fillColor: Colors.transparent),
                  //           onSelected: (StudentYear? icon) {
                  //             setState(() {
                  //               dayMonth = icon!.id.toString();
                  //             });
                  //           },
                  //           dropdownMenuEntries:
                  //               listDayMonth.map<DropdownMenuEntry<StudentYear>>(
                  //             (StudentYear icon) {
                  //               return DropdownMenuEntry<StudentYear>(
                  //                 value: icon,
                  //                 label: "${icon.name}",
                  //                 // leadingIcon: icon.!id.toString(),
                  //               );
                  //             },
                  //           ).toList(),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               width: MediaQuery.of(context).size.width * 0.43,
                  //               height: 48,
                  //               padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(width: 1),
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(5.0)),
                  //               ),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Align(
                  //                     alignment: Alignment.center,
                  //                     child: Text(
                  //                       "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  //                       textAlign: TextAlign.center,
                  //                       overflow: TextOverflow.clip,
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.w400,
                  //                         fontStyle: FontStyle.normal,
                  //                         fontSize: 14,
                  //                         color: Colors.black,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   InkWell(
                  //                     onTap: () => _selectDate(context),
                  //                     borderRadius: BorderRadius.circular(50),
                  //                     child: ClipRRect(
                  //                       borderRadius: BorderRadius.circular(50.0),
                  //                       child: Image.asset(
                  //                         "images/20.png",
                  //                         height: 40,
                  //                         width: 40,
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       // Visibility(
                  //       //   visible: dayMonth == 1.toString(),
                  //       //   child: Expanded(
                  //       //     flex: 1,
                  //       //     child: DropdownMenu<Months>(
                  //       //       width: MediaQuery.of(context).size.width * 0.40,
                  //       //       controller: monthController,
                  //       //       enableFilter: true,
                  //       //       requestFocusOnTap: true,
                  //       //       leadingIcon: const Icon(Icons.search),
                  //       //       label: const Text('Tháng'),
                  //       //       inputDecorationTheme: const InputDecorationTheme(
                  //       //           filled: true,
                  //       //           contentPadding:
                  //       //               EdgeInsets.symmetric(vertical: 5.0),
                  //       //           border: OutlineInputBorder(),
                  //       //           fillColor: Colors.transparent),
                  //       //       onSelected: (Months? icon) {
                  //       //         setState(() {
                  //       //           selectedValueMonth = icon!.id.toString();
                  //       //           // FetchChangeListAll(
                  //       //           //     showYear,
                  //       //           //     selectedValueclass,
                  //       //           //     selectedValuemonth.toString());
                  //       //         });
                  //       //       },
                  //       //       dropdownMenuEntries:
                  //       //           listMonths.map<DropdownMenuEntry<Months>>(
                  //       //         (Months icon) {
                  //       //           return DropdownMenuEntry<Months>(
                  //       //             value: icon,
                  //       //             label: icon.name,
                  //       //             // leadingIcon: icon.!id.toString(),
                  //       //           );
                  //       //         },
                  //       //       ).toList(),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownMenu<KhoaHocModel>(
                              width: MediaQuery.of(context).size.width * 0.43,
                              controller: khoaHocController,
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
                                  selectyearValueStudent = icon!.id.toString();
                                  FetchChangeListAll(selectyearValueStudent!,
                                      selectedValueclass!);
                                });
                              },
                              dropdownMenuEntries: listYearStudent
                                  .map<DropdownMenuEntry<KhoaHocModel>>(
                                (KhoaHocModel icon) {
                                  return DropdownMenuEntry<KhoaHocModel>(
                                    value: icon,
                                    label: icon.name.toString(),
                                    // leadingIcon: icon.!id.toString(),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownMenu<ClasssModel>(
                            width: MediaQuery.of(context).size.width * 0.43,
                            controller: classController,
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
                                selectedValueclass = icon!.id.toString();
                                FetchChangeListAll(selectyearValueStudent!,
                                    selectedValueclass!);
                              });
                            },
                            dropdownMenuEntries:
                                listClasss.map<DropdownMenuEntry<ClasssModel>>(
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
                  TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: Jiffy.now().add(years: -10).dateTime,
                    lastDay: Jiffy.now().add(years: 10).dateTime,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          FetchChangeListAll(
                              selectyearValueStudent!, selectedValueclass!);
                        });
                      }
                    },
                    onFormatChanged: (CalendarFormat format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                          FetchChangeListAll(
                              selectyearValueStudent!, selectedValueclass!);
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  SizedBox(height: 5),
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
                  SizedBox(height: 5),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: Card(
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),
                                elevation: 30,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.school, size: 50),
                                        title: Text(
                                            'Tên: ${items[index]["student"]["nameStudent"]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        subtitle: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Học: ${(items[index]["soNgayHoc"]).toString()} ngày",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Nghỉ: ${(items[index]["soNgayNghi"]).toString()} ngày",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(height: 5)
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 10,)
                                    ],
                                  ),
                                ),
                              )
                                  // ListTile(
                                  //   onTap: () => print('ABC'),
                                  //   title: Text('${items[index]["student"]["nameStudent"]}'),
                                  // ),
                                  );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  List<EventCalendar> _getEventsForDay(DateTime day) {
    // Implementation example
    return events[day] ?? [];
  }

  Future<void> FetchToDo() async {}

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
        // listYearStudent = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listYearStudent = lsKhoaHoc1;
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
      isLoading = false;
    });
  }

  Future<void> FetchChangeListAll(String khoaHocID, String classID) async {
    if (_calendarFormat.name == "week") {
      if ((khoaHocID != null && classID != null) ||
          (khoaHocID != "" && classID != "")) {
        final response =
            await DiemDanhTheoLopService.FetchByKhoaHocAndClassMonth(
                khoaHocID,
                classID,
                _selectedDay!.month.toString(),
                _selectedDay!.year.toString());
        if (response != null) {
          setState(() {
            items = response;
          });
        } else {
          showErrorMessage(context, message: 'Something went wrong');
        }
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if ((khoaHocID != null && classID != null) ||
          (khoaHocID != "" && classID != "")) {
        final response = await DiemDanhTheoLopService.FetchByKhoaHocAndClassDay(
            khoaHocID,
            classID,
            _selectedDay!.day.toString(),
            _selectedDay!.month.toString(),
            _selectedDay!.year.toString());
        if (response != null) {
          setState(() {
            items = response;
          });
        } else {
          showErrorMessage(context, message: 'Something went wrong');
        }
        setState(() {
          isLoading = false;
        });
      }
    }
    // if (dayMonth == "0") {
    //   if ((khoaHocID != null && classID != null && selectedDate != null) ||
    //       (khoaHocID != "" && classID != "")) {
    //     final response = await DiemDanhTheoLopService.FetchByKhoaHocAndClassDay(
    //         khoaHocID,
    //         classID,
    //         _selectedDay!.day.toString(),
    //         _selectedDay!.month.toString(),
    //         _selectedDay!.year.toString());
    //     if (response != null) {
    //       setState(() {
    //         items = response;
    //       });
    //     } else {
    //       showErrorMessage(context, message: 'Something went wrong');
    //     }
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // }
    // if (dayMonth == "1") {
    //   if ((khoaHocID != null && classID != null && selectedDate != null) ||
    //       (khoaHocID != "" && classID != "")) {
    //     final response =
    //         await DiemDanhTheoLopService.FetchByKhoaHocAndClassMonth(
    //             khoaHocID,
    //             classID,
    //             selectedDate.month.toString(),
    //             selectedDate.year.toString());
    //     if (response != null) {
    //       setState(() {
    //         items = response;
    //       });
    //     } else {
    //       showErrorMessage(context, message: 'Something went wrong');
    //     }
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // }
    // if (khoaHocID != null &&
    //     classID != null &&
    //     dayMonth != null &&
    //     selectedDate != null) {
    //   // final response =
    //   // await DiemDanhTheoLopService.FetchByKhoaHocAndClassMonth(studentID, classID, se);
    //   // if (response != null) {
    //   //   setState(() {
    //   //     items = response;
    //   //   });
    //   // } else {
    //   //   showErrorMessage(context, message: 'Something went wrong');
    //   // }
    //   // setState(() {
    //   //   isLoading = false;
    //   // });
    // }
  }

  // _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       FetchChangeListAll(selectyearValueStudent!, selectedValueclass!);
  //     });
  // }
}
