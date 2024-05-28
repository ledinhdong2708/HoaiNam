import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/KhoaHoc/ChiTietKhoaHocScreen.dart';
import 'package:appflutter_one/_components/modules/KhoaHoc/KhoaHocCardScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/KhoaHoc/KhoaHocService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class DSKhoaHocScreen extends StatefulWidget {
  String img;
  String text;
  DSKhoaHocScreen(this.img, this.text);

  @override
  State<DSKhoaHocScreen> createState() => _DSKhoaHocScreenState();
}

class _DSKhoaHocScreenState extends State<DSKhoaHocScreen> {
  NotificationService _notificationService = NotificationService();
  // Avarible
  bool isLoading = false;
  // List
  List items = [];

  void initState() {
    super.initState();
    FetchKhoaHoc();
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
        title: Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: navigateToAddPage,
            child: Padding(
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
            onRefresh: FetchKhoaHoc,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(16),
                          itemCount: items.length,
                          shrinkWrap: false,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            return KhoaHocCardScreen(
                                index: index,
                                item: item,
                                navigationEdit: navigateToEditPage);
                          })),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> FetchKhoaHoc() async {
    final response = await KhoaHocService.FetchKhoaHoc();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietKhoaHocScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchKhoaHoc();
  }

  Future<void> navigateToEditPage(item) async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietKhoaHocScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchKhoaHoc();
  }
}
