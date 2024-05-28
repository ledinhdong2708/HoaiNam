// import 'dart:async';
// import 'dart:io';

// import 'package:appflutter_one/_components/_services/HoatDong/HoatDongService.dart';
// import 'package:appflutter_one/_components/modules/HoatDong/PDFViewerPage.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// import '../../_services/Notification/NotificationService.dart';
// import '../../_services/SharedService/SharedService.dart';
// import '../../models/ClasssModel.dart';
// import '../../models/KhoaHocModel.dart';
// import '../../shared/UrlAPI/API_General.dart';
// import '../../shared/utils/snackbar_helper.dart';

// class ChiTietHoatDongScreen extends StatefulWidget {
//   final Map? item;
//   const ChiTietHoatDongScreen({Key? key, this.item}) : super(key: key);

//   @override
//   State<ChiTietHoatDongScreen> createState() => _ChiTietHoatDongScreenState();
// }

// class _ChiTietHoatDongScreenState extends State<ChiTietHoatDongScreen> {
//   NotificationService _notificationService = NotificationService();
//   String? tokenDevice = "";
//   bool isEdit = false;
//   bool isLoading = false;
//   DateTime date = DateTime.now();
//   String? selectedValueClass;
//   String selectedValueYear = "";
//   final TextEditingController classController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();
//   final TextEditingController contentController = TextEditingController();

//   List<ClasssModel> listClasss = <ClasssModel>[];
//   List<KhoaHocModel> listYearStudent = <KhoaHocModel>[];
//   List items = [];

//   PlatformFile? pickedFile;
//   Uint8List? imageFileListWebPage;
//   File? pickedFileMobile;
//   String imgName = "";

