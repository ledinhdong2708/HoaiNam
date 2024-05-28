import 'package:flutter/material.dart';

class DateTimePickerDemo extends StatefulWidget {
  const DateTimePickerDemo({Key? key}) : super(key: key);

  @override
  State<DateTimePickerDemo> createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  'Select date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
