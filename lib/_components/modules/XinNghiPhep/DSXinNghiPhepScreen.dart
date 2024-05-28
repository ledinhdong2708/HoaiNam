import 'package:appflutter_one/_components/_services/XinNghiPhep/XinNghiPhepService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/XinNghiPhep/AddXinNghiPhepScreen.dart';
import 'package:appflutter_one/_components/modules/XinNghiPhep/XinNghiPhepCardScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class DSXinNghiPhepScreen extends StatefulWidget {
  String img;
  String text;
  DSXinNghiPhepScreen(this.img, this.text);
  // const DSXinNghiPhepScreen({Key? key}) : super(key: key);

  @override
  State<DSXinNghiPhepScreen> createState() => _DSXinNghiPhepScreenState();
}

class _DSXinNghiPhepScreenState extends State<DSXinNghiPhepScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        FetchXinNghiPhepByDate();
      });
  }

  List dataView = [
    // {"id": 1, "class": "Lá 1", "date": "15/11/2023"},
    // {"id": 2, "class": "Chồi 1", "date": "20/11/2023"}
  ];
  String dropdownValue = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    FetchXinNghiPhepByDate();
    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.text,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
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
        Visibility(
          visible: isLoading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
          replacement: RefreshIndicator(
            onRefresh: FetchXinNghiPhepByDate,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: Colors.black26, width: 1),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff4ca3ff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Color(0x4d9e9e9e), width: 1),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              width: 10,
                            ),
                            MaterialButton(
                              onPressed: () => _selectDate(context),
                              color: Color(0xff498fff),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                side: BorderSide(
                                    color: Color(0xff808080), width: 1),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Image.asset(
                                "images/20.png",
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                              textColor: Color(0xffffffff),
                              height: 40,
                              minWidth: 40,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: dataView.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(16),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = dataView[index] as Map;
                          return XinNghiPhepCardScreen(
                              index: index,
                              item: item,
                              selectedDate: selectedDate,
                              navigationEdit: navigateToEditPage);
                        },
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

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddXinNghiPhepScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });

    FetchXinNghiPhepByDate();
    isLoading = false;
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddXinNghiPhepScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });

    FetchXinNghiPhepByDate();
    isLoading = false;
  }

  Future<void> FetchXinNghiPhepByDate() async {
    final response = await XinNghiPhepService.FetchXinNghiPhepByDate(
        selectedDate.day, selectedDate.month, selectedDate.year);
    if (response != null) {
      setState(() {
        dataView = response["xinNghiPheps"];
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }
}
