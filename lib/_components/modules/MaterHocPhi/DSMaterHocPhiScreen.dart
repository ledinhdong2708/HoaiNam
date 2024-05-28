import 'package:appflutter_one/_components/_services/MaterHocPhi/MaterHocPhiService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/MaterHocPhi/ChiTietMaterHocPhiScreen.dart';
import 'package:appflutter_one/_components/modules/MaterHocPhi/MaterHocPhiCardScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class DSMaterHocPhiScreen extends StatefulWidget {
  String img;
  String text;
  DSMaterHocPhiScreen(this.img, this.text);
  // const DSMaterHocPhiScreen({Key? key}) : super(key: key);

  @override
  State<DSMaterHocPhiScreen> createState() => _DSMaterHocPhiScreenState();
}

class _DSMaterHocPhiScreenState extends State<DSMaterHocPhiScreen> {
  NotificationService _notificationService = NotificationService();
  // Avarible
  bool isLoading = false;
  // List
  List items = [];
  void initState() {
    super.initState();
    FetchMaterHocPhi();
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
            onRefresh: FetchMaterHocPhi,
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
                            return MaterHocPhiCardScreen(
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

  Future<void> FetchMaterHocPhi() async {
    final response = await MaterHocPhiService.FetchMaterHocPhi();
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
      builder: (context) => ChiTietMaterHocPhiScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchMaterHocPhi();
  }

  Future<void> navigateToEditPage(item) async {
    final route = MaterialPageRoute(
      builder: (context) => ChiTietMaterHocPhiScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchMaterHocPhi();
  }
}
