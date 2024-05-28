import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/TinTuc/TinTucService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'PH_ChiTietTinTucScreen.dart';

class PH_TinTucScreen extends StatefulWidget {
  String img;
  String text;
  PH_TinTucScreen(this.img, this.text);
  // const PH_TinTucScreen({Key? key}) : super(key: key);

  @override
  State<PH_TinTucScreen> createState() => _PH_TinTucScreenState();
}

class _PH_TinTucScreenState extends State<PH_TinTucScreen> {
  NotificationService _notificationService = NotificationService();
  // Avariable
  bool isLoading = false;
  //API
  List items = [];

  void initState() {
    super.initState();
    FetchTinTuc();
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
      ),
      body: Stack(
        children: [
          backgroundImage(),
          backgroundColor(context),
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x00ffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Text(
                      "Tin tức mới nhất",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.90,
                    decoration: BoxDecoration(
                      color: Color(0x00ffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(16),
                      itemCount: items.length,
                      shrinkWrap: false,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = items[index] as Map;
                        return Card(
                          margin: EdgeInsets.all(4),
                          color: Color(0xffffffff),
                          shadowColor: Color(0xff000000),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side:
                                BorderSide(color: Color(0x4d9e9e9e), width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    items[index]["title"],
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff84cdff),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    items[index]["content"],
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: MaterialButton(
                                    onPressed: () {
                                      navigateToEditPage(items[index]);
                                    },
                                    color: Color(0x00ffffff),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      "Chi tiết",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    textColor: Color(0xff000000),
                                    height: 20,
                                    minWidth: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> FetchTinTuc() async {
    final response = await TinTucService.PH_FetchTinTuc();
    if (response != null) {
      items = response;
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigateToEditPage(item) async {
    final route = MaterialPageRoute(
      builder: (context) => PH_ChiTietTinTucScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
  }
}
