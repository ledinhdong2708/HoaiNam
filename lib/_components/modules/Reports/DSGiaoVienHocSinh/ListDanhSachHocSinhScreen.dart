import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:appflutter_one/_components/_services/Reports/DiemDanhTheoLop/DiemDanhTheoLopService.dart';
import '../../../_services/Notification/NotificationService.dart';
import '../../../shared/utils/snackbar_helper.dart';
import '../../../models/event_calendar.dart';

class ListDanhSachHocSinhScreen extends StatefulWidget {
  final String title;
  const ListDanhSachHocSinhScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<ListDanhSachHocSinhScreen> createState() =>
      ListDanhSachHocSinhScreenState();
}

class ListDanhSachHocSinhScreenState extends State<ListDanhSachHocSinhScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  List items = [];
  late final ValueNotifier<List<EventCalendar>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    FetchChangeListAll();
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

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("${widget.title}"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm theo tên...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  filterSearchResults(value);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 10,
                minWidth: 1000,
                columns: [
                  DataColumn2(
                    label: Text(
                      'STT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(
                      'Họ và tên',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text(
                      'Lớp 1',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Khóa 1',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Lớp 2',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Khóa 2',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Lớp 3',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Khóa 3',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn2(
                    label: Text(
                      'Số điện thoại phụ huynh',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Email phụ huynh',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.L,
                  ),
                ],
                rows: items.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(
                          Text((index + 1).toString())), // Adding row number
                      DataCell(Text(item['nameStudent'].toString())),
                      DataCell(Text(item['class1'].toString() ?? "")),
                      DataCell(Text(item['year1'].toString() ?? "")),
                      DataCell(Text(item['class2'].toString() ?? "")),
                      DataCell(Text(item['year2'].toString() ?? "")),
                      DataCell(Text(item['class3'].toString() ?? "")),
                      DataCell(Text(item['year3'].toString() ?? "")),
                      DataCell(Text(item['user']["phone"])),
                      DataCell(Text(item['user']["email"])),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ]),
    );
  }

  void filterSearchResults(String query) {
    List<dynamic> searchResults = [];
    searchResults.addAll(items);
    if (query.isNotEmpty) {
      List<dynamic> dummySearchList = [];
      searchResults.forEach((item) {
        if (item['nameStudent']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummySearchList.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummySearchList);
      });
      return;
    } else {
      setState(() {
        items.clear();
        FetchChangeListAll();
      });
    }
  }

  Future<void> FetchChangeListAll() async {
    final response = await DiemDanhTheoLopService.FetchListStudent();
    if (response != null) {
      setState(() {
        print(response);
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
