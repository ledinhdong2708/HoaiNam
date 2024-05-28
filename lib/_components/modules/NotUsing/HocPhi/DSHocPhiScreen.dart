// import 'package:appflutter_one/_components/_services/HocPhi/HocPhiService.dart';
// import 'package:appflutter_one/_components/models/ClasssModel.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/AddHocPhiScreen.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/ChiTietHocPhiScreen.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/HocPhiCardScreen.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/HocPhiScreen.dart';
// import 'package:flutter/material.dart';
//
// import '../../_services/HocSinh/HocSinhService.dart';
// import '../../_services/SharedService/SharedService.dart';
// import '../../models/KhoaHocModel.dart';
// import '../../models/classs.dart';
// import '../../models/dropdown_student.dart';
// import '../../shared/utils/snackbar_helper.dart';
//
// class DSHocPhiScreen extends StatefulWidget {
//   String img;
//   String text;
//   DSHocPhiScreen(this.img, this.text);
//   // const SoBeNgoanScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DSHocPhiScreen> createState() => _DSHocPhiScreenState();
// }
//
// class _DSHocPhiScreenState extends State<DSHocPhiScreen> {
//   // String showYear = 'Year';
//   // DateTime _selectedYear = DateTime.now();
//   // selectYear(context) async {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text("Select Year"),
//   //         content: SizedBox(
//   //           width: 300,
//   //           height: 300,
//   //           child: YearPicker(
//   //             firstDate: DateTime(DateTime.now().year - 10, 1),
//   //             // lastDate: DateTime.now(),
//   //             lastDate: DateTime(2035),
//   //             initialDate: DateTime.now(),
//   //             selectedDate: _selectedYear,
//   //             onChanged: (DateTime dateTime) {
//   //               print(dateTime.year);
//   //               setState(() {
//   //                 _selectedYear = dateTime;
//   //                 showYear = "${dateTime.year}";
//   //                 FetchChangeListAll(showYear, selectValueClass);
//   //               });
//   //               Navigator.pop(context);
//   //             },
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//
//   List<ClasssModel> listClasss = <ClasssModel>[];
//   List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
//   String? selectedValueclass = "1";
//   String? selectedValueStudent = "0";
//   String selectyearValueStudent = "";
//   final TextEditingController classController = TextEditingController();
//   final TextEditingController studentController = TextEditingController();
//   List<DropdownStudent> itemStudents = [
//     DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
//   ];
//   bool isLoading = false;
//   //API
//   List items = [];
//   void initState() {
//     super.initState();
//     // FetchTodo();
//     FetchKhoaHoc();
//     FetchClasss();
//
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         if(listYearStudent.length > 0) {
//           FetchChangeListAll(listYearStudent.first.id.toString(),
//               listClasss.first.id.toString());
//         }
//       });
//     });
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
//             onTap: navigateToAddNewPage,
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
//           onRefresh: FetchTodo,
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
//                         child: Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.all(0),
//                           padding: EdgeInsets.all(0),
//                           width: MediaQuery.of(context).size.width,
//                           child:
//                           DropdownMenu<KhoaHocModel>(
//                             width: MediaQuery.of(context).size.width*0.40,
//                             controller: studentController,
//                             enableFilter: true,
//                             requestFocusOnTap: true,
//                             leadingIcon: const Icon(Icons.search),
//                             label: const Text('Search'),
//                             inputDecorationTheme: const InputDecorationTheme(
//                                 filled: true,
//                                 contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                                 border: OutlineInputBorder(),
//                                 fillColor: Colors.transparent
//                             ),
//                             onSelected: (KhoaHocModel? icon) {
//                               setState(() {
//                                 selectyearValueStudent = icon!.id.toString();
//                                 FetchChangeListAll(
//                                     selectyearValueStudent, selectedValueclass!);
//                               });
//                             },
//                             dropdownMenuEntries:
//                             listYearStudent.map<DropdownMenuEntry<KhoaHocModel>>(
//                                   (KhoaHocModel icon) {
//                                 return DropdownMenuEntry<KhoaHocModel>(
//                                   value: icon,
//                                   label: icon.name.toString(),
//                                   // leadingIcon: icon.!id.toString(),
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                           // DropdownMenu<StudentYear>(
//                           //   width: MediaQuery.of(context).size.width * 0.4,
//                           //   initialSelection: list.first,
//                           //   onSelected: (StudentYear? value) {
//                           //     setState(() {
//                           //       dropdownValueStudent = value!.id.toString();
//                           //     });
//                           //   },
//                           //   dropdownMenuEntries: list
//                           //       .map<DropdownMenuEntry<StudentYear>>(
//                           //           (StudentYear value) {
//                           //     return DropdownMenuEntry<StudentYear>(
//                           //         label: value.name, value: value);
//                           //   }).toList(),
//                           // ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child:
//                         DropdownMenu<ClasssModel>(
//                           width: MediaQuery.of(context).size.width*0.40,
//                           controller: classController,
//                           enableFilter: true,
//                           requestFocusOnTap: true,
//                           leadingIcon: const Icon(Icons.search),
//                           label: const Text('Search'),
//                           inputDecorationTheme: const InputDecorationTheme(
//                               filled: true,
//                               contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                               border: OutlineInputBorder(),
//                               fillColor: Colors.transparent
//                           ),
//                           onSelected: (ClasssModel? icon) {
//                             setState(() {
//                               selectedValueclass = icon!.id.toString();
//                               FetchChangeListAll(
//                                   selectyearValueStudent, selectedValueclass!);
//                             });
//                           },
//                           dropdownMenuEntries:
//                           listClasss.map<DropdownMenuEntry<ClasssModel>>(
//                                 (ClasssModel icon) {
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
//                 // Padding(
//                 //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 //   child: Column(
//                 //     children: [
//                 //       Row(
//                 //         children: [
//                 //           Expanded(
//                 //             flex: 1,
//                 //             child: Container(
//                 //               padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                 //               width: MediaQuery.of(context).size.width,
//                 //               decoration: BoxDecoration(
//                 //                 border: Border.all(width: 0.5),
//                 //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 //               ),
//                 //               child: Row(
//                 //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //                 children: [
//                 //                   Align(
//                 //                     alignment: Alignment.center,
//                 //                     child: Text(
//                 //                       "${showYear}",
//                 //                       textAlign: TextAlign.center,
//                 //                       overflow: TextOverflow.clip,
//                 //                       style: TextStyle(
//                 //                         fontWeight: FontWeight.w400,
//                 //                         fontStyle: FontStyle.normal,
//                 //                         fontSize: 14,
//                 //                         color: Colors.black,
//                 //                       ),
//                 //                     ),
//                 //                   ),
//                 //                   InkWell(
//                 //                     // onTap: () => _selectDate(context),
//                 //                     onTap: () => selectYear(context),
//                 //                     borderRadius: BorderRadius.circular(50),
//                 //                     child: ClipRRect(
//                 //                       borderRadius: BorderRadius.circular(50.0),
//                 //                       child: Image.asset(
//                 //                         "images/20.png",
//                 //                         height: 40,
//                 //                         width: 40,
//                 //                         fit: BoxFit.cover,
//                 //                       ),
//                 //                     ),
//                 //                   )
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ),
//                 //           Expanded(
//                 //             flex: 1,
//                 //             child: Container(
//                 //               alignment: Alignment.centerRight,
//                 //               child:
//                 //               DropdownMenu<ClasssModel>(
//                 //                 width: MediaQuery.of(context).size.width*0.45,
//                 //                 controller: classController,
//                 //                 enableFilter: true,
//                 //                 requestFocusOnTap: true,
//                 //                 leadingIcon: const Icon(Icons.search),
//                 //                 label: const Text('Search'),
//                 //                 inputDecorationTheme: const InputDecorationTheme(
//                 //                     filled: true,
//                 //                     contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                 //                     border: OutlineInputBorder(),
//                 //                     fillColor: Colors.transparent
//                 //                 ),
//                 //                 onSelected: (ClasssModel? icon) {
//                 //                   setState(() {
//                 //                     selectValueClass = icon!.id.toString();
//                 //                     FetchChangeListAll(showYear, selectValueClass);
//                 //                   });
//                 //                 },
//                 //                 dropdownMenuEntries:
//                 //                 listClasss.map<DropdownMenuEntry<ClasssModel>>(
//                 //                       (ClasssModel icon) {
//                 //                     return DropdownMenuEntry<ClasssModel>(
//                 //                       value: icon,
//                 //                       label: icon.name.toString(),
//                 //                       // leadingIcon: icon.!id.toString(),
//                 //                     );
//                 //                   },
//                 //                 ).toList(),
//                 //               ),
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 SizedBox(height: 10),
//                 Expanded(
//                   child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     padding: EdgeInsets.all(16),
//                     itemCount: items.length,
//                     shrinkWrap: false,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final item = items[index] as Map;
//                       return HocPhiCardScreen(
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
//
//   Future<void> FetchTodo() async {
//     final response = await HocPhiService.FetchHocPhi();
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
//
//   Future<void> navigateToEditPage(Map item) async {
//     final route = MaterialPageRoute(
//       builder: (context) => HocPhiScreen(item: item),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       var isLoading = true;
//     });
//     // FetchTodo();
//     FetchChangeListAll(
//         selectyearValueStudent, selectedValueclass!);
//   }
//
//   Future<void> navigateToAddPage() async {
//     final route = MaterialPageRoute(
//       builder: (context) => HocPhiScreen(),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       isLoading = true;
//     });
//     FetchChangeListAll(
//         selectyearValueStudent, selectedValueclass!);
//   }
//
//   Future<void> navigateToAddNewPage() async {
//     final route = MaterialPageRoute(
//       builder: (context) => AddHocPhiScreen(),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       isLoading = true;
//     });
//     FetchChangeListAll(
//         selectyearValueStudent, selectedValueclass!);
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
//         // listYearStudent = response;
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       listYearStudent = lsKhoaHoc1;
//       isLoading = false;
//     });
//   }
//
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
//
//   Future<void> FetchChangeListAll(String studentID, String classID) async {
//     if (studentID == null ||
//         classID == null ||
//         studentID == "" ||
//         classID == "") {
//       isLoading = false;
//       return;
//     }
//     final response =
//     await HocPhiService.FetchByYearAndClass(studentID, classID);
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
// }
//
