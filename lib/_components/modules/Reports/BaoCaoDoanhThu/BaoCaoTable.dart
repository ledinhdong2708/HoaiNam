import 'package:appflutter_one/_components/_services/Reports/BaoCaoDoanhThu/BaoCaoDoanhThuService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/Reports/BaoCaoDoanhThu/BaoCaoTableChiTiet.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../_services/Notification/NotificationService.dart';
import '../../../_services/SharedService/SharedService.dart';
import '../../../models/ClasssModel.dart';
import '../../../models/KhoaHocModel.dart';
import '../../../models/event_calendar.dart';
import '../../../models/months.dart';
import '../../../models/student_years.dart';
import '../../../shared/utils/snackbar_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class BaoCaoDoanhThuTable extends StatefulWidget {
  const BaoCaoDoanhThuTable({Key? key}) : super(key: key);

  @override
  State<BaoCaoDoanhThuTable> createState() => BaoCaoDoanhThuTableScreenState();
}

class BaoCaoDoanhThuTableScreenState extends State<BaoCaoDoanhThuTable> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  bool isClosed = true;
  bool isDetailChecked = false;

  String? selectedValueMonth;

  final TextEditingController classEditingController = TextEditingController();
  String selectedValueclass = "";
  String nameValueclass = "";
  List<ClasssModel> listClasss = <ClasssModel>[];

  String showYear = '';
  DateTime _selectedYear = DateTime.now();
  String? selectedValuemonth;

  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  final TextEditingController khoaHocController = TextEditingController();
  String selectyearValueStudent = "";

  String dayMonth = "0";
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  String? baoCaoContent;
  int? tongCongTien;
  var currencyFormat = NumberFormat('#,##0', "de");
  Map<DateTime, List<EventCalendar>> events = {};
  late final ValueNotifier<List<EventCalendar>> _selectedEvents;
  final TextEditingController classController = TextEditingController();
  final TextEditingController monthController = TextEditingController();

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
    FetchClasss();
    FetchKhoaHoc();
    FetchBaoCaoData();
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
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Báo Cáo Doanh thu chi tiết "),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.notifications,
              color: Color(0xFF674AEF),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Column(
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
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
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
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
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
            Expanded(
              flex: 1,
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 400,
                columns: [
                  DataColumn2(
                    label: Text(
                      'Họ và tên',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text(
                      'Lớp',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Khóa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Số tiền',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: items.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text(item['nameStudent'].toString())),
                      DataCell(Text(item['class'].toString() ?? "")),
                      DataCell(Text(item['khoa'].toString() ?? "")),
                      DataCell(Text(
                          "${currencyFormat.format(item['total'] is String ? double.parse(item['total']) : item['total'])}đ")),
                    ],
                    // Thêm sự kiện onTap cho từng dòng
                    onSelectChanged: (isSelected) {
                      if (isSelected != null && isSelected) {
                        _onRowTapped(index);
                      }
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ]),
      // Thêm thanh tiêu đề phụ
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

  void _onRowTapped(int index) {
    var selectedItem = items[index];
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BaoCaoTableChiTiet(selectedItem: selectedItem)),
    );
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in items) {
      total += (item['total'] ?? 0.0).toDouble();
    }
    return total;
  }

  Future<void> _classItems(BuildContext context) async {
    await FetchClasss();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn lớp'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: listClasss.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(listClasss[index].name ?? ""),
                  onTap: () {
                    setState(() {
                      selectedValueclass = listClasss[index].id.toString();
                      nameValueclass = listClasss[index].name ?? "";
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
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
    } else {}
    setState(() {
      listYearStudent = lsKhoaHoc1;
      isLoading = false;
    });
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

  List<EventCalendar> _getEventsForDay(DateTime day) {
    // Implementation example
    return events[day] ?? [];
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
