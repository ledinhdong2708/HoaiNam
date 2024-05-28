import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../shared/UrlAPI/API_General.dart';

class MaterBieuDoCardScreen extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigationEdit;
  const MaterBieuDoCardScreen(
      {Key? key,
      required this.index,
      required this.item,
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
                      item["nameStudent"]!,
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
                        item["gV1"]!.toString(),
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
                              "${item["class1"]} (${item["year1"]})",
                              // 'Ngày ${DateTime.parse(item!["createDate"]).day}/${DateTime.parse(item!["createDate"]).month}/${DateTime.parse(item!["createDate"]).year} (Giờ ${DateTime.parse(item!["createDate"]).hour}:${DateTime.parse(item!["createDate"]).minute}:${DateTime.parse(item!["createDate"]).second})',
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
              child: item!['imagePatch'] != null
                  ? Image.network(
                      "${SERVER_IP}/${item!['imagePatch']}",
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
      ),
    );
  }
}
