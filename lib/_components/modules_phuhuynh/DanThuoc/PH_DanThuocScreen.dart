import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules_phuhuynh/DanThuoc/PH_AddDanThuocScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/DanThuoc/DanThuocService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';
import 'PH_DanThuocCardScreen.dart';

class PH_DanThuocScreen extends StatefulWidget {
  String img;
  String text;
  PH_DanThuocScreen(this.img, this.text);
  // const PH_DanThuocScreen({Key? key}) : super(key: key);

  @override
  State<PH_DanThuocScreen> createState() => _PH_DanThuocScreenState();
}

class _PH_DanThuocScreenState extends State<PH_DanThuocScreen> {
  NotificationService _notificationService = NotificationService();
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  List items = [];
  void initState() {
    super.initState();
    FetchDanThuoc();
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
      backgroundColor: const Color(0xffffffff),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xff4ca3ff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ngày ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () => _selectDate(context),
                    color: const Color(0xff498fff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      side:
                          const BorderSide(color: Color(0xff808080), width: 1),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      "images/20.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                    textColor: const Color(0xffffffff),
                    height: 40,
                    minWidth: 40,
                  ),
                ],
              ),
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
                    return PH_DamThuocCardScreen(
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        FetchDanThuoc();
      });
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const PH_AddDanThuocScreen(studentID: 1),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchDanThuoc();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => PH_AddDanThuocScreen(item: item, studentID: 1),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    FetchDanThuoc();
  }

  Future<void> FetchDanThuoc() async {
    final response = await DanThuocService.PH_FetchDanThuoc(
        1,
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString());
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
}