//   void initState() {
//     super.initState();
//     final _hoatDong = widget.item;
//     if (_hoatDong != null) {
//       isEdit = true;
//       contentController.text = _hoatDong["content"];
//       imgName = widget.item!["img"];
//       print("${SERVER_IP}/${widget.item!['img']}");
//     }
//     FetchKhoaHoc();
//     FetchClasss();
//     _notificationService.requestNotificationPermission();
//     _notificationService.forgroundMessage();
//     _notificationService.firebaseInit(context);
//     _notificationService.setupInteractMessage(context);
//     _notificationService.isTokenRefresh();
//     _notificationService
//         .getDeviceToken()
//         .then((value) => {tokenDevice = value});
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
//           (isEdit ? ("${widget.item!["content"]}") : "Thêm mới"),
//           style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
//         ),
//         actions: [
//           InkWell(
//             onTap: isEdit ? updateData : submitData,
//             child: Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: Icon(
//                 isEdit ? Icons.edit : Icons.save,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Stack(
//                   children: [
//                     Text(
//                       'Khóa',
//                       style: TextStyle(
//                         fontSize: 25,
//                         foreground: Paint()
//                           ..style = PaintingStyle.stroke
//                           ..strokeWidth = 3
//                           ..color = Colors.blueAccent!,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   alignment: Alignment.centerRight,
//                   child: DropdownMenu<KhoaHocModel>(
//                     width: MediaQuery.of(context).size.width * 0.45,
//                     controller: yearController,
//                     enableFilter: true,
//                     requestFocusOnTap: true,
//                     leadingIcon: const Icon(Icons.search),
//                     label: const Text('Search'),
//                     inputDecorationTheme: const InputDecorationTheme(
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                         border: OutlineInputBorder(),
//                         fillColor: Colors.transparent),
//                     onSelected: (KhoaHocModel? icon) {
//                       setState(() {
//                         selectedValueYear = icon!.id.toString();
//                       });
//                     },
//                     dropdownMenuEntries:
//                         listYearStudent.map<DropdownMenuEntry<KhoaHocModel>>(
//                       (KhoaHocModel icon) {
//                         return DropdownMenuEntry<KhoaHocModel>(
//                           value: icon,
//                           label: icon.name.toString(),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: 10),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Stack(
//                   children: [
//                     Text(
//                       'Lớp',
//                       style: TextStyle(
//                         fontSize: 25,
//                         foreground: Paint()
//                           ..style = PaintingStyle.stroke
//                           ..strokeWidth = 3
//                           ..color = Colors.blueAccent!,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   alignment: Alignment.centerRight,
//                   child: DropdownMenu<ClasssModel>(
//                     width: MediaQuery.of(context).size.width * 0.45,
//                     controller: classController,
//                     enableFilter: true,
//                     requestFocusOnTap: true,
//                     leadingIcon: const Icon(Icons.search),
//                     label: const Text('Search'),
//                     inputDecorationTheme: const InputDecorationTheme(
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                         border: OutlineInputBorder(),
//                         fillColor: Colors.transparent),
//                     onSelected: (ClasssModel? icon) {
//                       setState(() {
//                         selectedValueClass = icon!.id.toString();
//                       });
//                     },
//                     dropdownMenuEntries:
//                         listClasss.map<DropdownMenuEntry<ClasssModel>>(
//                       (ClasssModel icon) {
//                         return DropdownMenuEntry<ClasssModel>(
//                           value: icon,
//                           label: icon.name.toString(),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: 20),
//           TextField(
//             controller: contentController,
//             obscureText: false,
//             textAlign: TextAlign.start,
//             maxLines: 5,
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontStyle: FontStyle.normal,
//               fontSize: 14,
//               color: Color(0xff000000),
//             ),
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4.0),
//                 borderSide: BorderSide(color: Color(0xffff0000), width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4.0),
//                 borderSide: BorderSide(color: Color(0xffff0000), width: 1),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4.0),
//                 borderSide: BorderSide(color: Color(0xffff0000), width: 1),
//               ),
//               labelText: "Nội dung",
//               labelStyle: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontStyle: FontStyle.normal,
//                 fontSize: 25,
//                 color: Colors.red,
//               ),
//               filled: false,
//               fillColor: Color(0x00ff0004),
//               isDense: false,
//               contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // if (pickedFile != null)
//                 Container(
//                   height: 100,
//                   // height: MediaQuery.of(context).size.height,
//                   color: Colors.blue[100],
//                   child: Center(
//                     child: Column(
//                       children: [
//                         Align(
//                           child: Text(isEdit
//                               ? widget.item!['img'].toString()
//                               : (pickedFile != null ? pickedFile!.name : "")),
//                         ),
//                         // Text(widget.item!['img']),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         // isEdit
//                         //     // ? SfPdfViewer.network(
//                         //     //         "http://www.pdf995.com/samples/pdf.pdf")
//                         //     ? Image.network("${SERVER_IP}/${widget.item!['img']}")
//                         //     : Image.memory(
//                         //         pickedFile!.bytes!,
//                         //         width: double.infinity,
//                         //         fit: BoxFit.cover,
//                         //       ),
//                       ],
//                     ),
//                     // child: Text(pickedFile!.name),
//                     // child: Image.file(
//                     //   File(pickedFile!.path!),
//                     //   width: double.infinity,
//                     //   fit: BoxFit.cover,
//                     // ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: TextButton(
//                           onPressed: () {
//                             // imageFromGallery();
//                             SelectFile();
//                           },
//                           child: Text("Select file"),
//                         ),
//                       ),
//                       isEdit
//                           ? Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextButton(
//                                 style: ElevatedButton.styleFrom(
//                                   foregroundColor: Colors.white,
//                                   backgroundColor: Colors.red, // foreground
//                                 ),
//                                 onPressed: () {
//                                   navigateToViewPDFPage(
//                                       "${SERVER_IP}${widget.item!['img']}");
//                                 },
//                                 child: Text("ViewPDF"),
//                               ),
//                             )
//                           : Padding(
//                               padding: const EdgeInsets.all(8.0),
//                             )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
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
//       if (isEdit) {
//         listYearStudent.forEach((element) {
//           if (element.id.toString() == widget.item!['khoaHocId'].toString()) {
//             selectedValueYear = element.id.toString();
//             yearController.text = element.name.toString();
//           }
//         });
//       }
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
//       if (isEdit) {
//         listClasss.forEach((element) {
//           if (element.id.toString() == widget.item!['classID'].toString()) {
//             selectedValueClass = element.id.toString();
//             classController.text = element.name.toString();
//           }
//         });
//       }
//       isLoading = false;
//     });
//   }

