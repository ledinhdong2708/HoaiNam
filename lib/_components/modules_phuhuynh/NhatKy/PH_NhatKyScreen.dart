import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../_services/NhatKy/NhatKyService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../modules/BangTin/BinhLuanScreen.dart';
import '../../shared/UrlAPI/API_General.dart';
import '../../shared/utils/snackbar_helper.dart';

class PH_NhatKyScreen extends StatefulWidget {
  String img;
  String text;
  PH_NhatKyScreen(this.img, this.text);
  // const PH_NhatKyScreen({Key? key}) : super(key: key);

  @override
  State<PH_NhatKyScreen> createState() => _PH_NhatKyScreenState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _PH_NhatKyScreenState extends State<PH_NhatKyScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  List items = [];
  List imageSlide = [];
  CarouselController buttonCarouselController = CarouselController();
  void initState() {
    super.initState();
    FetchToDo();

    _notificationService.requestNotificationPermission();
    _notificationService.forgroundMessage();
    _notificationService.firebaseInit(context);
    _notificationService.setupInteractMessage(context);
    _notificationService.isTokenRefresh();
    _notificationService.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              color: Color(0xFF674AEF),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0x1f000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Color(0x4d9e9e9e), width: 1),
          ),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              itemCount: items.length,
              shrinkWrap: false,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return Container(
                  // height: 450,
                  margin: EdgeInsets.only(bottom: 20.0),
                  width: 105,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    color: Color(0xffffffff),
                    shadowColor: Color(0xff000000),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0x1f000000),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: item["avatarPatch"] == null
                                      ? Image.asset("images/avatar.jpg",
                                          fit: BoxFit.contain)
                                      : Image.network(
                                          "${SERVER_IP}${item["avatarPatch"]}",
                                          fit: BoxFit.contain),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment(-1.0, 0.8),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    padding: EdgeInsets.all(0),
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0x00ffffff),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          items[index]["nameStudent"] ?? "",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Text(
                                            '${DateTime.parse(item!["createDate"]).day}/${DateTime.parse(item!["createDate"]).month}/${DateTime.parse(item!["createDate"]).year}',
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10,
                                              color: Color(0xffc3c3c3),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              items[index]["content"],
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        if (items[index]["imgString"] != null &&
                            items[index]["imgString"].isNotEmpty)
                          Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Color(0x1f000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                            ),
                            // items[index]["imgString"]
                            child: Container(
                              child: CarouselSlider.builder(
                                itemBuilder: (context, index, realIndex) {
                                  return Container(
                                    // margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${SERVER_IP}${item["imgString"][index]}"),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.transparent,
                                      // borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 2000),
                                    // autoPlay: true,
                                    enlargeCenterPage: true,
                                    height: MediaQuery.of(context).size.height),
                                itemCount: item["imgString"].length,
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    submitLike(item);
                                  },
                                  // color: Color(0xffffffff),
                                  // elevation: 0,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.only(
                                  //       bottomLeft: Radius.circular(15.0)),
                                  // ),
                                  // padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Thích",
                                    style: TextStyle(
                                      color: item["tableLikes"].length > 0
                                          ? Colors.red
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  // textColor: Colors.black,
                                  // height: 40,
                                  // minWidth: 400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Color(0x1fffffff),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.zero,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    navigateToBinhLuanPage(item);
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  // color: Color(0xffffffff),
                                  // elevation: 0,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.only(
                                  //       bottomRight: Radius.circular(15.0)),
                                  // ),
                                  // padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Bình luận",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  // textColor: Colors.black,
                                  // height: 40,
                                  // minWidth: 400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ]),
    );
  }

  Future<void> navigateToBinhLuanPage(item) async {
    final route = MaterialPageRoute(
      builder: (context) => BinhLuanScreen(item: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchToDo();
  }

  Future<void> FetchToDo() async {
    final response = await NhatKyService.PH_FetchNhatKy();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitLike(item) async {
    final body = {
      "id": 0,
      "content": item["content"],
      "createDate": "2024-01-13T04:36:21.077Z",
      "status": item["status"],
      "nhatKyId": item["id"],
      "userId": item["userId"],
      "studentId": item["studentId"],
      "appID": item["appID"],
    };
    if (item["tableLikes"].length <= 0) {
      final isSuccessSubmitData = await NhatKyService.submitLike(body);

      if (isSuccessSubmitData) {
        // Navigator.pop(context);
        showSuccessMessage(context, message: 'Bạn đã like bài viết thành công');
      } else {
        showErrorMessage(context, message: 'Bạn đã like bài viết thất bại');
      }
    } else {
      final isSuccessSubmitData = await NhatKyService.deleteById(
          item["tableLikes"][0]["id"].toString());

      if (isSuccessSubmitData) {
        // Navigator.pop(context);
        showSuccessMessage(context,
            message: 'Bạn đã bỏ like bài viết thành công');
      } else {
        showErrorMessage(context, message: 'Bạn đã bỏ like bài viết thất bại');
      }
    }
    FetchToDo();
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
