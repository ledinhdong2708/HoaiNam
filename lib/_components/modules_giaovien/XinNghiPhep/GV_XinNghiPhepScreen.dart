import 'dart:convert';

import 'package:appflutter_one/_components/_services/XinNghiPhepGv/XinNghiPhepGvService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules_giaovien/XinNghiPhep/GV_EditChiTietXinNghiPhepScreen.dart';
import 'package:appflutter_one/_components/modules_phuhuynh/XinNghiPhep/PH_EditChiTietXinNghiPhepScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../_services/SoBeNgoan/SoBeNgoanService.dart';
import '../../_services/XinNghiPhep/XinNghiPhepService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'GV_AddChiTietXinNghiPhep.dart';

class GV_XinNghiPhepScreen extends StatefulWidget {
  Map? item;
  String img;
  String text;
  GV_XinNghiPhepScreen(this.item, this.img, this.text);
  // const GV_XinNghiPhepScreen({Key? key}) : super(key: key);

  @override
  State<GV_XinNghiPhepScreen> createState() => _GV_XinNghiPhepScreenState();
}

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class _GV_XinNghiPhepScreenState extends State<GV_XinNghiPhepScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  bool isEdit = false;
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  List data = [];
  dynamic items = [];

  String userId = "";
  void initState() {
    super.initState();
    FetchXinNghiPhepbyId();
    getStorage();

    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          isEdit ? "Cập nhật" : "Thêm mới",
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                isEdit ? Icons.edit : Icons.save,
                color: Color(0xFF674AEF),
              ),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Danh sách các đơn xin phép",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: navigateToAddPage,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.add,
                          color: Color(0xFF674AEF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    shrinkWrap: false,
                    itemCount: data.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = data[index] as Map;
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                        ),
                        child: InkWell(
                          onTap: () {
                            navigateToEditPage(data[index]);
                          },
                          child: Card(
                            margin: const EdgeInsets.all(0),
                            color: const Color(0xffffffff),
                            shadowColor: const Color(0xff000000),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: Color(0xffff0000), width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    margin: EdgeInsets.all(0),
                                    padding: EdgeInsets.all(0),
                                    width: 200,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00ffffff),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.all(0),
                                              padding: const EdgeInsets.all(0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: const BoxDecoration(
                                                color: Color(0x00ffffff),
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                              child: Text(
                                                "Từ ${DateTime.parse(data[index]["fromDate"]).day}/${DateTime.parse(data[index]["fromDate"]).month}/${DateTime.parse(data[index]["fromDate"]).year}"
                                                " đến ${DateTime.parse(data[index]["toDate"]).day}/${DateTime.parse(data[index]["toDate"]).month}/${DateTime.parse(data[index]["toDate"]).year}",
                                                // "Tháng ${widget.item!["chiTietHocPhis"][index]["months"]}/${widget.item!["chiTietHocPhis"][index]["years"]}",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.clip,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14,
                                                  color: Color(0xff4ad6ff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                margin: const EdgeInsets.all(0),
                                                padding:
                                                    const EdgeInsets.all(0),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00ffffff),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                child: Text(
                                                  "${data[index]["content"]}",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.all(0),
                                    padding: const EdgeInsets.all(0),
                                    width: 200,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00ffffff),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xff0026ff),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> FetchXinNghiPhepbyId() async {
    final response = await XinNghiPhepGvService.PH_FetchHocPhiByStudent();
    if (response != null) {
      setState(() {
        for (var item in response["data"]) {
          if (item["chiTietXinNghiPheps"] != null &&
              item["chiTietXinNghiPheps"] is List) {
            data.addAll(item["chiTietXinNghiPheps"]);
          }
        }
      });
    } else {
      print("nulllllll");
      showErrorMessage(context, message: 'Something went wrong');
    }
  }

  Future<void> FetchHocSinh() async {
    final response =
        await SoBeNgoanService.FetchHocSinhById(widget.item!["studentId"]);
    if (response != null) {
      setState(() {
        items = response;
        // itemStudents.add(DropdownStudent(id: 0, name: "Select Items", cannang: 0,chieucao: 0));
        // selectedValueclass = 3.toString();
        // FetchListHocSinh(3);
        // selectedValueStudent = 5.toString();
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {});
  }

  _selectDateFrom(BuildContext context) async {
    final DateTime? pickedFrom = await showDatePicker(
      context: context,
      initialDate: selectedDateFrom,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedFrom != null && pickedFrom != selectedDateFrom)
      setState(() {
        selectedDateFrom = pickedFrom;
        // FetchDinhDuong();
      });
  }

  _selectDateTo(BuildContext context) async {
    final DateTime? pickeTo = await showDatePicker(
      context: context,
      initialDate: selectedDateTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickeTo != null && pickeTo != selectedDateTo)
      setState(() {
        selectedDateTo = pickeTo;
        // FetchDinhDuong();
      });
  }

  Future<void> getStorage() async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    setState(() {
      userId = body['userID'].toString();
    });
  }

  Future<void> navigateToAddPage() async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString('jwt');
    final body = json.decode(value!);
    if (body['userID'].toString() != null || isEdit) {
      final route = MaterialPageRoute(
        builder: (context) => GV_AddChiTietXinNghiPhep(
            studentId: body['userID'].toString(), item: data, isEdit: isEdit),
      );
      final result = await Navigator.push(context, route);
      setState(() {
        if (result != null) {
          if (isEdit == false) {
            for (int i = 0; i < data.length; i++) {
              data[i]["id"] = i + 1;
            }
          } else if (isEdit == true) {}
        }
      });
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('Không tìm thấy ID học sinh')));
    }
  }

  Map? map;

  Future<void> navigateToEditPage(Map item) async {
    print("dataatatatata");
    print(item);
    final route = MaterialPageRoute(
      builder: (context) => GV_EditChiTietXinNghiPhepScreen(item: item),
    );
    final result = await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
      if (result != null) {
        data[data.indexWhere((element) => element["id"] == result["id"])] =
            result;
      }
    });
  }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật xin nghỉ",
        "body": "Xin nghỉ từ phụ huynh đã được cập nhật !"
      }
    };
  }
}
