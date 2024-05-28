import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../_services/MaterBieuDo/MaterBieuDoService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/Styles/colors.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'dart:math' as math;

class PH_BieuDoChieuCaoScreen extends StatefulWidget {
  final int StudentId;
  final String title;
  const PH_BieuDoChieuCaoScreen(
      {Key? key, required this.title, required this.StudentId})
      : super(key: key);

  @override
  State<PH_BieuDoChieuCaoScreen> createState() =>
      _PH_BieuDoChieuCaoScreenState();
}

class _SalesData {
  _SalesData(this.year, this.sales, this.color);
  final String year;
  final double sales;
  final Color color;
}

class _PH_BieuDoChieuCaoScreenState extends State<PH_BieuDoChieuCaoScreen> {
  NotificationService _notificationService = NotificationService();
  // Demo Chart Sample 2
  List<_SalesData> data = [];
  bool showAvg = false;

  // End Demo Chart Sample 2

  void initState() {
    super.initState();
    // FetchTodo();
    FetchMaterBieuDo();

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
            widget.title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(10),
            )
          ],
        ),
        body: Stack(children: [
          backgroundImage(),
          backgroundColor(context),
          Column(children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      pointColorMapper: (_SalesData sales, _) => sales.color,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Chiều cao',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true))
                ]),
          ]),
        ]));
  }

  Future<void> FetchMaterBieuDo() async {
    data = [];
    final response = await MaterBieuDoService.PH_FetchByStudent();

    if (response != null) {
      setState(
        () {
          if (response.length > 0) {
            for (int i = 0; i < response.length; i++) {
              if (response[i]["chieuCao"] != null) {
                final chieuCao = response[i]["chieuCao"]
                    .toDouble(); // Chuyển đổi kiểu int thành double
                data.add(_SalesData(
                  ('${DateTime.parse(response[i]["docDate"]).month}/${DateTime.parse(response[i]["docDate"]).year}')
                      .toString(),
                  chieuCao,
                  Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                ));
                print('Chiều cao: $chieuCao');
              }
            }
          }
        },
      );
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      // isLoading = false;
    });
  }
}
