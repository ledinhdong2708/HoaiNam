import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../shared/UrlAPI/API_General.dart';

class SoBeNgoanCardScreen extends StatelessWidget {
  final int? index;
  final Map? item;
  final Function(Map) navigationEdit;
  const SoBeNgoanCardScreen(
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
          navigationEdit(item!);
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(60, 0, 0, 0),
              padding: const EdgeInsets.all(0),
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
                      item!["students"][0]["nameStudent"] == null
                          ? ''
                          : item!["students"][0]["nameStudent"].toString(),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 12),
                      child: Text(
                        item!["createDate"] == null
                            ? 'Ngày ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} (Giờ ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second})'
                            : 'Ngày ${DateTime.parse(item!["createDate"]).day}/${DateTime.parse(item!["createDate"]).month}/${DateTime.parse(item!["createDate"]).year}',
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
                              item!["students"][0]["class1"] == null
                                  ? ""
                                  : "${item!["students"][0]["class1"]} (${item!["students"][0]["year1"]})",
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
              child: (item!["students"].length > 0 &&
                      item!["students"][0]['imagePatch'] != null)
                  ? Image.network(
                      "${SERVER_IP}${item!["students"][0]['imagePatch']}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "images/41.png",
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
