import 'dart:math';

import 'package:appflutter_one/_components/_services/Notification/NotificationService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BaoCaoTableChiTiet extends StatefulWidget {
  final dynamic selectedItem;
  const BaoCaoTableChiTiet({super.key, this.selectedItem});

  @override
  State<BaoCaoTableChiTiet> createState() => _BaoCaoTableChiTietState();
}

class _BaoCaoTableChiTietState extends State<BaoCaoTableChiTiet> {
  NotificationService _notificationService = NotificationService();
  bool isClosed = true;

  var currencyFormat = NumberFormat('#,##0', "de");
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
  Widget build(BuildContext context) {
    final nameStudent = widget.selectedItem['nameStudent'];
    final sumTotal = widget.selectedItem['total'].toString();
    final List<dynamic> chiTietHocPhis = widget.selectedItem['chiTietHocPhis'];

    // Convert string representation of dates to DateTime objects if needed
    chiTietHocPhis.forEach((chiTiet) {
      if (chiTiet['createDate'] is String) {
        chiTiet['createDate'] = DateTime.parse(chiTiet['createDate']);
      }
    });

    // Sort the list based on the 'createDate' field
    chiTietHocPhis.sort((a, b) => a['createDate'].compareTo(b['createDate']));

    // Collect unique months
    Set<int> uniqueMonths =
        chiTietHocPhis.map<int>((item) => item['createDate'].month).toSet();

    // Generate a list of colors for each unique month
    List<Color> monthColors = _generateLightMonthColors(uniqueMonths.length);

    // Map each month to its respective color
    Map<int, Color> monthColorMap =
        Map.fromIterables(uniqueMonths.toList(), monthColors);

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
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                nameStudent,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text(
                      'Nội dung',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Số Lượng',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Ngày tạo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tổng tiền',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: chiTietHocPhis.map((chiTiet) {
                  // Get the border color based on the month
                  Color borderColor =
                      monthColorMap[chiTiet['createDate'].month] ??
                          Colors.black;

                  return DataRow(
                    color: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                      return borderColor; // Set border color
                    }),
                    cells: [
                      DataCell(Text(chiTiet['content'] ?? 'N/A')),
                      DataCell(Text(chiTiet['quantity'].toString())),
                      DataCell(Text(DateFormat('dd/MM/yyyy')
                          .format(chiTiet['createDate']))),
                      DataCell(Text(
                          "${currencyFormat.format(chiTiet['total'] is String ? double.parse(chiTiet['total']) : chiTiet['total'])}đ")),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ${currencyFormat.format(double.parse(sumTotal))}đ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to generate a list of light colors for each unique month
  List<Color> _generateLightMonthColors(int count) {
    List<Color> colors = List.generate(count, (index) {
      // Generate random values for each component of RGB
      int red = 200 + Random().nextInt(56); // Random value between 200 and 255
      int green =
          200 + Random().nextInt(56); // Random value between 200 and 255
      int blue = 200 + Random().nextInt(56); // Random value between 200 and 255
      return Color.fromARGB(255, red, green, blue);
    });
    return colors;
  }

  //     items = response ??
  //         []; // Ensure items is initialized even if response is null
  //     isLoading = false;
  //   });
  // }
}
