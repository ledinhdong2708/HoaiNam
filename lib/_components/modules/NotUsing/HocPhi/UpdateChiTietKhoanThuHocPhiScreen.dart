// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// import '../../_services/HocPhi/HocPhiService.dart';
// import '../../shared/utils/snackbar_helper.dart';
//
// class UpdateChiTietKhoanThuHocPhiScreen extends StatefulWidget {
//   final Map? item;
//   final Map? itemLine;
//   // UpdateChiTietKhoanThuHocPhiScreen(this.item);
//   const UpdateChiTietKhoanThuHocPhiScreen({Key? key, this.item, this.itemLine}) : super(key: key);
//
//   @override
//   State<UpdateChiTietKhoanThuHocPhiScreen> createState() => _UpdateChiTietKhoanThuHocPhiScreenState();
// }
//
// class _UpdateChiTietKhoanThuHocPhiScreenState extends State<UpdateChiTietKhoanThuHocPhiScreen> {
//
//   String total = '0';
//   TextEditingController nameController = TextEditingController();
//   TextEditingController valueController = TextEditingController();
//   final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
//     locale: 'ko',
//     decimalDigits: 0,
//     symbol: '',
//   );
//
//   // List
//   List data = [];
//
//   void initState() {
//     super.initState();
//     data = widget.itemLine!["chiTietHocPhiTheoMonths"];
//     total = totalList( widget.itemLine!["chiTietHocPhiTheoMonths"]).toString();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           ("Thêm mới"),
//           style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               showDialog<String>(
//                 context: context,
//                 builder: (BuildContext context) => AlertDialog(
//                   title: const Text('Thêm thông tin'),
//                   content: Container(
//                     child: Padding(
//                       padding: EdgeInsets.all(0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: TextField(
//                               controller: nameController,
//                               obscureText: false,
//                               textAlign: TextAlign.start,
//                               maxLines: 1,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Color(0xff000000),
//                               ),
//                               decoration: InputDecoration(
//                                 disabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 labelText: "Tên",
//                                 labelStyle: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 14,
//                                   color: Color(0xff000000),
//                                 ),
//                                 filled: false,
//                                 fillColor: Color(0xfff2f2f3),
//                                 isDense: false,
//                                 contentPadding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 12),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: TextField(
//                               controller: valueController,
//                               obscureText: false,
//                               textAlign: TextAlign.start,
//                               inputFormatters: [
//                                 CurrencyTextInputFormatter(
//                                   locale: 'ko',
//                                   decimalDigits: 0,
//                                   symbol: '',
//                                 )
//                               ],
//                               keyboardType: TextInputType.number,
//                               maxLines: 1,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Color(0xff000000),
//                               ),
//                               decoration: InputDecoration(
//                                 disabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 labelText: "Giá trị",
//                                 labelStyle: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 14,
//                                   color: Color(0xff000000),
//                                 ),
//                                 filled: false,
//                                 fillColor: Color(0xfff2f2f3),
//                                 isDense: false,
//                                 contentPadding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 12),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, 'Cancel'),
//                       child: const Text('Hủy'),
//                     ),
//                     TextButton(
//                       onPressed: () => {
//                         setState(() {
//                           data.add({
//                             "id": 0,//data.length <= 0 ? 0 : data.last["id"] + 1,
//                             "content": nameController.text,
//                             "months": widget.itemLine!["months"],
//                             "years": widget.itemLine!["years"],
//                             "createDate": widget.itemLine!["createDate"],
//                             "updateDate": "",
//                             "total": double.parse(valueController.text.replaceAll(',', '')),
//                             "hocPhiChiTietId": 0,
//                             "isCompleted": widget.item!["isCompleted"],
//                             "userId": 0,
//                             "studentId": 0
//                           });
//                           nameController.text = "";
//                           valueController.text = "";
//                         }),
//                         total = totalList(data).toString(),
//                         Navigator.pop(context, 'OK')
//                       },
//                       child: const Text('Lưu'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             child: Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: Icon(
//                 Icons.add,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   padding: EdgeInsets.all(0),
//                   itemCount: data.length,
//                   shrinkWrap: false,
//                   physics: ScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final item = data[index] as Map;
//                     return Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: TextField(
//                                 controller: TextEditingController(
//                                     text: data[index]["content"]),
//                                 obscureText: false,
//                                 textAlign: TextAlign.start,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 14,
//                                   color: Color(0xff000000),
//                                 ),
//                                 decoration: InputDecoration(
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   labelText: "Tên",
//                                   labelStyle: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14,
//                                     color: Color(0xff000000),
//                                   ),
//                                   filled: false,
//                                   fillColor: Color(0xfff2f2f3),
//                                   isDense: false,
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 12),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: TextField(
//                                 // controller: TextEditingController(text: data[index]["value"].toString()),
//                                 controller: TextEditingController(
//                                     text: _formatter.format(
//                                         data[index]["total"].toString())),
//
//                                 onChanged: (content) {
//                                   updateItemListData(data[index]["id"], content);
//                                 },
//                                 obscureText: false,
//                                 textAlign: TextAlign.start,
//                                 inputFormatters: [
//                                   CurrencyTextInputFormatter(
//                                     locale: 'ko',
//                                     decimalDigits: 0,
//                                     symbol: '',
//                                   )
//                                 ],
//                                 keyboardType: TextInputType.number,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 14,
//                                   color: Color(0xff000000),
//                                 ),
//                                 decoration: InputDecoration(
//                                   disabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   labelText: "Giá trị",
//                                   labelStyle: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14,
//                                     color: Color(0xff000000),
//                                   ),
//                                   filled: false,
//                                   fillColor: Color(0xfff2f2f3),
//                                   isDense: false,
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 12),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 30),
//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       Expanded(flex: 1, child: Text("Tổng cộng")),
//                       Expanded(
//                         flex: 1,
//                         child: Align(
//                           alignment: Alignment.centerRight,
//                           child: Text(
//                               _formatter.format(total)
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                   onPressed: updateData,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text(
//                           "Cập nhật",
//                           style: TextStyle(
//                               color: Colors.black87,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 7),
//                         Icon(Icons.save)
//                       ],
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   double totalList(List data) {
//     double _total = 0;
//     data.forEach((element) {
//       _total += element["total"] as double;
//     });
//     return _total;
//   }
//
//   void updateItemListData(id, value) {
//     for(int i = 0; i< data.length;i++) {
//       if(data[i]["id"] == id) {
//         data[i]["total"] = double.parse(value.toString().replaceAll(',', ''));
//       }
//     }
//     setState(() {
//       total = totalList(data).toString();
//     });
//   }
//
//   Future<void> updateData() async {
//     final itemUpdate = widget.item;
//     if(itemUpdate == null) {
//       print('You can not call update without todo data');
//       return;
//     }
//     // final id = id.toString();
//     // final isCompleted = todo['is_completed'];
//     final isSuccess = await HocPhiService.updateData(widget.item!["id"].toString(), body);
//     Navigator.pop(context);
//     if (isSuccess) {
//       showSuccessMessage(context, message: 'Update Success');
//     } else {
//       showErrorMessage(context,message: 'Update Failed');
//     }
//   }
//
//   Map get body {
//     DateTime now = DateTime.now();
//     return {
//       "id": widget.item!["id"],
//       "content": widget.item!["content"],
//       "studentId": widget.item!["studentId"],
//       "userId": widget.item!["userId"],
//       "createDate": widget.item!["createDate"],
//       "updateDate": widget.item!["updateDate"],
//       "isCompleted": false,
//       "totalMax": widget.item!["totalMax"],
//       "chiTietHocPhis": [
//         {
//           "id": widget.itemLine!["id"],
//           "content": widget.item!["content"],
//           "months": widget.itemLine!["months"],
//           "years": widget.itemLine!["years"],
//           "createDate":widget.itemLine!["createDate"],
//           "updateDate": "",
//           "total": total.replaceAll(',', ''),
//           "hocPhiId": 0,
//           "userId": 0,
//           "studentId": 0,
//           "isCompleted": false,
//           "expDate": widget.itemLine!["expDate"],
//           "chiTietHocPhiTheoMonths": data
//         }
//       ]
//     };
//   }
// }
