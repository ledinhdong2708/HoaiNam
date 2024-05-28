import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/Reports/BaoCaoDoanhThu/BaoCaoDoanhThuScreen.dart';
import 'package:appflutter_one/_components/modules/Reports/DSGiaoVienHocSinh/ListDanhSachGVScreen.dart';
import 'package:appflutter_one/_components/modules/Reports/DSGiaoVienHocSinh/ListDanhSachHocSinhScreen.dart';
import 'package:appflutter_one/_components/modules/Reports/DiemDanhTheoLop/DiemDanhGiaoVienScreen.dart';
import 'package:appflutter_one/_components/modules/Reports/DiemDanhTheoLop/DiemDanhTheoLopScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';

class DSReportScreen extends StatefulWidget {
  String img;
  String text;
  DSReportScreen(this.img, this.text);

  @override
  State<DSReportScreen> createState() => _DSReportScreenState();
}

class _DSReportScreenState extends State<DSReportScreen> {
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
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: const [
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
                          side: BorderSide(color: Colors.orange, width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Điểm danh theo lớp",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 20,
                                                color: Colors.orange),
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
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/47.png"),
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
                      onTap: () => {
                        navigateToPage(2),
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Colors.green, width: 3),
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
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Chấm công giáo viên",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20,
                                              color: Colors.green,
                                            ),
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
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/47.png"),
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
                      onTap: () => {
                        navigateToPage(4),
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        color: Color(0xffffffff),
                        shadowColor: Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                              color: Colors.lightBlue, width: 3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Danh sách tất cả học sinh",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20,
                                              color: Colors.lightBlue,
                                            ),
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
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/47.png"),
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
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => {
                        navigateToPage(5),
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        color: const Color(0xffffffff),
                        shadowColor: const Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 255, 236, 29),
                              width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Danh sách tất cả giáo viên",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20,
                                              color: Colors.yellow,
                                            ),
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
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/47.png"),
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
                    const SizedBox(height: 20),
                    // InkWell(
                    //   onTap: () => {
                    //     navigateToPage(2)
                    //   },
                    //   child: Card(
                    //     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    //     color: Color(0xffffffff),
                    //     shadowColor: Color(0xff000000),
                    //     elevation: 1,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       side: BorderSide(color: Colors.red, width: 3),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             flex: 3,
                    //             child: Container(
                    //               margin: EdgeInsets.all(0),
                    //               padding: EdgeInsets.all(0),
                    //               width: MediaQuery.of(context).size.width,
                    //               height: 120,
                    //               decoration: BoxDecoration(
                    //                 color: Color(0x00ffffff),
                    //                 shape: BoxShape.rectangle,
                    //                 borderRadius: BorderRadius.zero,
                    //               ),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 children: [
                    //                   Align(
                    //                     // alignment: Alignment.center,
                    //                     child: Center(
                    //                       child: Text(
                    //                         "Điểm danh theo HS",
                    //                         textAlign: TextAlign.center,
                    //                         overflow: TextOverflow.clip,
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.w700,
                    //                             fontStyle: FontStyle.normal,
                    //                             fontSize: 20,
                    //                             color: Colors.red),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   // SizedBox(
                    //                   //   height: 5,
                    //                   //   width: 16,
                    //                   // ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             flex: 1,
                    //             child: Container(
                    //               margin: EdgeInsets.all(0),
                    //               padding: EdgeInsets.all(0),
                    //               width: MediaQuery.of(context).size.width,
                    //               height: 120,
                    //               decoration: BoxDecoration(
                    //                 color: Color(0x00ffffff),
                    //                 shape: BoxShape.rectangle,
                    //                 borderRadius: BorderRadius.zero,
                    //               ),
                    //               child: Align(
                    //                 alignment: Alignment.topRight,
                    //                 child: Image(
                    //                   image: AssetImage("images/47.png"),
                    //                   height: 100,
                    //                   width: 140,
                    //                   fit: BoxFit.contain,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // InkWell(
                    //   onTap: () => {
                    //     navigateToPage(2)
                    //   },
                    //   child: Card(
                    //     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    //     color: Color(0xffffffff),
                    //     shadowColor: Color(0xff000000),
                    //     elevation: 1,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       side: BorderSide(color: Colors.red, width: 3),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             flex: 3,
                    //             child: Container(
                    //               margin: EdgeInsets.all(0),
                    //               padding: EdgeInsets.all(0),
                    //               width: MediaQuery.of(context).size.width,
                    //               height: 120,
                    //               decoration: BoxDecoration(
                    //                 color: Color(0x00ffffff),
                    //                 shape: BoxShape.rectangle,
                    //                 borderRadius: BorderRadius.zero,
                    //               ),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 children: [
                    //                   Align(
                    //                     // alignment: Alignment.center,
                    //                     child: Center(
                    //                       child: Text(
                    //                         "Điểm danh theo HS",
                    //                         textAlign: TextAlign.center,
                    //                         overflow: TextOverflow.clip,
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.w700,
                    //                             fontStyle: FontStyle.normal,
                    //                             fontSize: 20,
                    //                             color: Colors.red),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   // SizedBox(
                    //                   //   height: 5,
                    //                   //   width: 16,
                    //                   // ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Expanded(
                    //             flex: 1,
                    //             child: Container(
                    //               margin: EdgeInsets.all(0),
                    //               padding: EdgeInsets.all(0),
                    //               width: MediaQuery.of(context).size.width,
                    //               height: 120,
                    //               decoration: BoxDecoration(
                    //                 color: Color(0x00ffffff),
                    //                 shape: BoxShape.rectangle,
                    //                 borderRadius: BorderRadius.zero,
                    //               ),
                    //               child: Align(
                    //                 alignment: Alignment.topRight,
                    //                 child: Image(
                    //                   image: AssetImage("images/47.png"),
                    //                   height: 100,
                    //                   width: 140,
                    //                   fit: BoxFit.contain,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    InkWell(
                      onTap: () => {navigateToPage(3)},
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        color: const Color(0xffffffff),
                        shadowColor: const Color(0xff000000),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.red, width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        // alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "Báo cáo doanh thu",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 20,
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
                                  margin: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00ffffff),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Image(
                                      image: AssetImage("images/47.png"),
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
        builder: (context) => DiemDanhTheoLopScreen(
          title: 'Điểm danh theo lớp',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    } else if (id == 2) {
      final route = MaterialPageRoute(
        builder: (context) => const DiemDanhGVScreen(
          title: 'Chấm công giáo viên',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    } else if (id == 3) {
      final route = MaterialPageRoute(
        builder: (context) => const BaoCaoDoanhThuScreen(
          title: 'Báo cáo doanh thu',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    } else if (id == 4) {
      final route = MaterialPageRoute(
        builder: (context) => const ListDanhSachHocSinhScreen(
          title: 'Danh sách học sinh',
        ),
      );
      await Navigator.push(context, route);
      setState(() {
        var isLoading = true;
      });
    } else if (id == 5) {
      final route = MaterialPageRoute(
        builder: (context) => ListDanhSachGVScreen(
          title: 'Danh sách giáo viên',
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
