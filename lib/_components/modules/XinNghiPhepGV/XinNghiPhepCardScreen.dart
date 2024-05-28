import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class XinNghiPhepGVCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final DateTime selectedDate;
  final Function(Map) navigationEdit;
  const XinNghiPhepGVCardScreen(
      {Key? key,
      required this.index,
      required this.item,
      required this.selectedDate,
      required this.navigationEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: InkWell(
        onTap: () {
          navigationEdit(item);
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item["user"]["firstName"].toString(),
                      // item[0]["student"][0]["nameStudent"]!.toString(),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 12),
                      child: Text(
                        item["user"]["email"]!.toString(),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xffd4d4d4),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xffd4d4d4),
                          size: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              item["user"]["phone"]!.toString(),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xffd4d4d4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: item["user"]!['avatar'] != null
                  ? Image.network(
                      "${SERVER_IP}${item["user"]!['avatar']}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "images/36.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            )
          ],
        ),
        // Card(
        //   margin: EdgeInsets.all(4),
        //   color: Color(0xffffffff),
        //   shadowColor: Color(0xff000000),
        //   elevation: 4,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //   ),
        //   child: ListTile(
        //     // shape: RoundedRectangleBorder( //<-- SEE HERE
        //     //   side: BorderSide(width: 2),
        //     //   borderRadius: BorderRadius.circular(20),
        //     // ),
        //       leading: CircleAvatar(
        //         backgroundColor: const Color(0xff6ae792),
        //         child: Text(
        //           '1',
        //           style: TextStyle(color: Colors.black),
        //         ),
        //       ),
        //       title: Text(item["class"]),
        //       subtitle: Text(
        //           '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
        //       trailing: Icon(Icons.navigate_next_rounded)),
        // ),
      ),
    );
  }
}
