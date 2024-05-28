import 'package:appflutter_one/_components/models/BieudoModel/individual_bar.dart';

class BarData {
  final int CreateDate;
  final double total;
  BarData({
    required this.CreateDate,
    required this.total,
  });
  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: CreateDate, y: total),
    ];
  }
}
