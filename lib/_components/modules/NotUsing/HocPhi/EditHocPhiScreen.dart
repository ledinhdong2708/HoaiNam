// import 'package:appflutter_one/_components/_services/HocPhi/HocPhiService.dart';
// import 'package:appflutter_one/_components/models/ClasssModel.dart';
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../_services/SharedService/SharedService.dart';
// import '../../_services/SoBeNgoan/SoBeNgoanService.dart';
// import '../../models/classs.dart';
// import '../../models/dropdown_student.dart';
// import '../../models/months.dart';
// import '../../shared/utils/snackbar_helper.dart';
//
// class EditHocPhiScreen extends StatefulWidget {
//   final Map? item;
//   // const EditHocPhiScreen({Key? key}) : super(key: key);
//
//   const EditHocPhiScreen({Key? key,this.item}): super(key: key);
//
//   @override
//   State<EditHocPhiScreen> createState() => _EditHocPhiScreenState();
// }
//
// class _EditHocPhiScreenState extends State<EditHocPhiScreen> {
//   // Avaiable
//   bool isEdit = false;
//   bool isLoading = false;
//   late DropdownStudent selectItemStudent;
//   String? selectedValueclass = "1";
//   String? selectedValueStudent = "0";
//   final TextEditingController studentEditingController = TextEditingController();
//   final TextEditingController classEditingController = TextEditingController();
//   final TextEditingController totalEditingController = TextEditingController();
//   final TextEditingController contentEditingController = TextEditingController();
//   // List
//   List<ClasssModel> listClasss = <ClasssModel>[];
//   List<DropdownStudent> itemStudents = [
//     DropdownStudent(id: 0, name: "Select Items", chieucao: 0, cannang: 0)
//   ];
//   List data = [];
//   // Pakage
//   final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
//     locale: 'ko',
//     decimalDigits: 0,
//     symbol: '',
//   );
//
//   void initState() {
//     super.initState();
//     FetchClasss();
//     print(widget.item);
//     contentEditingController.text = widget.item!["content"];
//     totalEditingController.text = _formatter.format(widget.item!["totalMax"].toString());
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xf009a37),
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Cập nhật",
//           style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
//         ),
//         actions: [
//           InkWell(
//             onTap: submitData,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Icon(
//                 Icons.save,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {},
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Icon(
//                 Icons.delete,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               SizedBox(height: 5),
//               Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: Text(
//                           "Tổng tiền: ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 14),
//                         )),
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         alignment: Alignment.centerRight,
//                         child:  TextFormField(
//                           controller: totalEditingController,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               prefixIcon: Icon(
//                                 Icons.money,
//                               )),
//                           keyboardType: TextInputType.number,
//                           onChanged: (string) {
//                             string = '${formNum(
//                               string.replaceAll(',', ''),
//                             )}';
//                             totalEditingController.value = TextEditingValue(
//                               text: string,
//                               selection: TextSelection.collapsed(
//                                 offset: string.length,
//                               ),
//                             );
//                           },
//                         ),
//                         // ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 5),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20,10,20,10),
//                 child: TextField(
//                   controller: contentEditingController,
//                   obscureText: false,
//                   textAlign: TextAlign.start,
//                   maxLines: 5,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 14,
//                     color: Color(0xff000000),
//                   ),
//                   decoration: InputDecoration(
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4.0),
//                       borderSide: BorderSide(
//                           color: Color(0xffff0000), width: 1),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4.0),
//                       borderSide: BorderSide(
//                           color: Color(0xffff0000), width: 1),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4.0),
//                       borderSide: BorderSide(
//                           color: Color(0xffff0000), width: 1),
//                     ),
//                     labelText: "Nội dung",
//                     labelStyle: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 14,
//                       color: Colors.red,
//                     ),
//                     filled: false,
//                     fillColor: Color(0x00ff0004),
//                     isDense: false,
//                     contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> FetchTodo(classId) async {
//     final response = await SoBeNgoanService.FetchHocSinh(classId);
//     if (response != null) {
//       setState(() {
//         selectedValueStudent = "0";
//         itemStudents = response;
//         itemStudents.add(DropdownStudent(id: 0, name: "Select Items", cannang: 0,chieucao: 0));
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
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
//       if(isEdit) {
//         listClasss.forEach((element) {
//           if(element.id.toString() == widget.item!['class1']) {
//             selectedValueclass = element.id.toString();
//             classEditingController.text = element.name.toString();
//           }
//         });
//       }
//       isLoading = false;
//     });
//   }
//
//   String formNum(String s) {
//     return NumberFormat.decimalPattern().format(
//       int.parse(s),
//     );
//   }
//
//   Future<void> submitData() async {
//     print(widget.item!["id"].toString());
//     final isSuccess = await HocPhiService.updateData_HocPhi(widget.item!["id"].toString(),body);
//
//     if (isSuccess) {
//       showSuccessMessage(context, message: 'Update Success');
//     } else {
//       showErrorMessage(context,message: 'Update Failed');
//     }
//   }
//
//   Map get body {
//     return {
//       "id": 0,
//       "content": contentEditingController.text,
//       "studentId": widget.item!["studentId"],
//       "userId": widget.item!["userId"],
//       "createDate": "",
//       "updateDate": "",
//       "totalMax": double.parse(totalEditingController.text.replaceAll(',', '')),
//       "totalMin": 0,
//     };
//   }
//
//   // Map get body {
//   //   return {
//   //     "id": 0,
//   //     "content": contentEditingController.text,
//   //     "studentId": selectedValueStudent,
//   //     "userId": 0,
//   //     "createDate": "",
//   //     "updateDate": "",
//   //     "totalMax": double.parse(totalEditingController.text.replaceAll(',', '')),
//   //     "totalMin": 0,
//   //   };
//   // }
// }