//   Future SelectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       PlatformFile resultFile = result.files.first;
//       // imageFileListWebPage = resultFile.bytes;
//       setState(() {
//         pickedFile = result.files.first;
//         // if (Platform.isAndroid || Platform.isIOS) {
//         if (!kIsWeb) {
//           pickedFileMobile = File(result.files.first.path!);
//         } else {
//           imageFileListWebPage = resultFile.bytes;
//           pickedFile = result.files.first;
//         }
//       });
//     }
//   }

//   // void _saveAs() async {
//   //   if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
//   //     return;
//   //   }
//   //
//   //   String? outputFile = await FilePicker.platform.saveFile(
//   //       dialogTitle: "Please select an output file:", fileName: 'out-file.pdf');
//   //
//   //   if (outputFile == null) {}
//   // }

//   Future<void> submitData() async {
//     await updateImage();
//     final isSuccess = await HoatDongService.submitData(body);

//     if (isSuccess) {
//       var InsertbodyFirebase = {
//         "to": tokenDevice,
//         "priority": "high",
//         "notification": {
//           "title": "Thêm mới hoạt động",
//           "body": "Hoạt động ${contentController.text} đã được tạo mới !"
//         }
//       };
//       _notificationService.getDeviceToken().then((value) async =>
//           {await SharedSerivce.SendPushNotification(InsertbodyFirebase)});
//       showSuccessMessage(context, message: 'Thêm mới thành công');
//       Navigator.pop(context);
//     } else {
//       showErrorMessage(context, message: 'Thêm mới thất bại');
//     }
//   }

//   Future<void> updateData() async {
//     if (pickedFile != null) {
//       await updateImage();
//     }
//     final itemUpdate = widget.item;
//     if (itemUpdate == null) {
//       print('You can not call update without todo data');
//       return;
//     }
//     final id = itemUpdate['id'];
//     // final isCompleted = todo['is_completed'];
//     final isSuccess = await HoatDongService.updateData(id.toString(), body);

//     if (isSuccess) {
//       _notificationService.getDeviceToken().then((value) async =>
//           {await SharedSerivce.SendPushNotification(UpdatebodyFirebase)});
//       showSuccessMessage(context, message: 'Cập nhật thành công');
//     } else {
//       showErrorMessage(context, message: 'Cập nhật thất bại');
//     }
//   }

//   Map get body {
//     // DateTime now = DateTime.now();
//     // String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
//     return {
//       "content": contentController.text,
//       "isCompleted": true,
//       "CreateDate": "",
//       "classID": selectedValueClass,
//       "khoaHocId": selectedValueYear,
//       "img": imgName
//     };
//   }

//   Map get UpdatebodyFirebase {
//     return {
//       "to": tokenDevice,
//       "priority": "high",
//       "notification": {
//         "title": "Cập nhật hoạt động",
//         "body":
//             "${widget.item!["content"]} được cập nhật thành ${contentController.text} !"
//       }
//     };
//   }

//   Future<void> updateImage() async {
//     imgName = "";
//     final isSuccess;
//     if (!kIsWeb) {
//       isSuccess = await HoatDongService.updateImage(
//           pickedFileMobile!, pickedFile!.name);
//     } else {
//       List<Uint8List> a = [];
//       // isSuccess = await HoatDongService.updateImageUint8List(
//       //     pickedFile!, pickedFile!.name);
//       isSuccess = await HoatDongService.updateImageUint8List(
//           imageFileListWebPage, pickedFile!.name);
//     }
//     // final isSuccess = await HoatDongService.updateImage(
//     //     pickedFile!, pickedFile!.name);
//     // print(isSuccess);
//     setState(() {
//       imgName = isSuccess.toString();
//     });
//     if (isSuccess != "Failed") {
//       Navigator.pop(context);
//       showSuccessMessage(context, message: 'Cập nhật file thành công');
//     } else {
//       showErrorMessage(context, message: 'Cập nhật file thất bại');
//     }
//   }

//   Future<void> navigateToViewPDFPage(String stringUrl) async {
//     final route = MaterialPageRoute(
//       builder: (context) => PDFViewerPage(stringUrl),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       isLoading = true;
//     });
//   }
// }
