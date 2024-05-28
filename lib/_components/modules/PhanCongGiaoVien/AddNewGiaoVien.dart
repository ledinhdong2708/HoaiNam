import 'dart:io';
import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/models/GiaoVienModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../_services/HocSinh/HocSinhService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddNewGiaoVien extends StatefulWidget {
  const AddNewGiaoVien({Key? key}) : super(key: key);

  @override
  State<AddNewGiaoVien> createState() => _AddNewGiaoVienState();
}

class _AddNewGiaoVienState extends State<AddNewGiaoVien> {
  NotificationService _notificationService = NotificationService();
  TextEditingController nameController = TextEditingController();
  bool isEdit = false;
  bool isLoading = false;
  String? typeOff;
  Map? items;

  bool isEmailValid = true;
  bool isPhone = true;
  bool isText = true;

  List<GiaoVienModel> tempGV = [];
  List<GiaoVienModel> itemGiaoViens = [];
  String? statusValue = "1";

  File? imageFile;

  TextEditingController emailControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();

  final _auth = AuthService();
  String? uidFibase;

  @override
  void initState() {
    super.initState();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  bool isAllFieldsValid() {
    return isEmailValid &&
        nameController.text.isNotEmpty &&
        emailControler.text.isNotEmpty &&
        phoneControler.text.isNotEmpty &&
        isPhone &&
        isText &&
        isGenderSelected();
  }

  bool isEmailFormatValid(String email) {
    String emailRegex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b';
    return RegExp(emailRegex).hasMatch(email);
  }

  bool isPhoneNumberValid(String phoneNumber) {
    String phoneRegex = r'^[0-9]{10}$'; // Số điện thoại có 10 chữ số
    return RegExp(phoneRegex).hasMatch(phoneNumber);
  }

  bool isGenderSelected() {
    return typeOff != null;
  }

  bool isTextValid(String inputText) {
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
          "Thêm mới",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
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
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: emailControler,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.mail),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (emailControler) {
                                      setState(() {
                                        isEmailValid =
                                            isEmailFormatValid(emailControler);
                                      });
                                    },
                                  ),
                                  if (!isEmailValid)
                                    Text(
                                      'Email không hợp lệ',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                ],
                              ),
                            ),
                          ),
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
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: phoneControler,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    onChanged: (phoneControler) {
                                      setState(() {
                                        isPhone =
                                            isPhoneNumberValid(phoneControler);
                                      });
                                    },
                                  ),
                                  if (!isPhone)
                                    Text(
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
                                "Giới tính: ",
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: isAllFieldsValid() ? submitData : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(isEdit ? 'Cập nhật' : 'Thêm mới'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ]),
    );
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

  Future<void> RegisterFireBase() async {
    String phone = phoneControler.text;
    String usernameSignup = getInitials(nameController.text);
    String username = '${usernameSignup.toLowerCase()}${phone}@gmail.com';
    String passwordSignup = "1234567@";
    print(username);

    try {
      bool phoneExists = await _auth.checkPhoneNumberExists(phone);
      if (phoneExists) {
        showErrorMessage(context, message: 'Số điện thoại đã tồn tại');
        return;
      }
      UserCredential userCredential = await _auth.signUpWithEmailPassword(
          username, passwordSignup, nameController.text, phoneControler.text);
      if (userCredential != null && userCredential.user != null) {
        uidFibase = userCredential.user!.uid;
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
    } catch (e) {
      // Xử lý các lỗi đăng ký ở đây
      print("Đăng ký thất bại: $e");
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Map get bodySignUp {
    return {
      "uid": uidFibase,
      "email": "${emailControler.text}",
      "username": "${phoneControler.text}",
      "password": "1234567@",
      "confirmPassword": "1234567@",
      "firstName": "Giáo Viên",
      "lastName": "${nameController.text}",
      "phone": "${phoneControler.text}",
      "city": "Việt nam",
      "address": "Việt nam",
      "address2": "Việt nam",
      "role": 2,
      "active": 1
    };
  }
}
