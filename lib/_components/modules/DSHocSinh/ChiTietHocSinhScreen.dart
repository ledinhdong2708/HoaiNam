import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/models/GiaoVienModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:appflutter_one/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../_services/HocSinh/HocSinhService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/KhoaHocModel.dart';
import '../../models/student_years.dart';
import '../../shared/utils/snackbar_helper.dart';

class ChiTietHocSinhScreen extends StatefulWidget {
  final Map? item;
  const ChiTietHocSinhScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietHocSinhScreen> createState() => _ChiTietHocSinhScreenState();
}

class _ChiTietHocSinhScreenState extends State<ChiTietHocSinhScreen> {
  NotificationService _notificationService = NotificationService();
  TextEditingController nameController = TextEditingController();
  bool isEdit = false;
  bool isLoading = false;
  String? typeOff;
  Map? items;

  List<ClasssModel> listClasss = <ClasssModel>[
    // Classs(id: 1, name: "Lá 1"),
    // Classs(id: 2, name: "Lá 2"),
    // Classs(id: 3, name: "Lá 3"),
    // Classs(id: 4, name: "Mầm 1"),
    // Classs(id: 5, name: "Mầm 2"),
    // Classs(id: 6, name: "Mầm 3"),
    // Classs(id: 7, name: "Chồi 1"),
    // Classs(id: 8, name: "Chồi 2"),
    // Classs(id: 9, name: "Chồi 3"),
  ];
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[
    // StudentYear(id: 1, name: "2020-2021"),
    // StudentYear(id: 2, name: "2021-2022"),
    // StudentYear(id: 3, name: "2022-2023"),
  ];
  List<StudentYear> listStatus = <StudentYear>[
    StudentYear(id: 0, name: "Đã hoàn thành"),
    StudentYear(id: 1, name: "Chưa hoàn thành"),
  ];

  //API
  // List<bool> listStatus = <bool>[false, true];
  List<GiaoVienModel> tempGV = [];
  List<GiaoVienModel> itemGiaoViens = [];
  String? statusValue = "1";

  File? imageFile;
  bool isPhone = true;
  bool isText = true;

  String? selectedValueGV1;
  String? selectedValueYear1;
  String? selectedValueClass1;
  String? selectedValueGV2;
  String? selectedValueYear2;
  String? selectedValueClass2;
  String? selectedValueGV3;
  String? selectedValueYear3;
  String? selectedValueClass3;
  final TextEditingController gv1EditingController = TextEditingController();
  final TextEditingController year1EditingController = TextEditingController();
  final TextEditingController class1EditingController = TextEditingController();
  final TextEditingController gv2EditingController = TextEditingController();
  final TextEditingController year2EditingController = TextEditingController();
  final TextEditingController class2EditingController = TextEditingController();
  final TextEditingController gv3EditingController = TextEditingController();
  final TextEditingController year3EditingController = TextEditingController();
  final TextEditingController class3EditingController = TextEditingController();
  final TextEditingController statusEditingController = TextEditingController();

  TextEditingController chieuCaoControler = TextEditingController();
  TextEditingController canNangControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  String? uidFibase;

