import 'package:appflutter_one/_components/_services/XinNghiPhep/XinNghiPhepService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/XinNghiPhep/AddChiTietXinNghiPhepScreen.dart';
import 'package:appflutter_one/_components/modules/XinNghiPhep/EditChiTietXinNghiPhepScreen.dart';
import 'package:appflutter_one/_components/modules/XinNghiPhepGV/EditChiTietXinNghiPhepGVScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../_services/SoBeNgoan/SoBeNgoanService.dart';
import '../../models/dropdown_student.dart';
import '../../shared/utils/snackbar_helper.dart';

class AddXinNghiPhepGVScreen extends StatefulWidget {
  final Map? item;
  const AddXinNghiPhepGVScreen({Key? key, this.item}) : super(key: key);

  @override
  State<AddXinNghiPhepGVScreen> createState() => _AddXinNghiPhepGVScreenState();
}

class _AddXinNghiPhepGVScreenState extends State<AddXinNghiPhepGVScreen> {
  NotificationService _notificationService = NotificationService();
  String? tokenDevice = "";
  // Avarialble
  bool isLoading = false;
  bool isEdit = false;
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  // DateTime selectedDateFromAlert = DateTime.now();
  // DateTime selectedDateToAlert = DateTime.now();
  late DropdownStudent selectItemStudent;
  String? selectedValueclass = "1";
  String? selectedValueStudent = "0";
  final TextEditingController studentEditingController =
      TextEditingController();
  final TextEditingController classEditingController = TextEditingController();
  // List
  List<ClasssModel> listClasss = <ClasssModel>[];
  List<DropdownStudent> itemStudents = [
    DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
  ];
  List data = [];
  dynamic items = [];

