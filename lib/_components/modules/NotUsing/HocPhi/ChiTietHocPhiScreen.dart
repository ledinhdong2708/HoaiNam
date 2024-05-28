// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:flutter/material.dart';
//
// import '../../_services/HocPhi/HocPhiService.dart';
// import '../../shared/utils/snackbar_helper.dart';
// import 'UpdateChiTietKhoanThuHocPhiScreen.dart';
//
// class ChiTietHocPhiScreen extends StatefulWidget {
//   final Map? item;
//   final Map? itemFull;
//   String img;
//   String text;
//   String statusHocPhi;
//   ChiTietHocPhiScreen(this.item, this.itemFull, this.img, this.text, this.statusHocPhi);
//   // final Map? item;
//   // const ChiTietHocPhiScreen({Key? key, this.item}) : super(key: key);
//
//   @override
//   State<ChiTietHocPhiScreen> createState() => _ChiTietHocPhiScreenState();
// }
//
// class _ChiTietHocPhiScreenState extends State<ChiTietHocPhiScreen> {
//   // const ChiTietHocPhiScreen({Key? key}) : super(key: key);
//   bool isEdit = false;
//   bool isLoading = false;
//   String valueSumString = "0";
//   String? typeOff = "0";
//   Map? chiPhi;
//   final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
//     locale: 'ko',
//     decimalDigits: 0,
//     symbol: '',
//   );
//   @override
//   void initState() {
//     super.initState();
//     final hocsinh = widget.item;
//     if (hocsinh != null) {
//       isEdit = true;
//       if (widget.statusHocPhi == "false") {
//         typeOff = "0";
//       } else if (widget.statusHocPhi == "true") {
//         typeOff = "1";
//       }
//       double valueSum = 0;
//       if (widget.item!["chiTietHocPhiTheoMonths"].length > 0) {
//         for (int i = 0;
//             i < widget.item!["chiTietHocPhiTheoMonths"].length;
//             i++) {
//           valueSum =
//               valueSum + widget.item!["chiTietHocPhiTheoMonths"][i]["total"];
//         }
//         valueSumString = valueSum.toString();
//       } else {
//         valueSumString = "0";
//       }
//       // if(widget.item!["chiTietHocPhiTheoMonths"].length > 0) {
//       //   for (int i = 0; i < widget.item!["chiTietHocPhiTheoMonths"].length; i++) {
//       //     valueSum = valueSum +
//       //         widget.item!["chiTietHocPhiTheoMonths"][i]["total"];
//       //   }
//       //   valueSumString = valueSum.toString();
//       // } else {
//       //   valueSumString = "0";
//       // }
//       if(widget.item != null) {
//         FetchChiTietHocPhiTheoMonth();
//       }
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffc8c8c8),
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           widget.item!["chiTietHocPhiTheoMonths"].length < 0 ? "" :"Tháng ${widget.item!["months"]}/${widget.item!["years"]}",
//           style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
//         ),
//         actions: [
//           InkWell(
//             onTap: navigateToEditPage,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Icon(
//                 Icons.edit,
//                 color: Color(0xFF674AEF),
//               ),
//             ),
//           )
//         ],
//       ),
//       body:  Container(
//           margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           padding: EdgeInsets.all(0),
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             color: Color(0x00ffffff),
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.zero,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Chi tiết thanh toán",
//                     textAlign: TextAlign.start,
//                     overflow: TextOverflow.clip,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 14,
//                       color: Color(0xff000000),
//                     ),
//                   ),
//                 ),
//               ),
//               Card(
//                 margin: EdgeInsets.all(0),
//                 color: Color(0xffffffff),
//                 shadowColor: Color(0xff000000),
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                   side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 widget.item!["chiTietHocPhiTheoMonths"].length < 0 ? "" : "Tháng ${widget.item!["months"]}/${widget.item!["years"]}",
//                                 textAlign: TextAlign.start,
//                                 overflow: TextOverflow.clip,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 14,
//                                   color: Color(0xff45a6c7),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Padding(
//                               padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                               child: Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Text(
//                                   "VND",
//                                   textAlign: TextAlign.start,
//                                   overflow: TextOverflow.clip,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14,
//                                     color: Color(0xff000000),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Divider(
//                         color: Color(0xff808080),
//                         height: 16,
//                         thickness: 0,
//                         indent: 0,
//                         endIndent: 0,
//                       ),
//                       Container(
//                         child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             padding: EdgeInsets.all(0),
//                             shrinkWrap: true,
//                             itemCount:
//                             isEdit ? chiPhi!["chiTietHocPhiTheoMonths"].length : widget.item!["chiTietHocPhiTheoMonths"].length,
//                             physics: ScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               final item = isEdit ? chiPhi!["chiTietHocPhiTheoMonths"][index] as Map : widget.item!["chiTietHocPhiTheoMonths"][index] as Map;
//                               return Padding(
//                                 padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Text(
//                                       chiPhi == null ? "" : item["content"],
//                                       textAlign: TextAlign.start,
//                                       overflow: TextOverflow.clip,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontStyle: FontStyle.normal,
//                                         fontSize: 14,
//                                         color: Color(0xff000000),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Align(
//                                         alignment: Alignment.topRight,
//                                         child: Text(
//                                           chiPhi == null ? "0" :
//                                           _formatter
//                                               .format(item["total"].toString()),
//                                           textAlign: TextAlign.start,
//                                           overflow: TextOverflow.clip,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                             fontSize: 14,
//                                             color: Color(0xff000000),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                       Divider(
//                         color: Color(0xff808080),
//                         height: 16,
//                         thickness: 0,
//                         indent: 0,
//                         endIndent: 0,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(
//                               "Tổng tiền",
//                               textAlign: TextAlign.start,
//                               overflow: TextOverflow.clip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Color(0xff000000),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   _formatter.format(valueSumString),
//                                   textAlign: TextAlign.start,
//                                   overflow: TextOverflow.clip,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14,
//                                     color: Color(0xffff0000),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
//                         child: Text(
//                           "Hạn chót cần thanh toán tháng ${widget.item!["chiTietHocPhiTheoMonths"].length < 0 ? "" : widget.item!["months"] +"/"+ widget.item!["months"]}",
//                           textAlign: TextAlign.center,
//                           overflow: TextOverflow.clip,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontStyle: FontStyle.italic,
//                             fontSize: 11,
//                             color: Color(0xff0e8e07),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: isEdit,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                         flex: 2,
//                         child: Text(
//                           "Thanh toán: ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 14),
//                         )),
//                     Expanded(
//                       flex: 4,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           RadioListTile(
//                             title: Text("Chưa thanh toán"),
//                             value: "0",
//                             groupValue: typeOff,
//                             onChanged: (value) {
//                               setState(() {
//                                 typeOff = value.toString();
//                               });
//                             },
//                           ),
//                           RadioListTile(
//                             title: Text("Đã thanh toán"),
//                             value: "1",
//                             groupValue: typeOff,
//                             onChanged: (value) {
//                               setState(() {
//                                 typeOff = value.toString();
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               ElevatedButton(
//                 onPressed: updateStatusThanhToan,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(isEdit ? 'Cập nhật thanh toán' : 'Thêm mới'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//     );
//   }
//
//   Future<void> navigateToEditPage() async {
//     final route = MaterialPageRoute(
//       builder: (context) => UpdateChiTietKhoanThuHocPhiScreen(
//           item: widget.itemFull, itemLine: widget.item),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       var isLoading = true;
//     });
//     FetchChiTietHocPhiTheoMonth();
//     isLoading = false;
//   }
//
//   Future<void> FetchChiTietHocPhiTheoMonth() async {
//     final response =
//         await HocPhiService.FetchChiTietHocPhiTheoMonth(widget.item!["id"]);
//     if (response != null) {
//       setState(() {
//         double valueSum = 0;
//         if (response["chiTietHocPhiTheoMonths"].length > 0) {
//           for (int i = 0; i < response["chiTietHocPhiTheoMonths"].length; i++) {
//             valueSum =
//                 valueSum + response["chiTietHocPhiTheoMonths"][i]["total"];
//           }
//           valueSumString = valueSum.toString();
//         } else {
//           valueSumString = "0";
//         }
//         valueSumString = valueSum.toString();
//
//         if(isEdit) {
//           chiPhi = response;
//           print(chiPhi);
//           if (chiPhi!["isCompleted"] == false) {
//             typeOff = "0";
//           } else if (chiPhi!["isCompleted"] == true) {
//             typeOff = "1";
//           }
//         }
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
//   Future<void> updateStatusThanhToan() async {
//     final itemUpdate = widget.item;
//     if (itemUpdate == null) {
//       print('You can not call update without todo data');
//       return;
//     }
//     final id = itemUpdate['id'];
//     // final isCompleted = todo['is_completed'];
//     final isSuccess = await HocPhiService.updateStatusThanhToan(id.toString(), typeOff.toString());
//
//     if (isSuccess) {
//       showSuccessMessage(context, message: 'Cập nhật thành công');
//     } else {
//       showErrorMessage(context, message: 'Cập nhật thất bại');
//     }
//   }
//   Map get body {
//     return {
//       "isCompleted": typeOff == "0" ? false : true,
//     };
//   }
// }
