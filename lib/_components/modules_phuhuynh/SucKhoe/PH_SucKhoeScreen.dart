import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import 'PH_BieuDoBMIScreen.dart';
import 'PH_BieuDoCanNangScreen.dart';
import 'PH_BieuDoChieuCaoScreen.dart';

class PH_SucKhoeScreen extends StatefulWidget {
  String img;
  String text;
  PH_SucKhoeScreen(this.img, this.text);
  // const PH_SucKhoeScreen({Key? key}) : super(key: key);

  @override
  State<PH_SucKhoeScreen> createState() => _PH_SucKhoeScreenState();
}

class _PH_SucKhoeScreenState extends State<PH_SucKhoeScreen> {
  NotificationService _notificationService = NotificationService();

  void initState() {
    super.initState();

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
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        SafeArea(
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => {
                        navigateToPage(1),
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Color(0xffffef00), width: 3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Biểu đồ chiều cao",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 30,
                                                color: Color(0xfffcf300)),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      //   width: 16,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/27.png"),
                                      height: 100,
                                      width: 140,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () => {navigateToPage(2)},
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.red, width: 3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Biểu đồ cân nặng",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 30,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      //   width: 16,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/28.png"),
                                      height: 100,
                                      width: 140,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () => {navigateToPage(3)},
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.green, width: 3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Biểu đồ BMI",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 30,
                                                color: Colors.green),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 5,
                                      //   width: 16,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/29.png"),
                                      height: 100,
                                      width: 140,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Future<void> navigateToPage(int id) async {
    if (id == 1) {
      final route = MaterialPageRoute(
        builder: (context) => PH_BieuDoChieuCaoScreen(
          // StudentId: widget.item!["id"],
          StudentId: 1,
          title: 'Chiều cao',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    } else if (id == 2) {
      final route = MaterialPageRoute(
        builder: (context) => PH_BieuDoCanNangScreen(
          // StudentId: widget.item!["id"],
          StudentId: 1,
          title: 'Cân nặng',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    } else if (id == 3) {
      final route = MaterialPageRoute(
        builder: (context) => PH_BieuDoBMIScreen(
          // StudentId: widget.item!["id"],
          StudentId: 1,
          title: 'Chỉ số BMI',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    }

    // FetchListStudent(listClasss.first.name);
  }
}
