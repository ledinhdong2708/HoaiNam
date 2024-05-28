import 'package:flutter/material.dart';
import 'dart:math' as math;

class ThoiKhoaBieuCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final DateTime selectedDate;
  final Function(Map) navigationEdit;
  const ThoiKhoaBieuCardScreen(
      {Key? key,
      required this.index,
      required this.item,
      required this.selectedDate,
      required this.navigationEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          navigationEdit(item);
        },
        child: Card(
          margin: EdgeInsets.all(10),
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
                  leading: Icon(Icons.today, size: 50),
                  title: Text(
                      item["nameTKB"],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    children: [
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Ngày ${item["days"]}/${item["months"]}/${item["years"]}',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 5)
                    ],
                  ),
                ),
                // SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
