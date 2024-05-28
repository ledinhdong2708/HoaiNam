import 'package:appflutter_one/_components/_services/ThoiKhoaBieu/ThoiKhoaBieuService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/ThoiKhoaBieuScreen/AddThoiKhoaBieuScreen.dart';
import 'package:appflutter_one/_components/modules/ThoiKhoaBieuScreen/ThoiKhoaBieuCardScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/ClasssModel.dart';
import '../../models/classs.dart';
import '../../shared/utils/snackbar_helper.dart';

class ThoiKhoaBieuScreen extends StatefulWidget {
  String img;
  String text;
  ThoiKhoaBieuScreen(this.img, this.text);

  @override
  State<ThoiKhoaBieuScreen> createState() => _ThoiKhoaBieuScreenState();
}

class _ThoiKhoaBieuScreenState extends State<ThoiKhoaBieuScreen> {
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
        FetchChangeListAll(
            selectedDate.day.toString(),
            selectedDate.month.toString(),
            selectedDate.year.toString(),
            selectedValueclass.toString());
      });
  }

  List<ClasssModel> listClasss = <ClasssModel>[];

  // String dropdownValue = "";
  bool isLoading = false;

  String? selectedValueclass = "1";
  // late Classs? selectedValueclass;
  final TextEditingController classController = TextEditingController();
  List items = [];

  void initState() {
    super.initState();
    // FetchTodo();
    FetchClasss();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        if (items.length > 0) {
          FetchChangeListAll(
              selectedDate.day.toString(),
              selectedDate.month.toString(),
              selectedDate.year.toString(),
              selectedValueclass.toString());
        }
      });
    });
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
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: FetchTodo,
          child: Stack(children: [
            // Text("data"),
            Stack(children: [
              backgroundImage(),
              backgroundColor(context),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => _selectDate(context),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: Image.asset(
                                              "images/20.png",
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  child: DropdownMenu<ClasssModel>(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    controller: classController,
                                    enableFilter: true,
                                    requestFocusOnTap: true,
                                    leadingIcon: const Icon(Icons.search),
                                    label: const Text('Search'),
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                            filled: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                            border: OutlineInputBorder(),
                                            fillColor: Colors.transparent),
                                    onSelected: (ClasssModel? icon) {
                                      setState(() {
                                        selectedValueclass =
                                            icon!.id.toString();
                                        FetchChangeListAll(
                                            selectedDate.day.toString(),
                                            selectedDate.month.toString(),
                                            selectedDate.year.toString(),
                                            selectedValueclass.toString());
                                        // FetchChangeClass();
                                      });
                                    },
                                    dropdownMenuEntries: listClasss
                                        .map<DropdownMenuEntry<ClasssModel>>(
                                      (ClasssModel icon) {
                                        return DropdownMenuEntry<ClasssModel>(
                                          value: icon,
                                          label: icon.name.toString(),
                                          // leadingIcon: icon.!id.toString(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: items.length,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            return ThoiKhoaBieuCardScreen(
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
            ]),
          ]),
        ),
      ),
    );
  }

  Future<void> FetchTodo() async {
    final response = await ThoiKhoaBieuService.FetchThoiKhoaBieu();
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

  Future<void> FetchClasss() async {
    List<ClasssModel> lsClasss = [];
    List<ClasssModel> lsClasss1 = [];
    final response = await SharedSerivce.FetchListClasss();
    if (response != null) {
      setState(() {
        lsClasss = response as List<ClasssModel>;
        for (int i = 0; i < lsClasss.length; i++) {
          lsClasss1.add(lsClasss[i]);
        }
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      listClasss = lsClasss1;
      isLoading = false;
    });
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddThoiKhoaBieuScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    // FetchTodo();
    FetchChangeListAll(
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString(),
        selectedValueclass.toString());
    isLoading = false;
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddThoiKhoaBieuScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    // FetchTodo();
    FetchChangeListAll(
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString(),
        selectedValueclass.toString());
    isLoading = false;
  }

  Future<void> FetchChangeListAll(
      String day, String month, String year, String classID) async {
    if (classID == null || classID == "") {
      isLoading = false;
      return;
    }
    final response = await ThoiKhoaBieuService.FetchByDateAndClass(
        selectedDate.day.toString(),
        selectedDate.month.toString(),
        selectedDate.year.toString(),
        classID);
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
