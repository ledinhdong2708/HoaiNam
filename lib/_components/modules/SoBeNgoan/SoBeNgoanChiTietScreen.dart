import 'dart:math';

import 'package:appflutter_one/_components/_services/SoBeNgoan/SoBeNgoanService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/classs.dart';
import 'package:appflutter_one/_components/models/dropdown_student.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/months.dart';
import '../../shared/utils/snackbar_helper.dart';

class SoBeNgoanChiTietScreen extends StatefulWidget {
  final Map? item;
  // SoBeNgoanChiTietScreen(this.img, this.text);
  const SoBeNgoanChiTietScreen({Key? key, this.item}) : super(key: key);

  @override
  State<SoBeNgoanChiTietScreen> createState() => _SoBeNgoanScreenState();
}

class _SoBeNgoanScreenState extends State<SoBeNgoanChiTietScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  // const SoBeNgoanScreen({Key? key}) : super(key: key);
  String showYear = 'Year';
  DateTime _selectedYear = DateTime.now();

  bool isEdit = false;

  bool _selected_hoa1 = false;
  String img_week1 = "images/3.png";

  bool _selected_hoa2 = false;
  String img_week2 = "images/3.png";

  bool _selected_hoa3 = false;
  String img_week3 = "images/3.png";

  bool _selected_hoa4 = false;
  String img_week4 = "images/3.png";

  bool _selected_hoa5 = false;
  String img_week5 = "images/3.png";

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

  List<ClasssModel> listClasss = <ClasssModel>[];

  String? selectedValuemonth;
  String? selectedValueclass = "1";
  String? selectedValueStudent = "0";
  final TextEditingController monthEditingController = TextEditingController();
  final TextEditingController studentEditingController =
      TextEditingController();
  final TextEditingController classEditingController = TextEditingController();
  final TextEditingController nhanXetEditingController =
      TextEditingController();
  final TextEditingController canNangController = TextEditingController();
  final TextEditingController chieuCaoController = TextEditingController();
  //API
  List<DropdownStudent> itemStudents = [
    DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
  ];
  bool isLoading = false;
  late DropdownStudent selectItemStudent;

  @override
  void initState() {
    super.initState();
    FetchClasss();
    final hocsinh = widget.item;
    if (hocsinh != null) {
      isEdit = true;
      listMonths.forEach((element) {
        if (element.id == widget.item!["monthSBN"]) {
          selectedValuemonth = element.id.toString();
          monthEditingController.text = element.name;
        }
      });
      FetchTodo(widget.item!["classSBN"]);
      canNangController.text =
          widget.item!["students"][0]["canNang"].toString();
      chieuCaoController.text =
          widget.item!["students"][0]["chieuCao"].toString();
      showYear = widget.item!["yearSBN"].toString();
      studentEditingController.text = widget.item!["idStudent"].toString();
      _selected_hoa1 = widget.item!["tuan1"];
      _selected_hoa2 = widget.item!["tuan2"];
      _selected_hoa3 = widget.item!["tuan3"];
      _selected_hoa4 = widget.item!["tuan4"];
      _selected_hoa5 = widget.item!["tuan5"];
      _selectWeekShowImg('1', widget.item!["tuan1"]);
      _selectWeekShowImg('2', widget.item!["tuan2"]);
      _selectWeekShowImg('3', widget.item!["tuan3"]);
      _selectWeekShowImg('4', widget.item!["tuan4"]);
      _selectWeekShowImg('5', widget.item!["tuan5"]);
      nhanXetEditingController.text = widget.item!["nhanXet"];
    }
    // FetchTodo(listClasss.first.name);
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
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
          (isEdit
              ? (widget.item!["students"][0]["nameStudent"].toString())
              : "Thêm mới"),
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                // decoration: BoxDecoration(
                //   color: Color(0x00bbb5b5),
                //   shape: BoxShape.rectangle,
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                // ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownMenu<Months>(
                                width: MediaQuery.of(context).size.width * 0.40,
                                controller: monthEditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Tháng'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
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
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${showYear}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownMenu<ClasssModel>(
                                width: MediaQuery.of(context).size.width * 0.40,
                                controller: classEditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Lớp'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (ClasssModel? icon) {
                                  setState(() {
                                    selectedValueclass = icon!.id.toString();
                                    itemStudents = [];
                                    studentEditingController.text = "";
                                    FetchTodo(icon!.id.toString());
                                  });
                                },
                                dropdownMenuEntries: listClasss
                                    .map<DropdownMenuEntry<ClasssModel>>(
                                  (ClasssModel icon) {
                                    return DropdownMenuEntry<ClasssModel>(
                                      value: icon,
                                      label: icon.name.toString(),
                                      // leadingIcon: icon.!id.toString(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<DropdownStudent>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  controller: studentEditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Student'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (DropdownStudent? icon) {
                                    setState(() {
                                      selectedValueStudent =
                                          icon!.id.toString();
                                      setChieuCaoCanNang(icon!.id.toString());
                                    });
                                  },
                                  dropdownMenuEntries: itemStudents
                                      .map<DropdownMenuEntry<DropdownStudent>>(
                                    (DropdownStudent icon) {
                                      return DropdownMenuEntry<DropdownStudent>(
                                        value: icon,
                                        label: icon.name,
                                        // leadingIcon: icon.!id.toString(),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected_hoa1 = !_selected_hoa1;
                                      _selectWeekShowImg('1', _selected_hoa1);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Align(
                                          child: Text(
                                            "Tuần 1",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Image.asset(img_week1,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.lightBlue
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected_hoa2 = !_selected_hoa2;
                                      _selectWeekShowImg('2', _selected_hoa2);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Align(
                                          child: Text(
                                            "Tuần 2",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Image.asset(img_week2,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected_hoa3 = !_selected_hoa3;
                                      _selectWeekShowImg('3', _selected_hoa3);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Align(
                                          child: Text(
                                            "Tuần 3",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Image.asset(img_week3,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected_hoa4 = !_selected_hoa4;
                                      _selectWeekShowImg('4', _selected_hoa4);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Align(
                                          child: Text(
                                            "Tuần 4",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Image.asset(img_week4,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Color(0xff808080),
                        height: 10,
                        thickness: 4,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.lightBlue
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected_hoa5 = !_selected_hoa5;
                                      _selectWeekShowImg('5', _selected_hoa5);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Align(
                                          child: Text(
                                            "Cháu ngoan bác Hồ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Image.asset(img_week5,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                              child: Container(
                                decoration:const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Align(
                                        child: Text(
                                          "Nhận xét",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: nhanXetEditingController,
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      maxLines: 9,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff000000),
                                      ),
                                      decoration: const InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: isEdit ? updateData : submitData,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 26.5, horizontal: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset("images/23.png",
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover),
                                            Align(
                                              child: Text(
                                                isEdit
                                                    ? "Cập nhật"
                                                    : "Gửi ý kiến",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
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
              lastDate: DateTime(DateTime.now().year + 10, 5),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
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

  Future<void> _selectWeekShowImg(String week, bool showhide) async {
    if (week == '1') {
      if (showhide) {
        img_week1 = "images/21.png";
      } else {
        img_week1 = "images/3.png";
      }
    }
    if (week == '2') {
      if (showhide) {
        img_week2 = "images/21.png";
      } else {
        img_week2 = "images/3.png";
      }
    }
    if (week == '3') {
      if (showhide) {
        img_week3 = "images/21.png";
      } else {
        img_week3 = "images/3.png";
      }
    }
    if (week == '4') {
      if (showhide) {
        img_week4 = "images/21.png";
      } else {
        img_week4 = "images/3.png";
      }
    }
    if (week == '5') {
      if (showhide) {
        img_week5 = "images/22.png";
      } else {
        img_week5 = "images/3.png";
      }
    }
  }

  Future<void> FetchTodo(classId) async {
    final response = await SoBeNgoanService.FetchHocSinh(classId);
    if (response != null) {
      setState(() {
        selectedValueStudent = "0";
        itemStudents = response;
        itemStudents.add(DropdownStudent(
            id: 0, name: "Select Items", cannang: 0, chieucao: 0));
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      if (isEdit) {
        itemStudents.forEach((element) {
          if (element.id == widget.item!['idStudent']) {
            selectedValueStudent = element.id.toString();
            studentEditingController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> FetchClasss() async {
    List<ClasssModel> lsClasss = [];
    List<ClasssModel> lsClasss1 = [];
    final response = await SharedSerivce.FetchListClasss();
    if (response != null) {
      setState(() {
        lsClasss = response as List<ClasssModel>;
        for (int i = 0; i < lsClasss.length; i++) {
          lsClasss1.add(lsClasss[i]);
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listClasss = lsClasss1;
      if (isEdit) {
        listClasss.forEach((element) {
          if (element.id.toString() == widget.item!['classSBN']) {
            selectedValueclass = element.id.toString();
            classEditingController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> setChieuCaoCanNang(id) async {
    for (int i = 0; i < itemStudents.length; i++) {
      if (itemStudents[i].id == id) {
        selectItemStudent = itemStudents[i];
      }
    }
  }

  Future<void> submitData() async {
    final isSuccess = await SoBeNgoanService.submitData(body);

    if (isSuccess) {
      // selectedValuemonth = '';
      // showYear = '';
      // selectedValueclass = '';
      // selectedValueStudent = '';
      _selected_hoa1 = false;
      _selected_hoa2 = false;
      _selected_hoa3 = false;
      _selected_hoa4 = false;
      _selected_hoa5 = false;
      nhanXetEditingController.text = '';
      var InsertbodyFirebase = {
        "to": tokenDevice,
        "priority": "high",
        "notification": {
          "title": "Thêm mới sổ bé ngoan",
          "body":
              "Sổ bé ngoan lớp ${classEditingController.text} của ${studentEditingController.text} đã được tạo mới !"
        }
      };
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
      showSuccessMessage(context, message: 'Tạo mới thành công');
      // Navigator.pop(context);
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
    final id = itemUpdate['id'];
    // final isCompleted = todo['is_completed'];
    final isSuccess = await SoBeNgoanService.updateData(id.toString(), body);

    if (isSuccess) {
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(UpdatebodyFirebase)});
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật sổ bé ngoan",
        "body":
            "Sổ bé ngoan tháng ${monthEditingController.text}/${showYear.toString()} lớp ${classEditingController.text} của ${studentEditingController.text} đã cập nhật!"
      }
    };
  }

  Map get body {
    return {
      "monthSBN": selectedValuemonth,
      "tuan1": _selected_hoa1,
      "tuan2": _selected_hoa2,
      "tuan3": _selected_hoa3,
      "tuan4": _selected_hoa4,
      "tuan5": _selected_hoa5,
      "nhanXet": nhanXetEditingController.text,
      "chieuCao": 0,
      "canNang": 0,
      "classSBN": selectedValueclass,
      "yearSBN": showYear,
      "CreateDate": "",
      "is_completed": true,
      "idStudent": selectedValueStudent
    };
  }
}