  final _auth = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    gv1EditingController.dispose();
    year1EditingController.dispose();
    class1EditingController.dispose();
    gv2EditingController.dispose();
    year2EditingController.dispose();
    class2EditingController.dispose();
    gv3EditingController.dispose();
    year3EditingController.dispose();
    class3EditingController.dispose();
    canNangControler.dispose();
    chieuCaoControler.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    final hocsinh = widget.item;
    if (hocsinh != null) {
      isEdit = true;
      final name = hocsinh['nameStudent'];
      nameController.text = name;
      gv1EditingController.text = hocsinh['gV1'] ?? "";
      year1EditingController.text = hocsinh['year1'] ?? "";
      class1EditingController.text = hocsinh['class1'] ?? "";
      gv2EditingController.text = hocsinh['gV2'] ?? "";
      year2EditingController.text = hocsinh['year2'] ?? "";
      class2EditingController.text = hocsinh['class2'] ?? "";
      gv3EditingController.text = hocsinh['gV3'] ?? "";
      year3EditingController.text = hocsinh['year3'] ?? "";
      class3EditingController.text = hocsinh['class3'] ?? "";
      chieuCaoControler.text = hocsinh['chieuCao'].toString();
      canNangControler.text = hocsinh['canNang'].toString();
      listStatus.forEach((element) {
        if (element.id.toString() ==
            (hocsinh["isCompleted"] == true ? "0" : "1")) {
          statusValue = element.id.toString();
          statusEditingController.text = element.name.toString();
        }
      });
      if (hocsinh["gioiTinh"] == true) {
        typeOff = "0";
      } else if (hocsinh["gioiTinh"] == false) {
        typeOff = "1";
      }
      Detail_FetchHocSinhbyId();
    } else {
      gv1EditingController.text = hocsinh?['gV1'] ?? "";
      year1EditingController.text = hocsinh?['year1'] ?? "";
      class1EditingController.text = hocsinh?['class1'] ?? "";
      gv2EditingController.text = hocsinh?['gV2'] ?? "";
      year2EditingController.text = hocsinh?['year2'] ?? "";
      class2EditingController.text = hocsinh?['class2'] ?? "";
      gv3EditingController.text = hocsinh?['gV3'] ?? "";
      year3EditingController.text = hocsinh?['year3'] ?? "";
      class3EditingController.text = hocsinh?['class3'] ?? "";
      chieuCaoControler.text = hocsinh?['chieuCao'].toString() ?? "";
      canNangControler.text = hocsinh?['canNang'].toString() ?? "";
    }

    FetchKhoaHoc();
    FetchClasss();
    FetchGiaoVien();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  bool isAllFieldsValid() {
    return nameController.text.isNotEmpty &&
        phoneControler.text.isNotEmpty &&
        chieuCaoControler.text.isNotEmpty &&
        canNangControler.text.isNotEmpty &&
        isPhone &&
        gv1EditingController.text.isNotEmpty &&
        isText;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    String phoneRegex = r'^[0-9]{10}$';
    return RegExp(phoneRegex).hasMatch(phoneNumber);
  }