  @override
  void initState() {
    super.initState();
    FetchClasss();
    final xinNghiPhep = widget.item;
    if (xinNghiPhep != null) {
      isEdit = true;
      data = xinNghiPhep["chiTietXinNghiPheps"];
      FetchHocSinh();
    } else {
      // FetchListHocSinh(listClasss.first.name);
    }
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService
        .getDeviceToken()
        .then((value) => {tokenDevice = value});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xf009a37),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
              Visibility(
                visible: !isEdit,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                          inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              border: OutlineInputBorder(),
                              fillColor: Colors.transparent),
                          onSelected: (ClasssModel? icon) {
                            setState(() {
                              selectedValueclass = icon!.id.toString();
                              FetchListHocSinh(icon.id);
                            });
                          },
                          dropdownMenuEntries:
                              listClasss.map<DropdownMenuEntry<ClasssModel>>(
                            (ClasssModel icon) {
                              return DropdownMenuEntry<ClasssModel>(
                                value: icon,
                                label: icon.name.toString(),
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
                            width: MediaQuery.of(context).size.width * 0.40,
                            enableFilter: true,
                            requestFocusOnTap: true,
                            leadingIcon: const Icon(Icons.search),
                            label: const Text('Search'),
                            inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5.0),
                                border: OutlineInputBorder(),
                                fillColor: Colors.transparent),
                            onSelected: (DropdownStudent? icon) {
                              setState(() {
                                selectedValueStudent = icon!.id.toString();
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
              ),
              // SizedBox(height: 5),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         flex: 1,
              //         child: InkWell(
              //           onTap: () => _selectDateFrom(context),
              //           child: Container(
              //             margin: EdgeInsets.all(0),
              //             padding: EdgeInsets.all(0),
              //             width: MediaQuery.of(context).size.width,
              //             height: 60,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               shape: BoxShape.rectangle,
              //               borderRadius: BorderRadius.circular(15.0),
              //               border: Border.all(
              //                   color: Colors.lightGreenAccent, width: 1),
              //             ),
              //             child: Align(
              //               alignment: Alignment.center,
              //               child: Text(
              //                 "Ngày\n${selectedDateFrom.day}/${selectedDateFrom.month}/${selectedDateFrom.year}",
              //                 textAlign: TextAlign.center,
              //                 overflow: TextOverflow.clip,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w700,
              //                   fontStyle: FontStyle.normal,
              //                   fontSize: 14,
              //                   color: Colors.lightGreenAccent,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       Expanded(
              //         flex: 1,
              //         child: InkWell(
              //           onTap: () => _selectDateTo(context),
              //           child: Container(
              //             margin: EdgeInsets.all(0),
              //             padding: EdgeInsets.all(0),
              //             width: MediaQuery.of(context).size.width,
              //             height: 60,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               shape: BoxShape.rectangle,
              //               borderRadius: BorderRadius.circular(15.0),
              //               border: Border.all(color: Colors.red, width: 1),
              //             ),
              //             child: Align(
              //               alignment: Alignment.center,
              //               child: Text(
              //                 "Ngày\n${selectedDateTo.day}/${selectedDateTo.month}/${selectedDateTo.year}",
              //                 textAlign: TextAlign.center,
              //                 overflow: TextOverflow.clip,
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w700,
              //                   fontStyle: FontStyle.normal,
              //                   fontSize: 14,
              //                   color: Colors.red,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
                        "Nội dung xin nghỉ phép",
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                        ),
                        child: InkWell(
                          onTap: () {
                            navigateToEditPage(item);
                          },
                          child: Card(
                            margin: EdgeInsets.all(0),
                            color: Color(0xffffffff),
                            shadowColor: Color(0xff000000),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
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
                                    decoration: BoxDecoration(
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
                                              margin: EdgeInsets.all(0),
                                              padding: EdgeInsets.all(0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: BoxDecoration(
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
                                                style: TextStyle(
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
                                                margin: EdgeInsets.all(0),
                                                padding: EdgeInsets.all(0),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Color(0x00ffffff),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                child: Text(
                                                  "${data[index]["content"]}",
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
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
                                    margin: EdgeInsets.all(0),
                                    padding: EdgeInsets.all(0),
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0x00ffffff),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    child: Icon(
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
    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigateToAddPage() async {
    if (selectedValueStudent != "0" || isEdit) {
      final route = MaterialPageRoute(
        builder: (context) => AddChiTietXinNghiPhep(
            studentId: selectedValueStudent.toString(),
            item: data,
            isEdit: isEdit),
      );
      final result = await Navigator.push(context, route);
      setState(() {
        isLoading = true;
        if (result != null) {
          print(isEdit);
          if (isEdit == false) {
            for (int i = 0; i < data.length; i++) {
              data[i]["id"] = i + 1;
            }
          } else if (isEdit == true) {}
        }
      });
      // FetchTodo();
      isLoading = false;
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Bạn chưa chọn tên Học Sinh')));
    }
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => EditChiTietXinNghiPhepGVScreen(item: item),
    );
    final result = await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
      if (result != null) {
        data[data.indexWhere((element) => element["id"] == result["id"])] =
            result;
      }
    });
    // FetchTodo();
    isLoading = false;
  }

  Future<void> submitData() async {
    for (int i = 0; i < data.length; i++) {
      data[i]["id"] = 0;
    }
    final isSuccess = await XinNghiPhepService.submitData(body);

    if (isSuccess == true) {
      var InsertbodyFirebase = {
        "to": tokenDevice,
        "priority": "high",
        "notification": {
          "title": "Thêm mới xin nghỉ",
          "body": "Có thông báo xin nghỉ phép mới !"
        }
      };
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
      Navigator.pop(context, 'data');
      showSuccessMessage(context, message: 'Tạo mới thành công');
    } else {
      showErrorMessage(context, message: 'Tạo mới thất bại');
    }
  }

  Future<void> updateData() async {
    for (int i = 0; i < data.length; i++) {
      if (data[i]?["addnew"] == "0") {
        data[i]["id"] = 0;
      }
    }
    final itemUpdate = widget.item;
    if (itemUpdate == null) {
      return;
    }
    final id = widget.item!["id"];
    // final isCompleted = todo['is_completed'];
    final isSuccess =
        await XinNghiPhepService.updateData(id.toString(), bodyUpdate);

    if (isSuccess == true) {
      _notificationService.getDeviceToken().then((value) async =>
          {await SharedSerivce.SendPushNotification(UpdatebodyFirebase)});
      showSuccessMessage(context, message: 'Cập nhật thành công');
    } else {
      showErrorMessage(context, message: 'Cập nhật thất bại');
    }
  }

  Future<void> FetchListHocSinh(classId) async {
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
      isLoading = false;
    });
  }

  Map get body {
    DateTime now = DateTime.now();
    return {
      "id": 0,
      "role": 0,
      "content": "",
      "studentId": selectedValueStudent,
      "userId": 0,
      "createDate":
          DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(now),
      "updateDate":
          DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(now),
      "isCompleted": true,
      "chiTietXinNghiPheps": data
    };
  }

  Map get bodyUpdate {
    DateTime now = DateTime.now();
    return {
      "id": widget.item!["id"],
      "role": widget.item!["role"],
      "content": widget.item!["content"],
      "studentId": widget.item!["studentId"],
      "userId": widget.item!["userId"],
      "createDate": widget.item!["createDate"],
      "updateDate":
          DateFormat('yyyy-MM-dd' + 'T' + 'HH:mm:ss.SSS' + 'Z').format(now),
      "isCompleted": widget.item!["isCompleted"],
      "chiTietXinNghiPheps": data
    };
  }

  Map get UpdatebodyFirebase {
    return {
      "to": tokenDevice,
      "priority": "high",
      "notification": {
        "title": "Cập nhật nghỉ phép",
        "body": "${studentEditingController.text} đã cập nhật xin nghỉ !"
      }
    };
  }
}
