import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../../_services/HocPhi/HocPhiModelService.dart';
import '../../_services/HocPhi/HocPhiService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../modules/HocPhi/ChiTietHocPhiCardService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'PH_EditHocPhiScreen.dart';

class PH_HocPhiScreen extends StatefulWidget {
  String img;
  String text;
  Map? item;
  PH_HocPhiScreen(this.img, this.text, this.item);
  // const PH_HocPhiScreen({Key? key}) : super(key: key);

  @override
  State<PH_HocPhiScreen> createState() => _PH_HocPhiScreenState();
}

class _PH_HocPhiScreenState extends State<PH_HocPhiScreen> {
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
  @override
  void initState() {
    super.initState();
    FetchDataByStudent();

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
          "Danh sách",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Expanded(
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
                              Text(
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Card(
                          margin: EdgeInsets.all(4),
                          color: Color(0xffffffff),
                          shadowColor: Color(0xff000000),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(color: Colors.red, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(0),
                  itemCount: items.length,
                  shrinkWrap: false,
                  physics: ScrollPhysics(),
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
    final response = await HocPhiModelService.PH_FetchDataByStudent();
    if (response != null) {
      setState(() {
        items = response;
        print(response);
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
    });
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => PH_EditHocPhiScreen(item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchDataByStudent();
  }
}
