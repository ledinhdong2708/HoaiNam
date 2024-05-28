import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChiTietHocPhiCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigationEdit;
  ChiTietHocPhiCardScreen(
      {Key? key,
      required this.index,
      required this.item,
      required this.navigationEdit})
      : super(key: key);

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'ko',
    decimalDigits: 0,
    symbol: '',
  );
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
                leading: Image.asset(
                    item["status"] == true ? "images/43.png" : "images/44.png",
                    width: 50),
                title: Text("Tháng ${item["months"]}/${item["years"]}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: [
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Tổng: ${_formatter.format((item["conLai"].toString().replaceAll('.0', '')))}',
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
