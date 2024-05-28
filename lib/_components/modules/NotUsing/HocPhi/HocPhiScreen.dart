// import 'package:appflutter_one/_components/_services/HocPhi/HocPhiService.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/AddChiTietHocPhiScreen.dart';
// import 'package:appflutter_one/_components/modules/HocPhi/ChiTietHocPhiScreen.dart';
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:flutter/material.dart';
//
// import '../../shared/utils/snackbar_helper.dart';
// import 'EditHocPhiScreen.dart';
//
// class HocPhiScreen extends StatefulWidget {
//   final Map? item;
//   const HocPhiScreen({Key? key, this.item}) : super(key: key);
//
//   @override
//   State<HocPhiScreen> createState() => _HocPhiScreenState();
// }
//
// class _HocPhiScreenState extends State<HocPhiScreen> {
//   bool isEdit = false;
//   bool isLoading = false;
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
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           (isEdit
//               ? (widget.item!["chiTietHocPhis"].length > 0
//                   ? widget.item!["nameStudent"].toString()
//                   : "Cập nhật")
//               : "Thêm mới"),
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
//           ),
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
//       body: Container(
//         margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//         padding: EdgeInsets.all(0),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           color: Color(0x00000000),
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.zero,
//         ),
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                 padding: EdgeInsets.all(0),
//                 width: MediaQuery.of(context).size.width,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: Color(0x00000000),
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.zero,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: Card(
//                         margin: EdgeInsets.all(4),
//                         color: Color(0xffffffff),
//                         shadowColor: Color(0xff000000),
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4.0),
//                           side: BorderSide(color: Color(0x4d0cff00), width: 2),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(
//                               "Tổng đã đóng",
//                               textAlign: TextAlign.start,
//                               overflow: TextOverflow.clip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Color(0xff000000),
//                               ),
//                             ),
//                             Text(
//                               _formatter.format(
//                                       widget.item!["totalMax"].toString()) +
//                                   " VNĐ",
//                               // "${widget.item!["totalMax"]} vnđ",
//                               textAlign: TextAlign.start,
//                               overflow: TextOverflow.clip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 12,
//                                 color: Color(0xff00ff15),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                       width: 10,
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Card(
//                         margin: EdgeInsets.all(4),
//                         color: Color(0xffffffff),
//                         shadowColor: Color(0xff000000),
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4.0),
//                           side: BorderSide(color: Color(0xffff0000), width: 1),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Text(
//                               "Còn phải đóng",
//                               textAlign: TextAlign.start,
//                               overflow: TextOverflow.clip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Color(0xff000000),
//                               ),
//                             ),
//                             Text(
//                               _formatter.format(
//                                       widget.item!["totalMin"].toString()) +
//                                   " VNĐ",
//                               textAlign: TextAlign.start,
//                               overflow: TextOverflow.clip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 12,
//                                 color: Color(0xffff0000),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Danh sách các khoản thu",
//                     textAlign: TextAlign.left,
//                     overflow: TextOverflow.clip,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 12,
//                       color: Color(0xff000000),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   padding: EdgeInsets.all(0),
//                   shrinkWrap: false,
//                   itemCount: widget.item!["chiTietHocPhis"].length,
//                   physics: ScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final item = widget.item!["chiTietHocPhis"][index] as Map;
//                     return Container(
//                       margin: EdgeInsets.all(0),
//                       padding: EdgeInsets.all(0),
//                       width: MediaQuery.of(context).size.width,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         color: Color(0xffffffff),
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.zero,
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ChiTietHocPhiScreen(
//                                       item,
//                                       widget.item,
//                                       widget.item!["chiTietHocPhis"][index]
//                                               ["expDate"]
//                                           .toString(),
//                                       widget.item!["chiTietHocPhis"][index]
//                                               ["total"]
//                                           .toString(),
//                                       widget.item!["chiTietHocPhis"][index]
//                                               ["isCompleted"]
//                                           .toString())));
//                         },
//                         child: Card(
//                           margin: EdgeInsets.all(4),
//                           color: widget.item!["chiTietHocPhis"][index]
//                                   ["isCompleted"]
//                               ? Colors.green
//                               : ((DateTime.parse(widget.item!["chiTietHocPhis"]
//                                               [index]["expDate"])
//                                           .compareTo(DateTime.now())) >
//                                       0
//                                   ? Colors.white
//                                   : Color(0xa8fd0000)),
//                           shadowColor: Color(0xff000000),
//                           elevation: 1,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             side: BorderSide(
//                                 color: widget.item!["chiTietHocPhis"][index]
//                                         ["isCompleted"]
//                                     ? Colors.green
//                                     : ((DateTime.parse(widget
//                                                         .item!["chiTietHocPhis"]
//                                                     [index]["expDate"])
//                                                 .compareTo(DateTime.now())) >
//                                             0
//                                         ? Colors.white
//                                         : Color(0xa8fd0000)),
//                                 width: 1),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Expanded(
//                                 flex: 8,
//                                 child: Container(
//                                   margin: EdgeInsets.all(0),
//                                   padding: EdgeInsets.all(0),
//                                   width: 200,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     color: Color(0x00ffffff),
//                                     shape: BoxShape.rectangle,
//                                     borderRadius: BorderRadius.zero,
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             margin: EdgeInsets.all(0),
//                                             padding: EdgeInsets.all(0),
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             height: 35,
//                                             decoration: BoxDecoration(
//                                               color: Color(0x00ffffff),
//                                               shape: BoxShape.rectangle,
//                                               borderRadius: BorderRadius.zero,
//                                             ),
//                                             child: Text(
//                                               "Tháng ${widget.item!["chiTietHocPhis"][index]["months"]}/${widget.item!["chiTietHocPhis"][index]["years"]}",
//                                               textAlign: TextAlign.left,
//                                               overflow: TextOverflow.clip,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontStyle: FontStyle.normal,
//                                                 fontSize: 14,
//                                                 color: widget.item!["chiTietHocPhis"][index]
//                                                 ["isCompleted"]
//                                                     ? Colors.white
//                                                     : ((DateTime.parse(widget.item!["chiTietHocPhis"]
//                                                 [index]["expDate"])
//                                                     .compareTo(DateTime.now())) >
//                                                     0
//                                                     ? Colors.red
//                                                     : Colors.white),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 1,
//                                           child: Align(
//                                             alignment: Alignment.topCenter,
//                                             child: Container(
//                                               margin: EdgeInsets.all(0),
//                                               padding: EdgeInsets.all(0),
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               height: 20,
//                                               decoration: BoxDecoration(
//                                                 color: Color(0x00ffffff),
//                                                 shape: BoxShape.rectangle,
//                                                 borderRadius: BorderRadius.zero,
//                                               ),
//                                               child: Text(
//                                                 "Hạn: ${DateTime.parse(widget.item!["chiTietHocPhis"][index]["expDate"]).day.toString()}/"
//                                                 "${DateTime.parse(widget.item!["chiTietHocPhis"][index]["expDate"]).month.toString()}/"
//                                                 "${DateTime.parse(widget.item!["chiTietHocPhis"][index]["expDate"]).year.toString()}",
//                                                 textAlign: TextAlign.start,
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w500,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 12,
//                                                   color: widget.item!["chiTietHocPhis"][index]
//                                                   ["isCompleted"]
//                                                       ? Colors.white
//                                                       : ((DateTime.parse(widget.item!["chiTietHocPhis"]
//                                                   [index]["expDate"])
//                                                       .compareTo(DateTime.now())) >
//                                                       0
//                                                       ? Colors.red
//                                                       : Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 1,
//                                           child: Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Container(
//                                               alignment: Alignment.centerRight,
//                                               margin: EdgeInsets.all(0),
//                                               padding: EdgeInsets.all(0),
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               height: 20,
//                                               decoration: BoxDecoration(
//                                                 color: Color(0x00ffffff),
//                                                 shape: BoxShape.rectangle,
//                                                 borderRadius: BorderRadius.zero,
//                                               ),
//                                               child: Text(
//                                                 _formatter.format(widget
//                                                     .item!["chiTietHocPhis"]
//                                                         [index]["total"]
//                                                     .toString()),
//                                                 textAlign: TextAlign.right,
//                                                 overflow: TextOverflow.clip,
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 14,
//                                                   color:
//                                                     widget.item!["chiTietHocPhis"][index]
//                                                 ["isCompleted"]
//                                                 ? Colors.white
//                                                         : ((DateTime.parse(widget.item!["chiTietHocPhis"]
//                                                 [index]["expDate"])
//                                                     .compareTo(DateTime.now())) >
//                                                   0
//                                                   ? Colors.red
//                                                   : Colors.white)
//                                                   ,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   margin: EdgeInsets.all(0),
//                                   padding: EdgeInsets.all(0),
//                                   width: 200,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     color: Color(0x00ffffff),
//                                     shape: BoxShape.rectangle,
//                                     borderRadius: BorderRadius.zero,
//                                   ),
//                                   child: Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: Color(0xff0026ff),
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> navigateToEditPage() async {
//     final route = MaterialPageRoute(
//       builder: (context) => EditHocPhiScreen(item: widget.item),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       isLoading = true;
//     });
//     FetchHocPhibyId();
//   }
//
//   Future<void> navigateToAddPage() async {
//     final route = MaterialPageRoute(
//       builder: (context) => AddChiTietHocPhiScreen(item: widget.item),
//     );
//     await Navigator.push(context, route);
//     setState(() {
//       isLoading = true;
//     });
//     FetchHocPhibyId();
//   }
//
//   Future<void> FetchHocPhibyId() async {
//     final response = await HocPhiService.FetchHocPhibyId(widget.item!["id"]);
//     if (response != null) {
//       setState(() {
//         widget.item!["chiTietHocPhis"] = response["data"]["chiTietHocPhis"];
//       });
//     } else {
//       showErrorMessage(context, message: 'Something went wrong');
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }
// }
