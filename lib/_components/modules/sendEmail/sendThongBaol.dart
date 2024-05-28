import 'package:appflutter_one/_components/_services/DiemDanh/DiemDanhService.dart';
import 'package:appflutter_one/_components/_services/HocSinh/HocSinhService.dart';
import 'package:appflutter_one/_components/_services/Notification/NotificationService.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/_services/sendEmail/sendDD.dart';
import 'package:appflutter_one/_components/_services/sendEmail/sendTB.dart';
import 'package:appflutter_one/_components/_services/sendSMSService/sendSMS.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/models/EmailModel.dart';
import 'package:appflutter_one/_components/models/KhoaHocModel.dart';
import 'package:appflutter_one/_components/models/dropdown_student.dart';
import 'package:appflutter_one/_components/models/sendSmsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class sendEmail extends StatefulWidget {
  const sendEmail({super.key});

  @override
  State<sendEmail> createState() => _sendEmailState();
}

class _sendEmailState extends State<sendEmail> {
  NotificationService _notificationService = NotificationService();
  String? selectedNotificationType;
  String? selectedClass;
  String? selectedYear;
  int? selectedMonth;
  List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
  bool isLoading = false;
  String selectedValueclass = "1";
  String selectyearValueStudent = "";
  List<ClasssModel> listClasss = <ClasssModel>[];
  final TextEditingController classEditingController = TextEditingController();

  final TextEditingController studentEditingController =
      TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool sendViaEmail = true;

  @override
  void initState() {
    super.initState();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();

    FetchClasss();
    FetchKhoaHoc();
  }

