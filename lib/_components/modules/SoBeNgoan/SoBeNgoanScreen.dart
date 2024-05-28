import 'package:appflutter_one/_components/_services/SoBeNgoan/SoBeNgoanService.dart';
import 'package:appflutter_one/_components/models/ClasssModel.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/SoBeNgoan/SoBeNgoanCardScreen.dart';
import 'package:appflutter_one/_components/modules/SoBeNgoan/SoBeNgoanChiTietScreen.dart';
import 'package:flutter/material.dart';

import '../../_services/Notification/NotificationService.dart';
import '../../_services/SharedService/SharedService.dart';
import '../../models/classs.dart';
import '../../models/months.dart';
import '../../shared/utils/snackbar_helper.dart';

class SoBeNgoanScreen extends StatefulWidget {
  String img;
  String text;
  SoBeNgoanScreen(this.img, this.text);
  // const CourseScreen({Key? key}) : super(key: key);

  @override
  State<SoBeNgoanScreen> createState() => _SoBeNgoanScreenState();
}

class _SoBeNgoanScreenState extends State<SoBeNgoanScreen> {
  NotificationService _notificationService = NotificationService();
  // DateTime selectedDate = DateTime.now();
  String showYear = 'Year';
  DateTime _selectedYear = DateTime.now();
  String? selectedValuemonth;
  final TextEditingController monthEditingController = TextEditingController();
  List<Months> listMonths = <Months>[
    Months(id: 1, name: "Tháng 1"),
    Months(id: 2, name: "Tháng 2"),
    Months(id: 3, name: "Tháng 3"),
    Months(id: 4, name: "Tháng 4"),
    Months(id: 5, name: "Tháng 5"),
    Months(id: 6, name: "Tháng 6"),
    Months(id: 7, name: "Tháng 7"),
    Months(id: 8, name: "Tháng 8"),
    Months(id: 9, name: "Tháng 9"),
    Months(id: 10, name: "Tháng 10"),
    Months(id: 11, name: "Tháng 11"),
    Months(id: 12, name: "Tháng 12"),
  ];

  selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime(2025),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedYear = dateTime;
                  showYear = "${dateTime.year}";
                  FetchChangeListAll(showYear, selectedValueclass,
                      selectedValuemonth.toString());
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  List<ClasssModel> listClasss = <ClasssModel>[];
  String selectedValueclass = "";
  final TextEditingController classController = TextEditingController();
  bool isLoading = false;
  //API
  List items = [];
  void initState() {
    super.initState();
    // FetchTodo();
    FetchClasss();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        if (items.length > 0) {
          FetchChangeListAll(
              showYear, selectedValueclass, selectedValuemonth.toString());
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
            onRefresh: FetchTodo,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(3, 2, 10, 2),
                                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${showYear}",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () => _selectDate(context),
                                      onTap: () => selectYear(context),
                                      borderRadius: BorderRadius.circular(50),
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
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownMenu<Months>(
                                width: MediaQuery.of(context).size.width * 0.48,
                                controller: monthEditingController,
                                enableFilter: true,
                                requestFocusOnTap: true,
                                leadingIcon: const Icon(Icons.search),
                                label: const Text('Tháng'),
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                        filled: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.transparent),
                                onSelected: (Months? icon) {
                                  setState(() {
                                    selectedValuemonth = icon!.id.toString();
                                    FetchChangeListAll(
                                        showYear,
                                        selectedValueclass,
                                        selectedValuemonth.toString());
                                  });
                                },
                                dropdownMenuEntries:
                                    listMonths.map<DropdownMenuEntry<Months>>(
                                  (Months icon) {
                                    return DropdownMenuEntry<Months>(
                                      value: icon,
                                      label: icon.name,
                                      // leadingIcon: icon.!id.toString(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: DropdownMenu<ClasssModel>(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  controller: classController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  leadingIcon: const Icon(Icons.search),
                                  label: const Text('Search'),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.transparent),
                                  onSelected: (ClasssModel? icon) {
                                    setState(() {
                                      selectedValueclass = icon!.id.toString();
                                      FetchChangeListAll(
                                          showYear,
                                          selectedValueclass,
                                          selectedValuemonth.toString());
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
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(16),
                      itemCount: items.length,
                      shrinkWrap: false,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = items[index] as Map;
                        return SoBeNgoanCardScreen(
                            index: index,
                            item: item,
                            navigationEdit: navigateToEditPage);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> FetchTodo() async {
    final response = await SoBeNgoanService.FetchSoBeNgoan();
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

  Future<void> FetchChangeListAll(
      String year, String classID, String month) async {
    if (showYear == null ||
        classID == null ||
        month == null ||
        showYear == "" ||
        month == "" ||
        classID == "") {
      isLoading = false;
      return;
    }
    final response =
        await SoBeNgoanService.FetchByYearAndClass(year, classID, month);
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

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => SoBeNgoanChiTietScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      var isLoading = true;
    });
    // FetchTodo();
    FetchChangeListAll(
        showYear, selectedValueclass, selectedValuemonth.toString());
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => SoBeNgoanChiTietScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    // FetchTodo();
    FetchChangeListAll(
        showYear, selectedValueclass, selectedValuemonth.toString());
  }
}