  bool isTextValid(String inputText) {
    // Sử dụng biểu thức chính quy để kiểm tra xem chuỗi không chứa các ký tự đặc biệt, nhưng vẫn chấp nhận các ký tự chữ cái có dấu
    String textRegex = r'^[a-zA-ZÀ-ỹ\s]*$';
    return RegExp(textRegex).hasMatch(inputText);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (isEdit ? (widget.item?["nameStudent"]) : "Thêm mới"),
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              color: Color(0xFF674AEF),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                    onChanged: (nameController) {
                      setState(() {
                        isText = isTextValid(nameController);
                      });
                    },
                  ),
                  Row(
                    children: [
                      if (!isText)
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Tên không có ký tự đặc biệt',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Khóa 1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              )),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: DropdownMenu<KhoaHocModel>(
                                width: MediaQuery.of(context).size.width * 0.45,
                                controller: year1EditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Search'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (KhoaHocModel? icon) {
                                  setState(() {
                                    if (icon != null) {
                                      setState(() {
                                        selectedValueYear1 = icon.id.toString();
                                      });
                                    }
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Lớp 1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              )),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: DropdownMenu<ClasssModel>(
                                width: MediaQuery.of(context).size.width * 0.45,
                                controller: class1EditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Search'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (ClasssModel? icon) {
                                  setState(() {
                                    if (icon != null) {
                                      setState(() {
                                        selectedValueClass1 =
                                            icon.id.toString();
                                      });
                                    }
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (isEdit) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Khóa 2",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<KhoaHocModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: year2EditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Search'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (KhoaHocModel? icon) {
                                    setState(() {
                                      if (icon != null) {
                                        setState(() {
                                          selectedValueYear2 =
                                              icon.id.toString();
                                        });
                                      }
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Lớp 2",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<ClasssModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: class2EditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Search'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (ClasssModel? icon) {
                                    setState(() {
                                      if (icon != null) {
                                        setState(() {
                                          selectedValueClass2 =
                                              icon.id.toString();
                                        });
                                      }
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Khóa 3",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<KhoaHocModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: year3EditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Search'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (KhoaHocModel? icon) {
                                    setState(() {
                                      if (icon != null) {
                                        setState(() {
                                          selectedValueYear3 =
                                              icon.id.toString();
                                        });
                                      }
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Lớp 3",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<ClasssModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: class3EditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Search'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (ClasssModel? icon) {
                                    setState(() {
                                      if (icon != null) {
                                        setState(() {
                                          selectedValueClass3 =
                                              icon.id.toString();
                                        });
                                      }
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
                            )
                          ],
                        ),
                      ],
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                "Giáo viên 1",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              )),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: DropdownMenu<GiaoVienModel>(
                                width: MediaQuery.of(context).size.width * 0.45,
                                controller: gv1EditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('GV'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (GiaoVienModel? icon) {
                                  setState(() {
                                    if (icon != null) {
                                      setState(() {
                                        selectedValueGV1 = icon.id.toString();
                                      });
                                    }
                                  });
                                },
                                dropdownMenuEntries: itemGiaoViens
                                    .map<DropdownMenuEntry<GiaoVienModel>>(
                                  (GiaoVienModel icon) {
                                    return DropdownMenuEntry<GiaoVienModel>(
                                      value: icon,
                                      label:
                                          "${icon.firstName} ${icon.lastName}",
                                      // leadingIcon: icon.!id.toString(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isEdit) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Text(
                                  "Giáo viên 2",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<GiaoVienModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: gv2EditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('GV'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (GiaoVienModel? icon) {
                                    setState(() {
                                      if (icon != null) {
                                        setState(() {
                                          selectedValueGV2 = icon.id.toString();
                                        });
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: itemGiaoViens
                                      .map<DropdownMenuEntry<GiaoVienModel>>(
                                    (GiaoVienModel icon) {
                                      return DropdownMenuEntry<GiaoVienModel>(
                                        value: icon,
                                        label:
                                            "${icon.firstName} ${icon.lastName}",
                                        // leadingIcon: icon.!id.toString(),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Text(
                                  "Giáo viên 3",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownMenu<GiaoVienModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: gv3EditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('GV'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (GiaoVienModel? icon) {
                                    setState(() {
                                      if (icon != null) {
                                        setState(() {
                                          selectedValueGV3 = icon.id.toString();
                                        });
                                      }
                                    });
                                  },
                                  dropdownMenuEntries: itemGiaoViens
                                      .map<DropdownMenuEntry<GiaoVienModel>>(
                                    (GiaoVienModel icon) {
                                      return DropdownMenuEntry<GiaoVienModel>(
                                        value: icon,
                                        label:
                                            "${icon.firstName} ${icon.lastName}",
                                        // leadingIcon: icon.!id.toString(),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      if (isEdit == false)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: phoneControler,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.phone),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (phoneControler) {
                                        setState(() {
                                          isPhone = isPhoneNumberValid(
                                              phoneControler);
                                        });
                                      },
                                    ),
                                    if (!isPhone)
                                      const Text(
                                        'Số điện thoại không hợp lẹ',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                "Chiều cao: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: TextFormField(
                                controller: chieuCaoControler,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.fitness_center,
                                  ),
                                  suffixText: 'cm',
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (string) {
                                  string = '${formNum(
                                    string.replaceAll(',', ''),
                                  )}';
                                  chieuCaoControler.value = TextEditingValue(
                                    text: string,
                                    selection: TextSelection.collapsed(
                                      offset: string.length,
                                    ),
                                  );
                                },
                              ),
                              // ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Cân nặng ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: TextFormField(
                                controller: canNangControler,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.fitness_center,
                                  ),
                                  suffixText: 'kg', // Đơn vị tính
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (string) {
                                  string = '${formNum(
                                    string.replaceAll(',', ''),
                                  )}';
                                  canNangControler.value = TextEditingValue(
                                    text: string,
                                    selection: TextSelection.collapsed(
                                      offset: string.length,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Giới tính",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              )),
                          Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: Text("Nam"),
                                    value: "0",
                                    groupValue: typeOff,
                                    onChanged: (value) {
                                      setState(() {
                                        typeOff = value.toString();
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("Nữ"),
                                    value: "1",
                                    groupValue: typeOff,
                                    onChanged: (value) {
                                      setState(() {
                                        typeOff = value.toString();
                                      });
                                    },
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (isEdit)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "Trạng thái",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: DropdownMenu<StudentYear>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  controller: statusEditingController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Status'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (StudentYear? icon) {
                                    setState(() {
                                      statusValue = icon!.id.toString();
                                    });
                                  },
                                  dropdownMenuEntries: listStatus
                                      .map<DropdownMenuEntry<StudentYear>>(
                                    (StudentYear icon) {
                                      return DropdownMenuEntry<StudentYear>(
                                        value: icon,
                                        label: "${icon.name}",
                                        // leadingIcon: icon.!id.toString(),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: isEdit || isAllFieldsValid()
                        ? (isEdit ? updateData : submitData)
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(isEdit ? 'Cập nhật' : 'Thêm mới'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: isEdit,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 150,
                              width: 200,
                              // Image.asset("images/logo_upload.jpg")
                              child: imageFile == null
                                  ? (isEdit &&
                                          widget.item!['imagePatch'] != null
                                      ? Image.network(
                                          "${SERVER_IP}${widget.item!['imagePatch']}")
                                      : Image.asset("images/36.png"))
                                  : Image.file(imageFile!),
                              //child: Image.asset("images/logo_upload.jpg"),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      imageFromGallery();
                                    },
                                    child: Text("Thư viện"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      imageFromCamera();
                                    },
                                    child: Text("Máy ảnh"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: isEdit,
                    child: ElevatedButton(
                      onPressed: updateImage,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Cập nhật hình ảnh !"),
                      ),
                    ),
                  ),
                ],
              ),
      ]),
    );
  }

  Future<void> FetchGiaoVien() async {
    List<GiaoVienModel> items = [];
    final response = await HocSinhService.FetchGiaoVien();
    if (response != null) {
      tempGV = response as List<GiaoVienModel>;
      for (int i = 0; i < tempGV.length; i++) {
        items.add(tempGV[i]);
      }
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      itemGiaoViens = items;
      if (isEdit) {
        items.forEach((element) {
          if (element.id.toString() == widget.item!['gV1'.toString()]) {
            selectedValueGV1 = element.id.toString();
            gv1EditingController.text =
                "${element.firstName} - ${element.lastName}";
          }
          if (element.id.toString() == widget.item!['gV2'.toString()]) {
            selectedValueGV2 = element.id.toString();
            gv2EditingController.text =
                "${element.firstName} - ${element.lastName}";
          }
          if (element.id.toString() == widget.item!['gV3'.toString()]) {
            selectedValueGV3 = element.id.toString();
            gv3EditingController.text =
                "${element.firstName} - ${element.lastName}";
          }
        });
      }
      isLoading = false;
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
        // listYearStudent = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listYearStudent = lsKhoaHoc1;
      if (isEdit) {
        listYearStudent.forEach((element) {
          if (element.id.toString() == widget.item!['year1']) {
            selectedValueYear1 = element.id.toString();
            year1EditingController.text = element.name.toString();
          }
          if (element.id.toString() == widget.item!['year2']) {
            selectedValueYear2 = element.id.toString();
            year2EditingController.text = element.name.toString();
          }
          if (element.id.toString() == widget.item!['year3']) {
            selectedValueYear3 = element.id.toString();
            year3EditingController.text = element.name.toString();
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
          if (element.id.toString() == widget.item!['class1']) {
            selectedValueClass1 = element.id.toString();
            class1EditingController.text = element.name.toString();
            print(class1EditingController);
          }
          if (element.id.toString() == widget.item!['class2']) {
            selectedValueClass2 = element.id.toString();
            class2EditingController.text = element.name.toString();
          }
          if (element.id.toString() == widget.item!['class3']) {
            selectedValueClass3 = element.id.toString();
            class3EditingController.text = element.name.toString();
          }
        });
      }
      isLoading = false;
    });
  }

  Future<void> submitData() async {
    setState(() {
      isLoading = true;
    });
    await RegisterFireBase();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> RegisterFireBase() async {
    String phone = phoneControler.text;
    String usernameSignup = getInitials(nameController.text);
    String username = '${usernameSignup.toLowerCase()}${phone}@gmail.com';
    String passwordSignup = "1234567@";
    print(username);
    bool phoneExists = await _auth.checkPhoneNumberExists(phone);
    if (phoneExists) {
      showErrorMessage(context, message: 'Số điện thoại đã tồn tại');
      return;
    }
    UserCredential userCredential = await _auth.signUpWithEmailPassword(
        username, passwordSignup, nameController.text, phoneControler.text);
    if (userCredential != null && userCredential.user != null) {
      uidFibase = userCredential.user!.uid;

      final isSuccess = await HocSinhService.submitData(body);
      final isSuccessUp =
          await HocSinhService.createPhuHuynhWithStudent(bodySignUp);
      if (isSuccessUp) {
        runApp(MyApp());
        showSuccessMessage(context, message: 'Tạo mới thành công');
      } else {
        showErrorMessage(context, message: 'Tạo mới thất bại');
      }
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> updateImage() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = itemUpdate['id'];
    // final isCompleted = todo['is_completed'];
    final isSuccess =
        await HocSinhService.updateImage(id.toString(), imageFile!);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Future<void> updateData() async {
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = itemUpdate['id'];
    print(body);
    // final isCompleted = todo['is_completed'];
    final isSuccess = await HocSinhService.updateData(id.toString(), body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  imageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  imageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  Map get body {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
    final nameStudent = nameController.text;
    final year1 = selectedValueYear1;
    final class1 = selectedValueClass1;
    final gv1 = selectedValueGV1;
    final year2 = selectedValueYear2;
    final class2 = selectedValueClass2;
    final gv2 = selectedValueGV2;
    final year3 = selectedValueYear3;
    final class3 = selectedValueClass3;
    final gv3 = selectedValueGV3;
    final ChieuCao = chieuCaoControler.text;
    final CanNang = canNangControler.text;
    final phone = phoneControler.text;
    return {
      "PhuHuynhId": phone,
      "NameStudent": nameStudent,
      "Year1": year1,
      "Class1": class1,
      "GV1": gv1,
      "Year2": year2,
      "Class2": class2,
      "GV2": gv2,
      "Year3": year3,
      "Class3": class3,
      "GV3": gv3,
      "CreateDate": "",
      "isCompleted": statusValue == "0" ? true : false,
      "CanNang": double.parse(CanNang),
      "ChieuCao": double.parse(ChieuCao),
      "gioiTinh": typeOff == "0" ? true : false
    };
  }

  String getInitials(bank_account_name) {
    List<String> names = bank_account_name.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  Map get bodySignUp {
    String usernameSignup = getInitials(nameController.text);
    // "${showYear}-${selectedValueMonth}-28T02:08:11.311Z"
    DateTime now = DateTime.now();
    return {
      "uid": uidFibase,
      "email": "${usernameSignup.toLowerCase()}@gmail.com",
      "username": "${phoneControler.text}",
      "password": "1234567@",
      "confirmPassword": "1234567@",
      "firstName": "Học sinh ",
      "lastName": "${nameController.text}",
      "phone": "${phoneControler.text}",
      "city": "Việt nam",
      "address": "Việt nam",
      "address2": "Việt nam",
      "role": 3,
      "active": 1
    };
  }

  Future<void> Detail_FetchHocSinhbyId() async {
    final response =
        await HocSinhService.Detail_FetchIdByStudent(widget.item!["id"]);
    if (response != null) {
      setState(() {
        // items!["chiTietHocPhis"] = response["data"]["chiTietHocPhis"];
        selectedValueYear1 = response["year1"];
        selectedValueClass1 = response["class1"];
        selectedValueGV1 = response["gV1"];
        selectedValueYear2 = response["year2"];
        selectedValueClass2 = response["class2"];
        selectedValueGV2 = response["gV2"];
        selectedValueYear3 = response["year3"];
        selectedValueClass3 = response["class3"];
        selectedValueGV3 = response["gV3"];
        // return Future.value("Data successfully");
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }
}
