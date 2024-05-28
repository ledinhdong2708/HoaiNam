// import 'dart:math';
//
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
//
// import '../../_services/HocPhi/HocPhiService.dart';
// import '../../models/months.dart';
// import '../../shared/utils/snackbar_helper.dart';
//
// class AddChiTietHocPhiScreen extends StatefulWidget {
//   final Map? item;
//   const AddChiTietHocPhiScreen({Key? key, this.item}) : super(key: key);
//   // const AddChiTietHocPhiScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddChiTietHocPhiScreen> createState() => _AddChiTietHocPhiScreenState();
// }
//
// class _AddChiTietHocPhiScreenState extends State<AddChiTietHocPhiScreen> {
//   bool isEdit = false;
//   String showYear = 'Year';
//   String total = '0';
//   DateTime _selectedYear = DateTime.now();
//   String? selectedValueMonth;
//   final TextEditingController monthEditingController = TextEditingController();
//   selectYear(context) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Select Year"),
//           content: SizedBox(
//             width: 300,
//             height: 300,
//             child: YearPicker(
//               firstDate: DateTime(DateTime.now().year - 10, 1),
//               // lastDate: DateTime.now(),
//               lastDate: DateTime(2025),
//               initialDate: DateTime.now(),
//               selectedDate: _selectedYear,
//               onChanged: (DateTime dateTime) {
//                 print(dateTime.year);
//                 setState(() {
//                   _selectedYear = dateTime;
//                   showYear = "${dateTime.year}";
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   List<Months> listMonths = <Months>[
//     Months(id: 1, name: "Tháng 1"),
//     Months(id: 2, name: "Tháng 2"),
//     Months(id: 3, name: "Tháng 3"),
//     Months(id: 4, name: "Tháng 4"),
//     Months(id: 5, name: "Tháng 5"),
//     Months(id: 6, name: "Tháng 6"),
//     Months(id: 7, name: "Tháng 7"),
//     Months(id: 8, name: "Tháng 8"),
//     Months(id: 9, name: "Tháng 9"),
//     Months(id: 10, name: "Tháng 10"),
//     Months(id: 11, name: "Tháng 11"),
//     Months(id: 12, name: "Tháng 12"),
//   ];
//   List data = [];
//   // List data = [
//   //   {"id": 1, "name": "Tiền điện", "value": 257000000},
//   //   {"id": 2, "name": "Tiền VP", "value": 8957000000}
//   // ];
//   String dropdownValueMonth = "";
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController valueController = TextEditingController();
//   TextEditingController monthController = TextEditingController();
//   final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
//     locale: 'ko',
//     decimalDigits: 0,
//     symbol: '',
//   );
//   @override
//   void initState() {
//     super.initState();
//     final hocsinh = widget.item;
//     total = totalList(data).toString();
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
//           (isEdit ? "Thêm mới" : "Thêm mới"),
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
//                             "id": data.length <= 0 ? 0 : data.last["id"] + 1,
//                             "content": nameController.text,
//                             "months": selectedValueMonth,
//                             "years": showYear,
//                             "createDate": "",
//                             "updateDate": "",
//                             "total": double.parse(
//                                 valueController.text.replaceAll(',', '')),
//                             "hocPhiChiTietId": 0,
//                             "isCompleted": false,
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
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 0.5),
//                         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "${showYear}",
//                               textAlign: TextAlign.center,
//                               overflow: TextOverflow.clip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 14,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             // onTap: () => _selectDate(context),
//                             onTap: () => selectYear(context),
//                             borderRadius: BorderRadius.circular(50),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50.0),
//                               child: Image.asset(
//                                 "images/20.png",
//                                 height: 40,
//                                 width: 40,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       // padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                       // width: MediaQuery.of(context).size.width,
//                       // decoration: BoxDecoration(
//                       //   border: Border.all(width: 1.0),
//                       //   borderRadius:
//                       //       BorderRadius.all(Radius.circular(5.0)),
//                       // ),
//                       child: DropdownMenu<Months>(
//                         width: MediaQuery.of(context).size.width * 0.45,
//                         controller: monthEditingController,
//                         enableFilter: true,
//                         requestFocusOnTap: true,
//                         leadingIcon: const Icon(Icons.search),
//                         label: const Text('Search'),
//                         inputDecorationTheme: const InputDecorationTheme(
//                             filled: true,
//                             contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                             border: OutlineInputBorder(),
//                             fillColor: Colors.transparent),
//                         onSelected: (Months? icon) {
//                           setState(() {
//                             selectedValueMonth = icon!.id.toString();
//                           });
//                         },
//                         dropdownMenuEntries:
//                             listMonths.map<DropdownMenuEntry<Months>>(
//                           (Months icon) {
//                             return DropdownMenuEntry<Months>(
//                               value: icon,
//                               label: icon.name,
//                               // leadingIcon: icon.!id.toString(),
//                             );
//                           },
//                         ).toList(),
//                       ),
//                       // DropdownButtonHideUnderline(
//                       //   child: DropdownButton2<String>(
//                       //     isExpanded: true,
//                       //     hint: Text(
//                       //       isEdit
//                       //           ? (widget.item!['ClassSBN'] == null
//                       //           ? "Select Class"
//                       //           : widget.item!['ClassSBN'].toString())
//                       //           : 'Select Class',
//                       //       style: TextStyle(
//                       //         fontSize: 14,
//                       //         color: Theme.of(context).hintColor,
//                       //       ),
//                       //     ),
//                       //     items: listMonths
//                       //         .map((item) => DropdownMenuItem(
//                       //       value: item.id.toString(),
//                       //       child: Text(
//                       //         item.name,
//                       //         style: const TextStyle(
//                       //           fontSize: 14,
//                       //         ),
//                       //       ),
//                       //     ))
//                       //         .toList(),
//                       //     value: selectedValueMonth,
//                       //     onChanged: (value) {
//                       //       setState(() {
//                       //         selectedValueMonth = value.toString();
//                       //       });
//                       //     },
//                       //     buttonStyleData: const ButtonStyleData(
//                       //       padding: EdgeInsets.symmetric(horizontal: 16),
//                       //       height: 40,
//                       //       width: 200,
//                       //     ),
//                       //     dropdownStyleData: const DropdownStyleData(
//                       //       maxHeight: 200,
//                       //     ),
//                       //     menuItemStyleData: const MenuItemStyleData(
//                       //       height: 40,
//                       //     ),
//                       //     dropdownSearchData: DropdownSearchData(
//                       //       searchController: monthEditingController,
//                       //       searchInnerWidgetHeight: 50,
//                       //       searchInnerWidget: Container(
//                       //         height: 50,
//                       //         padding: const EdgeInsets.only(
//                       //           top: 8,
//                       //           bottom: 4,
//                       //           right: 8,
//                       //           left: 8,
//                       //         ),
//                       //         child: TextFormField(
//                       //           expands: true,
//                       //           maxLines: null,
//                       //           controller: monthEditingController,
//                       //           decoration: InputDecoration(
//                       //             isDense: true,
//                       //             contentPadding:
//                       //             const EdgeInsets.symmetric(
//                       //               horizontal: 10,
//                       //               vertical: 8,
//                       //             ),
//                       //             hintText: 'Search for an item...',
//                       //             hintStyle: const TextStyle(fontSize: 12),
//                       //             border: OutlineInputBorder(
//                       //               borderRadius: BorderRadius.circular(8),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //       searchMatchFn: (item, searchValue) {
//                       //         return item.value
//                       //             .toString()
//                       //             .contains(searchValue);
//                       //       },
//                       //     ),
//                       //     //This to clear the search value when you close the menu
//                       //     onMenuStateChange: (isOpen) {
//                       //       if (!isOpen) {
//                       //         monthEditingController.clear();
//                       //       }
//                       //     },
//                       //   ),
//                       // ),
//                     ),
//                   )
//                 ],
//               ),
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
//                           child: Text(_formatter.format(total)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                   onPressed: data.length > 0 ? updateData : null,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text(
//                           "Thêm mới",
//                           style: TextStyle(
//                               color: Colors.black87,
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 5),
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
//     // print(total);
//     // total = _total as String;
//     return _total;
//   }
//
//   Future<void> updateData() async {
//     final itemUpdate = widget.item;
//     if (itemUpdate == null) {
//       print('You can not call update without todo data');
//       return;
//     }
//     // final id = id.toString();
//     // final isCompleted = todo['is_completed'];
//     final isSuccess =
//         await HocPhiService.updateData(widget.item!["id"].toString(), body);
//
//     Navigator.pop(context);
//
//     if (isSuccess) {
//       showSuccessMessage(context, message: 'Update Success');
//     } else {
//       showErrorMessage(context, message: 'Update Failed');
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
//       "totalMax": widget.item!["totalMax"],
//       "chiTietHocPhis": [
//         {
//           "id": 0,
//           "content": widget.item!["content"],
//           "months": selectedValueMonth,
//           "years": showYear,
//           "createDate": "${showYear}-${selectedValueMonth}-28T02:08:11.311Z",
//           "updateDate": "",
//           "total": total.replaceAll(',', ''),
//           "hocPhiId": 0,
//           "userId": 0,
//           "studentId": 0,
//           "isCompleted": false,
//           "expDate": "${showYear}-${selectedValueMonth}-28T02:08:11.311Z",
//           "chiTietHocPhiTheoMonths": data
//         }
//       ]
//     };
//   }
// }
