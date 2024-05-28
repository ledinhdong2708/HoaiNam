import 'package:appflutter_one/_components/_services/HocPhi/HocPhiModelService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/HocPhi/ChiTietHocPhiCardService.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'ChiTietHocPhiScreen.dart';
import 'EditChiTietHocPhiScreen.dart';

class DSChiTietHocPhiScreen extends StatefulWidget {
  final Map? item;
  const DSChiTietHocPhiScreen({Key? key, this.item}) : super(key: key);

  @override
  State<DSChiTietHocPhiScreen> createState() => _DSChiTietHocPhiScreenState();
}

class _DSChiTietHocPhiScreenState extends State<DSChiTietHocPhiScreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  // List
  List items = [];
  double totalDone = 0;
  double totalNotDone = 0;
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'ko',
    decimalDigits: 0,
    symbol: '',
  );
  void initState() {
    super.initState();
    // FetchTodo();
    FetchDataByStudent();
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
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Danh sách",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: navigateToAddPage,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.add,
                color: Color(0xFF674AEF),
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
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        margin: EdgeInsets.all(4),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(color: Colors.green, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Tổng đã đóng",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            Text(
                              _formatter.format(totalDone
                                      .toString()
                                      .replaceAll('.0', '')) +
                                  " VNĐ",
                              // "${widget.item!["totalMax"]} vnđ",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Card(
                        margin: const EdgeInsets.all(4),
                        color: const Color(0xffffffff),
                        shadowColor: const Color(0xff000000),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: const BorderSide(color: Colors.red, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Còn lại",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            Text(
                              _formatter.format(totalNotDone
                                      .toString()
                                      .replaceAll('.0', '')) +
                                  " VNĐ",
                              // "${widget.item!["totalMax"]} vnđ",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(0),
                  itemCount: items.length,
                  shrinkWrap: false,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = items[index] as Map;
                    return ChiTietHocPhiCardScreen(
                        index: index,
                        item: item,
                        navigationEdit: navigateToEditPage);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> FetchDataByStudent() async {
    double a = 0;
    double b = 0;
    final response =
        await HocPhiModelService.FetchDataByStudent(widget.item!["id"]);
    if (response != null) {
      setState(() {
        items = response;
        for (int i = 0; i < response.length; i++) {
          if (response[i]["status"] == true) {
            a += response[i]["conLai"];
          } else if (response[i]["status"] == false) {
            b += response[i]["conLai"];
          }
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      totalDone = a;
      totalNotDone = b;
      isLoading = false;
      print("ándhajksndkasnkdasley");
      print(items);
    });
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietHocPhiScreen(
        studentID: widget.item!["id"],
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchDataByStudent();
  }

  Future<void> navigateToEditPage(Map item) async {
    print("ándhajksndkasnkdasl");
    print(item);
    final route = MaterialPageRoute(
      builder: (context) => EditChiTietHocPhiScreen(
        item: item,
        studentID: widget.item!["id"],
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchDataByStudent();
  }
}
