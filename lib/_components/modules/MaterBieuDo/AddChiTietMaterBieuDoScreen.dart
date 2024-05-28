import 'package:appflutter_one/_components/_services/MaterBieuDo/MaterBieuDoService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddChiTietMaterBieuDoScreen extends StatefulWidget {
  final Map? item;
  final int studentID;
  const AddChiTietMaterBieuDoScreen(
      {Key? key, this.item, required this.studentID})
      : super(key: key);

  @override
  State<AddChiTietMaterBieuDoScreen> createState() =>
      _AddChiTietMaterBieuDoScreenState();
}

class _AddChiTietMaterBieuDoScreenState
    extends State<AddChiTietMaterBieuDoScreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;
  bool isLoading = false;
  Color myColor = Colors.transparent;
  TextEditingController weight_Controller = new TextEditingController();
  TextEditingController height_Controller = new TextEditingController();
  var main_result = TextEditingController();
  @override
  void initState() {
    super.initState();
    final _status = widget.item;
    if (_status != null) {
      isEdit = true;
      selectedDate = DateTime.parse(widget.item!["docDate"]);
      weight_Controller.text = widget.item!["canNang"].toString();
      height_Controller.text = widget.item!["chieuCao"].toString();
      main_result.text = widget.item!["bmi"];
    }
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  bool isAllFieldsValid() {
    return weight_Controller.text.isNotEmpty &&
        height_Controller.text.isNotEmpty;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          isEdit
              ? 'Ngày ${DateTime.parse(widget.item!["docDate"]).day}/${DateTime.parse(widget.item!["docDate"]).month}/${DateTime.parse(widget.item!["docDate"]).year}'
              : "Thêm mới",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap:
                isAllFieldsValid() ? (isEdit ? updateData : submitData) : null,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                isAllFieldsValid()
                    ? (isEdit ? Icons.edit : Icons.save)
                    : Icons.error,
                color: isAllFieldsValid() ? Color(0xFF674AEF) : Colors.red,
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff4ca3ff),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border:
                              Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () => _selectDate(context),
                      color: Color(0xff498fff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        side: BorderSide(color: Color(0xff808080), width: 1),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Image.asset(
                        "images/20.png",
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ),
                      textColor: Color(0xffffffff),
                      height: 40,
                      minWidth: 40,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: TextField(
                    controller: weight_Controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly // Chỉ cho phép nhập số
                    ],
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Nhập cân nặng (kg)",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: TextField(
                    controller: height_Controller,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly // Chỉ cho phép nhập số
                    ],
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Nhập chiều cao (cm)",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          CalCulate_BMI(
                              weight_Controller.text, height_Controller.text);
                        },
                        child: Text(
                          "Tính BMI",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF0038FF)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(
                        child: Text(
                      "BMI: " + main_result.text,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFF87B1D9),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          Text(
                            "Gầy",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFF3DD365),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          Text(
                            "Bình thường",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFFEEE133),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          Text(
                            "Thừa cân",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFFFD802E),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          Text(
                            "Tiền béo phì",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFFF95353),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          Text(
                            "Béo phì",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

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

  CalCulate_BMI(String weight, String height) async {
    var myDouble_weight = double.parse(weight);
    assert(myDouble_weight is double);
    var myDouble_height = double.parse(height);
    assert(myDouble_height is double);

    var res =
        (myDouble_weight / (myDouble_height / 100 * myDouble_height / 100));

    setState(() {
      main_result.text = res.toStringAsFixed(2);
      if (res < 18.5) {
        myColor = Color(0xFF87B1D9);
      } else if (res >= 18.5 && res <= 22.99) {
        myColor = Color(0xFF3DD365);
      } else if (res >= 23 && res <= 24.99) {
        myColor = Color(0xFFEEE133);
      } else if (res >= 25 && res <= 29.9) {
        myColor = Color(0xFFFD802E);
      } else if (res >= 30) {
        myColor = Color(0xFFF95353);
      }
    });
  }

  Future<void> submitData() async {
    final isSuccess = await MaterBieuDoService.submitData(body);

    if (isSuccess) {
      selectedDate = DateTime.now();
      Navigator.pop(context, 'Yel !');
      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> updateData() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = itemUpdate["id"];
    // final isCompleted = todo['is_completed'];
    final isSuccess = await MaterBieuDoService.updateData(id.toString(), body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    DateTime timeNow = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z')
        .format(selectedDate);
    String formattedDate_now =
        DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(timeNow);
    return {
      "docDate": formattedDate,
      "chieuCao": height_Controller.text,
      "canNang": weight_Controller.text,
      "bmi": main_result.text,
      "createDate": formattedDate_now,
      "isCompleted": true,
      "studentId": widget.studentID
    };
  }
}
