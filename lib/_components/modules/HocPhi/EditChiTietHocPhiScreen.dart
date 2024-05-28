import 'dart:convert';

import 'package:appflutter_one/_components/_services/HocPhi/HocPhiModelService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/HocPhi/DialogAddMaterHocPhiScreen.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/months.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'dart:math' as math;

class EditChiTietHocPhiScreen extends StatefulWidget {
  final Map? item;
  final int studentID;
  const EditChiTietHocPhiScreen({Key? key, this.item, required this.studentID})
      : super(key: key);

  @override
  State<EditChiTietHocPhiScreen> createState() =>
      _EditChiTietHocPhiScreenState();
}

class _EditChiTietHocPhiScreenState extends State<EditChiTietHocPhiScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  String showYear = 'Year';
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;
  bool isLoading = false;
  double total = 0;
  int sobuoioff = 0;
  int status = 1;
  //List
  List<Months> listMonths = <Months>[
    Months(id: 1, name: "Tháng 1"),
    Months(id: 2, name: "Tháng 2"),
    Months(id: 3, name: "Tháng 3"),
    Months(id: 4, name: "Tháng 4"),
    Months(id: 5, name: "Tháng 5"),
    Months(id: 6, name: "Tháng 6"),
    Months(id: 7, name: "Tháng 7"),
    Months(id: 8, name: "Tháng 8"),
    Months(id: 9, name: "Tháng 9"),
    Months(id: 10, name: "Tháng 10"),
    Months(id: 11, name: "Tháng 11"),
    Months(id: 12, name: "Tháng 12"),
  ];
  DateTime _selectedYear = DateTime.now();
  String? selectedValuemonth;
  final TextEditingController monthEditingController = TextEditingController();
  // final TextEditingController quantityEditingController = TextEditingController();
  List data = [];
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'ko',
    decimalDigits: 0,
    symbol: '',
  );
  TextEditingController totalOff_Controller = new TextEditingController();
  void initState() {
    totalOff_Controller.text = "0";
    super.initState();
    showYear = widget.item!["years"];
    total = widget.item!["total"];
    sobuoioff = widget.item!["sobuoioff"];
    totalOff_Controller.text = widget.item!["phiOff"].toString();
    listMonths.forEach((element) {
      if (element.id.toString() == widget.item!["months"]) {
        selectedValuemonth = element.id.toString();
        monthEditingController.text = element.name;
      }
    });
    setState(() {
      if (widget.item!["status"] == false) {
        status = 1;
      } else if (widget.item!["status"] == true) {
        status = 0;
      }
    });
    // FetchDataByMaterHocPhi();
    data = widget.item!["hocPhiChiTietModels"];

    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService
        .getDeviceToken()
        .then((value) => {tokenDevice = value});
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
          "Tháng ${widget.item!["months"]}/${widget.item!["years"]}",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            // onTap: isEdit ? updateData : submitData,
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Thanh toán'),
                  content: Container(
                    height: 100,
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Center(
                          child: Align(
                            child: Text(status == 1
                                ? "Bạn có muốn thanh toán không ?"
                                : "Bạn có muốn hủy thanh toán"),
                          ),
                        )),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () => {
                        setState(() {
                          if (status == 0) {
                            status = 1;
                          } else {
                            status = 0;
                          }
                        }),
                        updateStatusThanhToan(),
                        Navigator.pop(context, 'OK')
                      },
                      child: const Text('Lưu'),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.payment_outlined,
                color: Color(0xFF674AEF),
              ),
            ),
          ),
          InkWell(
            // onTap: isEdit ? updateData : submitData,
            onTap: navigateToAddPage,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.add_shopping_cart_sharp,
                color: Color(0xFF674AEF),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     showDialog<String>(
          //       context: context,
          //       builder: (BuildContext context) => AlertDialog(
          //         title: const Text('Thêm thông tin'),
          //         content: Container(
          //           child: Padding(
          //             padding: EdgeInsets.all(0),
          //             child: Row(
          //               children: [
          //                 Expanded(
          //                   flex: 1,
          //                   child: TextField(
          //                     controller:
          //                         TextEditingController(text: "Phí nghỉ"),
          //                     obscureText: false,
          //                     textAlign: TextAlign.start,
          //                     maxLines: 1,
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w400,
          //                       fontStyle: FontStyle.normal,
          //                       fontSize: 14,
          //                       color: Color(0xff000000),
          //                     ),
          //                     decoration: InputDecoration(
          //                       disabledBorder: InputBorder.none,
          //                       focusedBorder: InputBorder.none,
          //                       enabledBorder: InputBorder.none,
          //                       labelText: "Tên",
          //                       labelStyle: TextStyle(
          //                         fontWeight: FontWeight.w400,
          //                         fontStyle: FontStyle.normal,
          //                         fontSize: 14,
          //                         color: Color(0xff000000),
          //                       ),
          //                       filled: false,
          //                       fillColor: Color(0xfff2f2f3),
          //                       isDense: false,
          //                       contentPadding: EdgeInsets.symmetric(
          //                           vertical: 8, horizontal: 12),
          //                     ),
          //                   ),
          //                 ),
          //                 Expanded(
          //                   flex: 1,
          //                   child: TextField(
          //                     controller: totalOff_Controller,
          //                     obscureText: false,
          //                     textAlign: TextAlign.start,
          //                     inputFormatters: [
          //                       CurrencyTextInputFormatter(
          //                         locale: 'ko',
          //                         decimalDigits: 0,
          //                         symbol: '',
          //                       )
          //                     ],
          //                     keyboardType: TextInputType.number,
          //                     maxLines: 1,
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w400,
          //                       fontStyle: FontStyle.normal,
          //                       fontSize: 14,
          //                       color: Color(0xff000000),
          //                     ),
          //                     decoration: InputDecoration(
          //                       disabledBorder: InputBorder.none,
          //                       focusedBorder: InputBorder.none,
          //                       enabledBorder: InputBorder.none,
          //                       labelText: "Giá trị",
          //                       labelStyle: TextStyle(
          //                         fontWeight: FontWeight.w400,
          //                         fontStyle: FontStyle.normal,
          //                         fontSize: 14,
          //                         color: Color(0xff000000),
          //                       ),
          //                       filled: false,
          //                       fillColor: Color(0xfff2f2f3),
          //                       isDense: false,
          //                       contentPadding: EdgeInsets.symmetric(
          //                           vertical: 8, horizontal: 12),
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         actions: <Widget>[
          //           TextButton(
          //             onPressed: () => Navigator.pop(context, 'Cancel'),
          //             child: const Text('Hủy'),
          //           ),
          //           TextButton(
          //             onPressed: () => {
          //               // setState(() {
          //               //   data.add({
          //               //     "id": data.length <= 0 ? 0 : data.last["id"] + 1,
          //               //     "content": nameController.text,
          //               //     "months": selectedValueMonth,
          //               //     "years": showYear,
          //               //     "createDate": "",
          //               //     "updateDate": "",
          //               //     "total": double.parse(
          //               //         valueController.text.replaceAll(',', '')),
          //               //     "hocPhiChiTietId": 0,
          //               //     "isCompleted": false,
          //               //     "userId": 0,
          //               //     "studentId": 0
          //               //   });
          //               //   nameController.text = "";
          //               //   valueController.text = "";
          //               // }),
          //               // total = totalList(data).toString(),
          //               Navigator.pop(context, 'OK')
          //             },
          //             child: const Text('Lưu'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.all(10),
          //     child: Icon(
          //       Icons.outlined_flag,
          //       color: Color(0xFF674AEF),
          //     ),
          //   ),
          // )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(3, 2, 10, 2),
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${showYear}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  // onTap: () => _selectDate(context),
                                  onTap: () => selectYear(context),
                                  borderRadius: BorderRadius.circular(50),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset(
                                      "images/20.png",
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: DropdownMenu<Months>(
                            width: MediaQuery.of(context).size.width * 0.48,
                            controller: monthEditingController,
                            enableFilter: true,
                            requestFocusOnTap: true,
                            leadingIcon: const Icon(Icons.search),
                            label: const Text('Tháng'),
                            inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5.0),
                                border: OutlineInputBorder(),
                                fillColor: Colors.transparent),
                            onSelected: (Months? icon) {
                              setState(() {
                                selectedValuemonth = icon!.id.toString();
                              });
                            },
                            dropdownMenuEntries:
                                listMonths.map<DropdownMenuEntry<Months>>(
                              (Months icon) {
                                return DropdownMenuEntry<Months>(
                                  value: icon,
                                  label: icon.name,
                                  // leadingIcon: icon.!id.toString(),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemCount: data.length,
                    shrinkWrap: false,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = data[index] as Map;
                      print(item);
                      return Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.yellow.withOpacity(1.0),
                        // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        //     .withOpacity(1.0),
                        elevation: 30,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: data[index]["content"]),
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      readOnly: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff000000),
                                      ),
                                      decoration: InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        labelText: "Tên",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        filled: false,
                                        fillColor: Color(0xfff2f2f3),
                                        isDense: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: TextField(
                                        // controller: TextEditingController(text: data[index]["value"].toString()),
                                        controller: TextEditingController(
                                            text: _formatter.format(data[index]
                                                    ["total"]
                                                .toString()
                                                .replaceAll('.0', ''))),
                                        obscureText: false,
                                        textAlign: TextAlign.start,
                                        inputFormatters: [
                                          CurrencyTextInputFormatter(
                                            locale: 'ko',
                                            decimalDigits: 0,
                                            symbol: '',
                                          )
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          ChangeValueInList(value, index);
                                          // total = totalList(data).toString();
                                        },
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          labelText: "Giá trị",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: false,
                                          fillColor: Color(0xfff2f2f3),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                        ),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: "Số lượng"),
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      readOnly: true,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff000000),
                                      ),
                                      decoration: InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        filled: false,
                                        fillColor: Color(0xfff2f2f3),
                                        isDense: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: TextField(
                                        // controller: TextEditingController(text: data[index]["value"].toString()),
                                        controller: TextEditingController(
                                            text: data[index]["quantity"]
                                                .toString()),
                                        // text: _formatter.format(
                                        //     data[index]["quantity"].toString())),
                                        obscureText: false,
                                        textAlign: TextAlign.start,
                                        inputFormatters: [
                                          CurrencyTextInputFormatter(
                                            locale: 'ko',
                                            decimalDigits: 0,
                                            symbol: '',
                                          )
                                        ],
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // ChangeValueInList(value, index);
                                          ChangeValueQuantityInList(
                                              value, index);
                                        },
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          labelText: "Giá trị",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: false,
                                          fillColor: Color(0xfff2f2f3),
                                          isDense: false,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20),
              Visibility(
                  visible: status == 0 ? false : true,
                  child: ElevatedButton(
                    onPressed:
                        TotalValueList, //data.length > 0 ? updateData : null,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Tính tổng",
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.calculate_outlined)
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Tổng cộng")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(_formatter.format(
                                  total.toString().replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text("Tổng số buổi nghỉ học ")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(_formatter.format(
                                  sobuoioff.toString().replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Trừ phí")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(_formatter.format(totalOff_Controller
                                  .text
                                  .toString()
                                  .replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text("Còn lại")),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              // child: Text(_formatter.format((
                              //     totalOff_Controller.text + total
                              // ).toString())),
                              child: Text(_formatter.format((total -
                                      double.parse(totalOff_Controller.text
                                          .toString()
                                          .replaceAll(',', '')))
                                  .toString()
                                  .replaceAll('.0', ''))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: status == 0 ? false : true,
                  child: SizedBox(height: 15)),
              Visibility(
                  visible: status == 0 ? false : true,
                  child: ElevatedButton(
                    onPressed:
                        updateData, //data.length > 0 ? updateData : null,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Cập nhật",
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.save)
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ]),
    );
  }

  selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime(2025),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedYear = dateTime;
                  showYear = "${dateTime.year}";
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => DialogAddMaterHocPhiScreen(itemScreen1: data),
    );
    var result = await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
  }

  ChangeValueInList(value, index) {
    for (int i = 0; i < data.length; i++) {
      if (index == i) {
        data[i]["total"] = value.toString().replaceAll(',', '');
      }
    }
  }

  ChangeValueQuantityInList(value, index) {
    for (int i = 0; i < data.length; i++) {
      if (index == i) {
        data[i]["quantity"] = value;
      }
    }
  }

  TotalValueList() {
    double _total = 0;
    for (int i = 0; i < data.length; i++) {
      setState(() {
        _total += double.parse(data[i]["total"].toString()) *
            double.parse(data[i]["quantity"].toString());
      });
    }
    setState(() {
      total = _total;
    });
  }

  Future<void> updateData() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      return;
    }
    final id = itemUpdate["id"];
    // final isCompleted = todo['is_completed'];
    final isSuccess = await HocPhiModelService.updateData(id.toString(), body);
    if (isSuccess) {
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(UpdatebodyFirebase)});
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get body {
    return {
      "id": widget.item!["id"],
      "role": widget.item!["role"],
      "studentId": widget.item!["studentId"],
      "content": widget.item!["content"],
      "userId": widget.item!["userId"],
      "months": selectedValuemonth == null
          ? widget.item!["months"]
          : selectedValuemonth,
      "years": showYear != null ? showYear : widget.item!["years"],
      "total": total,
      "phiOff":
          double.parse(totalOff_Controller.text.toString().replaceAll(',', '')),
      "conLai": (total -
          double.parse(
              totalOff_Controller.text.toString().replaceAll(',', ''))),
      "updateDate":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}T02:08:11.311Z",
      "isCompleted": widget.item!["isCompleted"],
      "appID": widget.item!["appID"],
      "hocPhiChiTietModels": data,
      "Gia1BuoiHoc": widget.item!["Gia1BuoiHoc"],
      "giaTienAn1Buoi": widget.item!["giaTienAn1Buoi"],
    };
  }

  Future<void> updateStatusThanhToan() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      return;
    }
    final id = itemUpdate['id'];
    // final isCompleted = todo['is_completed'];
    final isSuccess =
        await HocPhiModelService.updateStatusThanhToan(id.toString(), status);

    if (isSuccess) {
      var InsertbodyFirebase = {
        "to": tokenDevice,
        "priority": "high",
        "notification": {
          "title": "Cập nhật trạng thái thanh toán",
          "body":
              "Trạng thái thanh toán ${widget.item!["months"]}/${widget.item!["years"]} đã được cập nhật !"
        }
      };
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get bodyThanhToan {
    return {
      "status": status == 0 ? true : false,
    };
  }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật học phí",
        "body":
            "Học phí tháng ${widget.item!["months"]}/${widget.item!["years"]} được cập nhật !"
      }
    };
  }
}
