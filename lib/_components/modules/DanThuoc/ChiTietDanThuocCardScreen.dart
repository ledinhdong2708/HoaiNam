import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChiTietDanThuocCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigationEdit;
  const ChiTietDanThuocCardScreen(
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                // leading: Icon(Icons.add, size: 50),
                leading: Image.asset("images/30.png", width: 50),
                title: Text(
                    "Ngày ${DateTime.parse(item["docDate"]!).day}/${DateTime.parse(item["docDate"]!).month}/${DateTime.parse(item["docDate"]!).year}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: [
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Nội dung: ${item["content"]}',
                          style: const TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis)),
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
