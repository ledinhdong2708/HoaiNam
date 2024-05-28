import 'package:appflutter_one/_components/_services/Reports/BaoCaoDoanhThu/BaoCaoDoanhThuService.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/Reports/BaoCaoDoanhThu/BaoCaoTable.dart';
import 'package:appflutter_one/_components/shared/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../_services/Notification/NotificationService.dart';
import 'package:table_calendar/table_calendar.dart';
import 'ChiTietBaoCaoDoanhThuScreen.dart';

class BaoCaoDoanhThuScreen extends StatefulWidget {
  final String title;
  const BaoCaoDoanhThuScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<BaoCaoDoanhThuScreen> createState() => _BaoCaoDoanhThuScreenState();
}

class _BaoCaoDoanhThuScreenState extends State<BaoCaoDoanhThuScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  bool isClosed = true;
  bool isDetailChecked = false;

  final TextEditingController classEditingController = TextEditingController();
  String selectedValueclass = "";
  String nameValueclass = "";
  List<ClasssModel> listClasss = <ClasssModel>[];
  final TextEditingController classController = TextEditingController();

  String showYear = '';
  DateTime _selectedYear = DateTime.now();
  String? selectedValuemonth;

  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  final TextEditingController khoaHocController = TextEditingController();
  String selectyearValueStudent = "";

  int? tongCongTien;
  var currencyFormat = NumberFormat('#,##0', "de");
  String dayMonth = "0";
  // DateTime selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    FetchClasss();
    FetchKhoaHoc();
    FetchBaoCaoData();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  @override
  void dispose() {
    super.dispose();
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
                FetchBaoCaoData();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Xem báo cáo chi tiết'),
                  value: 'detail_report',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'detail_report') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaoCaoDoanhThuTable(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${showYear}",
                              style: TextStyle(
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
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: isDetailChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isDetailChecked = value ?? false;
                            });
                          },
                        ),
                        Text('Xem chi tiết hơn'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (isDetailChecked)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: DropdownMenu<KhoaHocModel>(
                          width: MediaQuery.of(context).size.width * 0.4,
                          controller: khoaHocController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Khóa Học'),
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (KhoaHocModel? icon) {
                            setState(() {
                              selectyearValueStudent = icon!.id.toString();
                              FetchBaoCaoData();
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
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: DropdownMenu<ClasssModel>(
                          width: MediaQuery.of(context).size.width * 0.4,
                          controller: classController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Chọn Lớp'),
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (ClasssModel? icon) {
                            setState(() {
                              selectedValueclass = icon!.id.toString();
                              FetchBaoCaoData();
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
                    ),
                  ],
                ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: ChiTietBaoCaoDoanhThuScreen(
                    items: items,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${currencyFormat.format(calculateTotal())}đ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    isClosed = !isClosed;
                  });
                  FetchBaoCaoData();
                },
                label: Text(isClosed ? 'Đã đóng' : 'Chưa đóng'),
                icon: Icon(Icons.check),
                backgroundColor: isClosed ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in items) {
      total += (item['total'] ?? 0.0).toDouble();
    }
    return total;
  }

  Future<void> FetchClasss() async {
    List<ClasssModel> lsClasss = [];
    final response = await SharedSerivce.FetchListClasss();
    if (response != null) {
      setState(() {
        lsClasss = response as List<ClasssModel>;
      });
    }
    setState(() {
      listClasss = lsClasss;
      isLoading = false;
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
    } else {}
    setState(() {
      listYearStudent = lsKhoaHoc1;
      isLoading = false;
    });
  }

  Future<void> FetchBaoCaoData() async {
    List<dynamic>? response;

    if (showYear == null) {
      response = await BaoCaoDoanhThuService.FetchBaoCaoDoanhNew(isClosed);
    } else if (selectedValueclass == "" && selectyearValueStudent == "") {
      response = await BaoCaoDoanhThuService.FetchBaoCaoDoanhThuYear(
          showYear, selectedValueclass, selectyearValueStudent, isClosed);
    } else if (selectedValueclass != "" &&
        selectyearValueStudent != "" &&
        showYear != null) {
      response = await BaoCaoDoanhThuService.FetchBaoCaoDoanhThuYear(
          showYear, selectedValueclass, selectyearValueStudent, isClosed);
    } else {
      showErrorMessage(context, message: 'Vui lòng chọn cả Khóa và Lớp ! ');
    }

    setState(() {
      items = response ??
          []; // Ensure items is initialized even if response is null
      isLoading = false;
    });
  }
}
