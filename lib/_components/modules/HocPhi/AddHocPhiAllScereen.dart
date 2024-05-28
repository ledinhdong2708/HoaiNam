import 'package:appflutter_one/_components/_services/HocPhi/HocPhiModelService.dart';
import 'package:appflutter_one/_components/_services/HocSinh/HocSinhService.dart';
import 'package:appflutter_one/_components/_services/Notification/NotificationService.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/HocPhiModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/models/dropdown_student.dart';
import 'package:appflutter_one/_components/models/months.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ADDHocPhiAllScreen extends StatefulWidget {
  const ADDHocPhiAllScreen({super.key});
  @override
  State<ADDHocPhiAllScreen> createState() => _ADDHocPhiAllScreen();
}

class Month {
  final int id;
  final String name;

  Month(this.id, this.name);
}

class _ADDHocPhiAllScreen extends State<ADDHocPhiAllScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  String selectedValueclass = "1";
  String? selectedValueStudent = "0";
  String selectyearValueStudent = "";
  late DropdownStudent selectItemStudent;
  final TextEditingController studentEditingController =
      TextEditingController();
  final TextEditingController SobuoiHocController = TextEditingController();
  final TextEditingController classEditingController = TextEditingController();
  final TextEditingController tienAnController =
      TextEditingController(); // Thêm TextEditingController cho ô nhập
  final TextEditingController tienHocPhiController = TextEditingController();

  double giaTienMoiBuoi = 0;
  double giaTienAnMoiBuoi = 0;
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  List<ClasssModel> listClasss = <ClasssModel>[];
  List<DropdownStudent> itemStudents = [
    DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
  ];

  int radioHocPhi = 0;
  int radioTienAn = 1;
  bool disableInput = false;

  String showYear = 'Year';
  DateTime _selectedYear = DateTime.now();
  String? selectedValuemonth;
  final TextEditingController monthEditingController = TextEditingController();
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

  List apiData = [];
  List items = [];
  void initState() {
    super.initState();
    FetchKhoaHoc();
    FetchClasss();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  bool isAllFieldsValid() {
    return tienHocPhiController.text.isNotEmpty &&
        tienAnController.text.isNotEmpty &&
        classEditingController.text.isNotEmpty &&
        studentEditingController.text.isNotEmpty &&
        monthEditingController.text.isNotEmpty &&
        selectedValuemonth != "" &&
        studentEditingController.text.isNotEmpty;
  }

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'ko',
    decimalDigits: 0,
    symbol: '',
  );
  Future<void> FetchData() async {
    if (selectyearValueStudent == null ||
        selectedValueclass == null ||
        selectyearValueStudent == "" ||
        selectedValueclass == "") {
      isLoading = false;
      return;
    }
    final response = await HocSinhService.FetchByKhoaHocAndClass(
        selectyearValueStudent, selectedValueclass!);
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 177, 74),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Học Phí",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () async {},
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        SingleChildScrollView(
          child: Visibility(
            visible: isLoading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
            replacement: RefreshIndicator(
              onRefresh: FetchData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownMenu<KhoaHocModel>(
                                width: MediaQuery.of(context).size.width * 0.40,
                                controller: studentEditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search,
                                    color: Colors.black),
                                label: const Text(' Chọn niên Khóa',
                                    style: TextStyle(color: Colors.black)),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                ),
                                onSelected: (KhoaHocModel? icon) {
                                  setState(() {
                                    selectyearValueStudent =
                                        icon!.id.toString();
                                    FetchChangeListAll(selectyearValueStudent,
                                        selectedValueclass!);
                                  });
                                },
                                dropdownMenuEntries: listYearStudent
                                    .map<DropdownMenuEntry<KhoaHocModel>>(
                                  (KhoaHocModel icon) {
                                    return DropdownMenuEntry<KhoaHocModel>(
                                      value: icon,
                                      label: icon.name.toString(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width,
                              child: DropdownMenu<ClasssModel>(
                                width: MediaQuery.of(context).size.width * 0.40,
                                controller: classEditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search,
                                    color: Colors.black),
                                label: const Text('Chọn Lớp',
                                    style: TextStyle(color: Colors.black)),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5.0),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                ),
                                onSelected: (ClasssModel? icon) {
                                  setState(() {
                                    selectedValueclass = icon!.id.toString();
                                    FetchChangeListAll(selectyearValueStudent,
                                        selectedValueclass!);
                                  });
                                },
                                dropdownMenuEntries: listClasss
                                    .map<DropdownMenuEntry<ClasssModel>>(
                                  (ClasssModel icon) {
                                    return DropdownMenuEntry<ClasssModel>(
                                      value: icon,
                                      label: icon.name.toString(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(3, 2, 10, 2),
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
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
                    const SizedBox(height: 20.0),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: tienHocPhiController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    _formatter
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Nhập giá tiền học phí',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (tienHocPhiController) {
                                    setState(() {
                                      capNhapVaHienThiGiaTienMoiBuoi();
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: TextField(
                                  controller: tienAnController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    _formatter
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Nhập giá tiền ăn ',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (tienAnController) {
                                    setState(() {
                                      capNhapVaHienThiGiaTienMoiBuoi();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: SobuoiHocController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Số buổi học tháng đó ',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (soBuoiHocController) {
                                    setState(() {
                                      capNhapVaHienThiGiaTienMoiBuoi();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Giá học phí 1 buổi Học: ${_formatter.format(giaTienMoiBuoi.toString().replaceAll('.0', ''))}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: radioHocPhi,
                                      onChanged: (value) {
                                        setState(() {
                                          radioHocPhi = value!;
                                          capNhapVaHienThiGiaTienMoiBuoi();
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Tính phí nghỉ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: radioHocPhi,
                                      onChanged: (value) {
                                        setState(() {
                                          radioHocPhi = value!;
                                          capNhapVaHienThiGiaTienMoiBuoi();
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Không tính phí nghỉ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Giá tiền ăn 1 buổi Học: ${_formatter.format(giaTienAnMoiBuoi.toString().replaceAll('.0', ''))}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: radioTienAn,
                                      onChanged: (value) {
                                        setState(() {
                                          radioTienAn = value!;
                                          capNhapVaHienThiGiaTienMoiBuoi();
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Tính phí ăn nghỉ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: radioTienAn,
                                      onChanged: (value) {
                                        setState(() {
                                          radioTienAn = value!;
                                          capNhapVaHienThiGiaTienMoiBuoi();
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Không tính phí ăn nghỉ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers

                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: isAllFieldsValid()
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 85, 170, 227),
                              ),
                              onPressed: () {
                                giaTien1BuoiHoc(
                                  selectyearValueStudent,
                                  selectedValueclass,
                                  tienHocPhiController.text,
                                  selectedValuemonth,
                                  showYear,
                                  tienAnController.text,
                                  giaTienMoiBuoi,
                                  giaTienAnMoiBuoi,
                                );
                              },
                              child: const Text('Cập Nhập'),
                            )
                          : const SizedBox(), // or any other widget you want to display when the button is disabled
                    ),
                  ],
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

  void capNhapVaHienThiGiaTienMoiBuoi() {
    setState(() {
      String tienHocPhiStr = tienHocPhiController.text;
      int tienHocPhi = int.tryParse(tienHocPhiStr.replaceAll(',', '')) ?? 0;

      int soBuoiHoc = int.tryParse(SobuoiHocController.text) ?? 0;

      String tienAndPhiStr = tienAnController.text;
      int tienAndPhi = int.tryParse(tienAndPhiStr.replaceAll(',', '')) ?? 0;
      if (radioHocPhi == 0) {
        // Nếu chọn tính phí nghỉ, giá tiền mỗi buổi là 0
        giaTienMoiBuoi = 0;
      } else {
        giaTienMoiBuoi = tienHocPhi / soBuoiHoc;
        giaTienMoiBuoi = giaTienMoiBuoi.roundToDouble();
      }

      if (radioTienAn == 0) {
        // Nếu chọn tính phí nghỉ, giá tiền mỗi buổi là 0
        giaTienAnMoiBuoi = 0;
      } else {
        giaTienAnMoiBuoi = tienAndPhi / soBuoiHoc;
        giaTienAnMoiBuoi = giaTienAnMoiBuoi.roundToDouble();
      }
    });
  }

  Future<void> FetchKhoaHoc() async {
    List<KhoaHocModel> lsKhoaHoc = [];
    List<KhoaHocModel> lsKhoaHoc1 = [];
    final response = await SharedSerivce.FetchListKhoaHoc();
    if (response != null) {
      setState(() {
        lsKhoaHoc = response as List<KhoaHocModel>;
        for (int i = 0; i < lsKhoaHoc.length; i++) {
          lsKhoaHoc1.add(lsKhoaHoc[i]);
        }
      });
    } else {}
    setState(() {
      listYearStudent = lsKhoaHoc1;
      isLoading = false;
    });
  }

  Future<void> giaTien1BuoiHoc(
      String selectedYearId,
      String selectedClassId,
      String tienHocPhiController,
      String? selectedValuemonth,
      String? year,
      String tienAnController,
      giaTienMoiBuoi,
      giaTienAnMoiBuoi) async {
    setState(() {
      isLoading = true;
    });
    final response = await HocSinhService.AddHocPhiALL(
        selectedClassId,
        selectedYearId,
        tienHocPhiController,
        selectedValuemonth,
        year,
        tienAnController,
        giaTienMoiBuoi,
        giaTienAnMoiBuoi);
    if (response != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cập Nhập thành công '),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cập nhập thất bại'),
            content: Text('Đã có lỗi xảy ra khi cập nhập học phí '),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
    setState(() {
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
    } else {}
    setState(() {
      listClasss = lsClasss1;
      isLoading = false;
    });
  }

  Future<void> FetchChangeListAll(String studentID, String classID) async {
    if (studentID == null ||
        classID == null ||
        studentID == "" ||
        classID == "") {
      isLoading = false;
      return;
    }
    final response =
        await HocSinhService.FetchByKhoaHocAndClass(studentID, classID);
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }
}
