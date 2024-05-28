import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/TinTuc/AddTinTucScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';

class ChiTietTinTucScreen extends StatefulWidget {
  final Map? item;
  const ChiTietTinTucScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ChiTietTinTucScreen> createState() => _ChiTietTinTucScreenState();
}

class _ChiTietTinTucScreenState extends State<ChiTietTinTucScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;

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
      backgroundColor: Color(0xffffffff),
      // appBar: AppBar(
      //   elevation: 4,
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color(0xffeb69ff),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.zero,
      //   ),
      //   title: Text(
      //     "Chi tiết tin tức",
      //     style: TextStyle(
      //       fontWeight: FontWeight.w400,
      //       fontStyle: FontStyle.normal,
      //       fontSize: 14,
      //       color: Color(0xff000000),
      //     ),
      //   ),
      //   leading: Icon(
      //     Icons.arrow_back,
      //     color: Color(0xff212435),
      //     size: 24,
      //   ),
      // ),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Chi tiết tin tức",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          InkWell(
            onTap: navigateToEditPage,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.edit,
                color: Color(0xFF674AEF),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0x1f000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Color(0x4d9e9e9e), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  widget.item!["title"],
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: Color(0xff0800ff),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(4),
                color: Color(0xffffffff),
                shadowColor: Color(0xff000000),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.item!["content"],
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> navigateToEditPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTinTucScreen(item: widget.item),
    );
    await Navigator.push(context as BuildContext, route);
    setState(() {
      isLoading = true;
    });
  }
}
