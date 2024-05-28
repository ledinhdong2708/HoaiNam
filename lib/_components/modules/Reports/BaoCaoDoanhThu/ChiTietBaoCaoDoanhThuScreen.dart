import 'dart:math';
import 'package:appflutter_one/_components/models/BieudoModel/individual_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../_services/Notification/NotificationService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class ChiTietBaoCaoDoanhThuScreen extends StatefulWidget {
  final List<dynamic> items;
  const ChiTietBaoCaoDoanhThuScreen({Key? key, required this.items})
      : super(key: key);

  @override
  State<ChiTietBaoCaoDoanhThuScreen> createState() =>
      _ChiTietBaoCaoDoanhThuScreenState();
}

class _ChiTietBaoCaoDoanhThuScreenState
    extends State<ChiTietBaoCaoDoanhThuScreen> {
  NotificationService _notificationService = NotificationService();

  late double maxY;

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
    List<int> months = List.generate(12, (index) => index + 1);

    Map<int, double> monthlyTotals = {};
    for (var item in widget.items) {
      String month = item['month'];
      int? parsedMonth = int.tryParse(month);
      if (parsedMonth != null) {
        int currentMonth = parsedMonth;
        double total = item['total'] ?? 0.0;
        if (monthlyTotals.containsKey(currentMonth)) {
          monthlyTotals[currentMonth] = monthlyTotals[currentMonth]! + total;
        } else {
          monthlyTotals[currentMonth] = total;
        }
      }
    }

    months.forEach((month) {
      if (!monthlyTotals.containsKey(month)) {
        monthlyTotals[month] = 0.0;
      }
    });
    double maxTotal = monthlyTotals.values.reduce(math.max);

    if (maxTotal > 300000000) {
      maxY = ((maxTotal + 299999999) ~/ 300000000) * 300000000;
    } else {
      maxY = ((maxTotal + 9999999) ~/ 10000000) * 10000000;
    }
    List<IndividualBar> sortedBarData = List.generate(
      12,
      (index) => IndividualBar(
        x: index + 1,
        y: monthlyTotals[index + 1] ?? 0.0,
      ),
    );
    String _formatCurrency(double amount) {
      final formatter = NumberFormat("#,##0", "en_US");
      return formatter.format(amount.toInt());
    }

    Color randomColor() {
      Random random = Random();
      int red = 100 + random.nextInt(156);
      int green = 100 + random.nextInt(156);
      int blue = 100 + random.nextInt(156);
      return Color.fromRGBO(
        red,
        green,
        blue,
        1,
      );
    }

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceEvenly,
        barGroups: sortedBarData.map((data) {
          double adjustedY = data.y <= maxY ? data.y : maxY;
          Color color = randomColor();
          return BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: adjustedY,
                width: 20,
                color: color,
              )
            ],
            barsSpace: 10,
          );
        }).toList(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.white,
            tooltipPadding: EdgeInsets.all(10),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String month =
                  months[sortedBarData[group.x - 1].x - 1].toString();
              String total = _formatCurrency(sortedBarData[groupIndex].y);
              return BarTooltipItem(
                '$month: ',
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: total,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