  Future<int?> _selectMonth(BuildContext context) async {
    final int? month = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Chọn tháng"),
          content: DropdownButton<int>(
            value: selectedMonth,
            items: List.generate(12, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int month) {
              return DropdownMenuItem<int>(
                value: month,
                child: Text(month.toString()),
              );
            }).toList(),
            onChanged: (int? month) {
              setState(() {
                selectedMonth = month;
              });
              Navigator.of(context).pop(month);
            },
          ),
        );
      },
    );
    return month ?? selectedMonth;
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
    }
    setState(() {
      listClasss = lsClasss1;
      isLoading = false;
    });
  }

  Future<void> sendSMSHocPhiTR() async {
    setState(() {
      isLoading = true;
    });
    String title = titleController.text;
    String content = contentController.text;
    SMSModel emailModel = SMSModel(
      body: content,
    );
    final body = emailModel.toJson();
    final sendEmail =
        await sendSMSDiemDanhService.sendSMSTBhocphiAll(selectedMonth, body);
    if (sendEmail == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gửi email thành công'),
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
            title: Text('Gửi email không thành công'),
            content: Text('Đã có lỗi xảy ra khi gửi email.'),
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

  Future<void> sendTBNH() async {
    setState(() {
      isLoading = true;
    });
    String title = titleController.text;
    String content = contentController.text;
    EmailModel emailModel = EmailModel(
      body: content,
      subject: title,
    );
    final body = emailModel.toJson();
    final sendEmail = await sendThongBao.sendTBNH(body);
    if (sendEmail == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gửi email thành công'),
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
            title: Text('Gửi email không thành công'),
            content: Text('Đã có lỗi xảy ra khi gửi email.'),
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

  Future<void> sendTTHTR() async {
    setState(() {
      isLoading = true;
    });
    String title = titleController.text;
    String content = contentController.text;
    EmailModel emailModel = EmailModel(
      body: content,
      subject: title,
    );
    final body = emailModel.toJson();
    final sendEmail = await sendThongBao.senTBhocphiAll(selectedMonth, body);
    if (sendEmail == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gửi email thành công'),
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
            title: Text('Gửi email không thành công'),
            content: Text('Đã có lỗi xảy ra khi gửi email.'),
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

  Future<void> sendSMSHPKhoa() async {
    setState(() {
      isLoading = true;
    });
    String title = titleController.text;
    String content = contentController.text;
    SMSModel emailModel = SMSModel(
      body: content,
    );
    final body = emailModel.toJson();
    final sendEmail = await sendSMSDiemDanhService.sendSMSHocPhiKhoa(
        selectedClass, selectedYear, selectedMonth, body);
    if (sendEmail == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gửi email thành công'),
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
            title: Text('Gửi email không thành công'),
            content: Text('Đã có lỗi xảy ra khi gửi email.'),
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

  Future<void> sendSMSTBNH() async {
    setState(() {
      isLoading = true;
    });
    String content = contentController.text;
    SMSModel smsModel = SMSModel(
      body: content,
    );
    final body = smsModel.toJson();
    final sendEmail = await sendSMSDiemDanhService.sendSMSTBNH(body);
    if (sendEmail == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gửi email thành công'),
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
            title: Text('Gửi email không thành công'),
            content: Text('Đã có lỗi xảy ra khi gửi email.'),
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

  Future<void> sendTTHKHOI() async {
    setState(() {
      isLoading = true;
    });
    String title = titleController.text;
    String content = contentController.text;
    EmailModel emailModel = EmailModel(
      body: content,
      subject: title,
    );
    final body = emailModel.toJson();
    print(selectedMonth);
    final sendEmail = await sendThongBao.sendTBhocphiKhoa(
        selectedClass, selectedYear, selectedMonth, body);
    if (sendEmail == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gửi email thành công'),
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
            title: Text('Gửi email không thành công'),
            content: Text('Đã có lỗi xảy ra khi gửi email.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email'),
        backgroundColor: const Color.fromARGB(255, 246, 177, 74),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.all(20),
              children: [
                ListTile(
                  title: Text('Send via Email'),
                  leading: Checkbox(
                    value: sendViaEmail,
                    onChanged: (value) {
                      setState(() {
                        sendViaEmail = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Send via SMS'),
                  leading: Checkbox(
                    value: !sendViaEmail,
                    onChanged: (value) {
                      setState(() {
                        sendViaEmail = !value!;
                      });
                    },
                  ),
                ),
                if (sendViaEmail)
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Tiêu Đề'),
                  ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(hintText: 'Nội dung'),
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 8,
                ),
                SizedBox(height: 20),
                Text('Chọn loại thông báo:'),
                ListTile(
                  title: Text('Thông báo nghỉ học'),
                  leading: Radio(
                    value: 'nghi_hoc',
                    groupValue: selectedNotificationType,
                    onChanged: (value) {
                      setState(() {
                        selectedNotificationType = value as String?;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Thông báo Học Phí Toàn Trường'),
                  leading: Radio(
                    value: 'tien_hoc_all',
                    groupValue: selectedNotificationType,
                    onChanged: (value) {
                      setState(() {
                        selectedNotificationType = value as String?;
                      });
                    },
                  ),
                ),
                if (selectedNotificationType == 'tien_hoc_all')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: OutlinedButton(
                          onPressed: () => _selectMonth(context),
                          child: Text(selectedMonth != null
                              ? selectedMonth.toString()
                              : 'Chọn tháng'),
                        ),
                      ),
                    ],
                  ),
                ListTile(
                  title: Text('Thông báo học phí theo khối'),
                  leading: Radio(
                    value: 'tien_hoc_class',
                    groupValue: selectedNotificationType,
                    onChanged: (value) {
                      setState(() {
                        selectedNotificationType = value as String?;
                      });
                    },
                  ),
                ),
                if (selectedNotificationType == 'tien_hoc_class')
                  DropdownButtonFormField<String>(
                    value: selectedYear,
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                    items: listYearStudent
                        .map<DropdownMenuItem<String>>((KhoaHocModel value) {
                      return DropdownMenuItem<String>(
                        value: value.id.toString(),
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Chọn Khóa Học',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 20),
                if (selectedNotificationType == 'tien_hoc_class')
                  DropdownButtonFormField<String>(
                    value: selectedClass,
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                    items: listClasss
                        .map<DropdownMenuItem<String>>((ClasssModel value) {
                      return DropdownMenuItem<String>(
                        value: value.id.toString(),
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Chọn lớp học',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 20),
                if (selectedNotificationType == 'tien_hoc_class')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: OutlinedButton(
                          onPressed: () => _selectMonth(context),
                          child: Text(selectedMonth != null
                              ? selectedMonth.toString()
                              : 'Chọn tháng'),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (sendViaEmail) {
                      if (selectedNotificationType == 'nghi_hoc') {
                        sendTBNH();
                      } else if (selectedNotificationType == 'tien_hoc_all') {
                        sendTTHTR();
                      } else if (selectedNotificationType == 'tien_hoc_class') {
                        sendTTHKHOI();
                      }
                    } else {
                      if (selectedNotificationType == 'nghi_hoc') {
                        sendSMSTBNH();
                      } else if (selectedNotificationType == 'tien_hoc_all') {
                        sendSMSHocPhiTR();
                      } else if (selectedNotificationType == 'tien_hoc_class') {
                        sendSMSHPKhoa();
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 246, 177, 74),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10)),
                  ),
                  child: Text(
                    'Gửi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
