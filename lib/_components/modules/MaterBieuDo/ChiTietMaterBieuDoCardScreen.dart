import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChiTietMaterBieuDoCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigationEdit;
  const ChiTietMaterBieuDoCardScreen(
      {Key? key,
      required this.index,
      required this.item,
      required this.navigationEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationEdit(item!);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        elevation: 30,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.person, size: 50),
                title: Text(
                    "Ngày ${DateTime.parse(item["docDate"]!).day}/${DateTime.parse(item["docDate"]!).month}/${DateTime.parse(item["docDate"]!).year}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: [
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Chiều cao: ${(item["chieuCao"] == null ? 0 : item["chieuCao"]!).toString()} m',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Cân nặng: ${(item["canNang"] == null ? 0 : item["canNang"]!).toString()} kg',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'BMI: ${(item["bmi"] == null ? 0 : item["bmi"]!).toString()}',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
