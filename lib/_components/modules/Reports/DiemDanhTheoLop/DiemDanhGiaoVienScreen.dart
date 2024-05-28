import 'dart:ffi';
import 'dart:math' as math;
import 'package:appflutter_one/_components/_services/Reports/DiemDanhTheoLop/DiemDanhTheoLopService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../../../_services/Notification/NotificationService.dart';
import '../../../_services/SharedService/SharedService.dart';
import '../../../models/ClasssModel.dart';
import '../../../models/KhoaHocModel.dart';
import '../../../models/event_calendar.dart';
import '../../../models/months.dart';
import '../../../models/student_years.dart';
import '../../../shared/utils/snackbar_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class DiemDanhGVScreen extends StatefulWidget {
  final String title;
  const DiemDanhGVScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<DiemDanhGVScreen> createState() => _DiemDanhGVScreenState();
}

class _DiemDanhGVScreenState extends State<DiemDanhGVScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  String? selectedValueclass;
  String? selectyearValueStudent;
  String? selectedValueMonth;
  String dayMonth = "0";

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
  String showYear = '';
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
  int _selectedMonth = DateTime.now().month;
  DateTime _selectedYear = DateTime.now();
  @override
  void initState() {
    super.initState();
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
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
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
            onRefresh: FetchChangeListAllGV,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Chọn tháng:'),
                      SizedBox(width: 10),
                      DropdownButton<int>(
                        value: _selectedMonth,
                        items: List.generate(12, (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text('Tháng ${index + 1}'),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            _selectedMonth = value!;
                            FetchChangeListAllGV();
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text('Chọn năm:'),
                      const SizedBox(width: 10),
                      Text(
                        "${showYear}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () => selectYear(context),
                        borderRadius: BorderRadius.circular(25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            "images/20.png",
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Center(child: Text('Họ và Tên'))),
                          DataColumn(label: Center(child: Text('Làm'))),
                          DataColumn(label: Center(child: Text('Nghỉ'))),
                          DataColumn(label: Center(child: Text('Đi trể'))),
                          DataColumn(
                            label: Center(child: Text('Tổng số ngày làm')),
                          ),
                        ],
                        rows: items.map((item) {
                          return DataRow(cells: [
                            DataCell(
                              Center(child: Text(item["user"]["lastName"])),
                            ),
                            DataCell(
                              Center(child: Text(item["soNgayHoc"].toString())),
                            ),
                            DataCell(
                              Center(
                                  child: Text(item["soNgayNghi"].toString())),
                            ),
                            DataCell(
                              Center(
                                  child: Text(item["songaydiTre"].toString())),
                            ),
                            DataCell(
                              Center(
                                child: Text(
                                  (item["soNgayNghi"] +
                                          item["songaydiTre"] +
                                          item["soNgayHoc"])
                                      .toString(),
                                ),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
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
                });
                Navigator.pop(context);
                FetchChangeListAllGV();
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> FetchToDo() async {}

  Future<void> FetchChangeListAllGV() async {
    final response = await DiemDanhTheoLopService.FetchByGVMonth(
        _selectedMonth.toString(), showYear.toString());
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
