import 'package:flutter/material.dart';
import 'dart:math' as math;

class KhoaHocCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigationEdit;
  const KhoaHocCardScreen(
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
                leading: Icon(Icons.person, size: 50),
                title: Text(
                    'Khóa: ${(item["fromYear"]).toString()}-${(item["toYear"]).toString()}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: [
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Ngày ${DateTime.parse(item["createDate"]!).day}/${DateTime.parse(item["createDate"]!).month}/${DateTime.parse(item["createDate"]!).year}",
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
    );
  }
}
