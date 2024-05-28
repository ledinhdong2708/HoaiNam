import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:appflutter_one/_components/_services/Reports/DiemDanhTheoLop/DiemDanhTheoLopService.dart';
import '../../../_services/Notification/NotificationService.dart';
import '../../../shared/utils/snackbar_helper.dart';
import '../../../models/event_calendar.dart';

class ListDanhSachGVScreen extends StatefulWidget {
  final String title;
  const ListDanhSachGVScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ListDanhSachGVScreen> createState() => ListDanhSachGVScreenState();
}

class ListDanhSachGVScreenState extends State<ListDanhSachGVScreen> {
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
                decoration: InputDecoration(
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
                minWidth: 700,
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
                      'Địa chỉ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn2(
                    label: Text(
                      'Phone',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Email',
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
                      DataCell(Text(item['name'].toString())),
                      DataCell(Text(item['city'].toString() ?? "")),
                      DataCell(Text(item["phone"])),
                      DataCell(Text(item["email"])),
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
        if (item['name']
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
    final response = await DiemDanhTheoLopService.FetchListGV();
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
