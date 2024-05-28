// import 'package:appflutter_one/_components/_services/HoatDong/HoatDongService.dart';
// import 'package:appflutter_one/_components/modules/HoatDong/ChiTietHoatDongScreen.dart';
// import 'package:appflutter_one/_components/modules/HoatDong/HoatDongCardScreen.dart';
// import 'package:flutter/material.dart';

// import '../../_services/Notification/NotificationService.dart';
// import '../../_services/SharedService/SharedService.dart';
// import '../../models/ClasssModel.dart';
// import '../../models/KhoaHocModel.dart';
// import '../../models/months.dart';
// import '../../shared/utils/snackbar_helper.dart';

// class HoatDongScreen extends StatefulWidget {
//   String img;
//   String text;
//   HoatDongScreen(this.img, this.text);
//   // const HoatDongScreen({Key? key}) : super(key: key);
//   @override
//   State<HoatDongScreen> createState() => _HoatDongScreenState();
// }

// class _HoatDongScreenState extends State<HoatDongScreen> {
//   NotificationService _notificationService = NotificationService();
//   // Avarible
//   bool isLoading = false;

//   List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
//   List<ClasssModel> listClasss = <ClasssModel>[];
//   String selectedValueclass = "";
//   String selectedValueYear = "";
//   final TextEditingController classController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();
//   // List
//   List items = [];
//   void initState() {
//     super.initState();
//     FetchKhoaHoc();
//     FetchClasss();
//     // FetchHoatDong();
//     _notificationService.requestNotificationPermission();
//     _notificationService.forgroundMessage();
//     _notificationService.firebaseInit(context);
//     _notificationService.setupInteractMessage(context);
//     _notificationService.isTokenRefresh();
//     _notificationService.getDeviceToken();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           widget.text,
//           style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
//         ),
//         actions: [
//           InkWell(
//             onTap: navigateToAddPage,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Icon(
//                 Icons.add,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Visibility(
//         visible: isLoading,
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//         replacement: RefreshIndicator(
//           onRefresh: FetchHoatDong,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: DropdownMenu<KhoaHocModel>(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           controller: yearController,
//                           enableFilter: true,
//                           requestFocusOnTap: true,
//                           leadingIcon: const Icon(Icons.search),
//                           label: const Text('Search'),
//                           inputDecorationTheme: const InputDecorationTheme(
//                               filled: true,
//                               contentPadding:
//                                   EdgeInsets.symmetric(vertical: 5.0),
//                               border: OutlineInputBorder(),
//                               fillColor: Colors.transparent),
//                           onSelected: (KhoaHocModel? icon) {
//                             setState(() {
//                               selectedValueYear = icon!.id.toString();
//                               FetchChangeListAll(
//                                   selectedValueYear!, selectedValueclass!);
//                               // FetchChangeClass();
//                             });
//                           },
//                           dropdownMenuEntries: listYearStudent
//                               .map<DropdownMenuEntry<KhoaHocModel>>(
//                             (KhoaHocModel icon) {
//                               return DropdownMenuEntry<KhoaHocModel>(
//                                 value: icon,
//                                 label: icon.name.toString(),
//                               );
//                             },
//                           ).toList(),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: DropdownMenu<ClasssModel>(
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           controller: classController,
//                           enableFilter: true,
//                           requestFocusOnTap: true,
//                           leadingIcon: const Icon(Icons.search),
//                           label: const Text('Search'),
//                           inputDecorationTheme: const InputDecorationTheme(
//                               filled: true,
//                               contentPadding:
//                                   EdgeInsets.symmetric(vertical: 5.0),
//                               border: OutlineInputBorder(),
//                               fillColor: Colors.transparent),
//                           onSelected: (ClasssModel? icon) {
//                             setState(() {
//                               selectedValueclass = icon!.id.toString();
//                               FetchChangeListAll(
//                                   selectedValueYear!, selectedValueclass!);
//                               // FetchListStudent(icon.name);
//                             });
//                           },
//                           dropdownMenuEntries:
//                               listClasss.map<DropdownMenuEntry<ClasssModel>>(
//                             (ClasssModel icon) {
//                               return DropdownMenuEntry<ClasssModel>(
//                                 value: icon,
//                                 label: icon.name.toString(),
//                                 // leadingIcon: icon.!id.toString(),
//                               );
//                             },
//                           ).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     padding: EdgeInsets.all(16),
//                     itemCount: items.length,
//                     shrinkWrap: false,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final item = items[index] as Map;
//                       return HoatDongCardSreen(
//                           index: index,
//                           item: item,
//                           navigationEdit: navigateToEditPage);
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> FetchHoatDong() async {
//     final response = await HoatDongService.FetchHoatDong();
//     if (response != null) {
//       setState(() {
//         items = response;
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> FetchKhoaHoc() async {
//     List<KhoaHocModel> lsKhoaHoc = [];
//     List<KhoaHocModel> lsKhoaHoc1 = [];
//     final response = await SharedSerivce.FetchListKhoaHoc();
//     if (response != null) {
//       setState(() {
//         lsKhoaHoc = response as List<KhoaHocModel>;
//         for (int i = 0; i < lsKhoaHoc.length; i++) {
//           lsKhoaHoc1.add(lsKhoaHoc[i]);
//         }
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       listYearStudent = lsKhoaHoc1;
//       isLoading = false;
//     });
//   }

//   Future<void> FetchClasss() async {
//     List<ClasssModel> lsClasss = [];
//     List<ClasssModel> lsClasss1 = [];
//     final response = await SharedSerivce.FetchListClasss();
//     if (response != null) {
//       setState(() {
//         lsClasss = response as List<ClasssModel>;
//         for (int i = 0; i < lsClasss.length; i++) {
//           lsClasss1.add(lsClasss[i]);
//         }
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       listClasss = lsClasss1;
//       isLoading = false;
//     });
//   }

//   Future<void> FetchChangeListAll(String studentID, String classID) async {
//     if (studentID == null ||
//         classID == null ||
//         studentID == "" ||
//         classID == "") {
//       isLoading = false;
//       return;
//     }
//     final response =
//         await HoatDongService.FetchByKhoaHocAndClass(studentID, classID);
//     if (response != null) {
//       setState(() {
//         items = response;
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> navigateToEditPage(Map item) async {
//     final route = MaterialPageRoute(
//       builder: (context) => ChiTietHoatDongScreen(item: item),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       var isLoading = true;
//     });
//     // FetchTodo();
//     FetchChangeListAll(selectedValueYear!, selectedValueclass!);
//   }

//   Future<void> navigateToAddPage() async {
//     final route = MaterialPageRoute(
//       builder: (context) => ChiTietHoatDongScreen(),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       isLoading = true;
//     });
//     // FetchTodo();
//     FetchChangeListAll(selectedValueYear!, selectedValueclass!);
//   }
// }
