import 'package:appflutter_one/_components/_services/HoatDong/HoatDongService.dart';
import 'package:appflutter_one/_components/_services/NhatKy/NhatKyService.dart';
import 'package:appflutter_one/_components/models/student_model.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/BangTin/AddBangTinScreen.dart';
import 'package:appflutter_one/_components/modules/BangTin/BinhLuanScreen.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:video_player/video_player.dart';

import '../../_services/HocSinh/HocSinhService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class BangTinScreen extends StatefulWidget {
  String img;
  String text;
  BangTinScreen(this.img, this.text);
  // const BangTinScreen({Key? key}) : super(key: key);

  @override
  State<BangTinScreen> createState() => _BangTinScreenState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _BangTinScreenState extends State<BangTinScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  List items = [];
  List imageSlide = [];
  List itemImageAPI = [];
  List itemVideoAPI = [];
  // var itemsStudent;
  // late VideoPlayerController _controller;
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
    // _controller = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    //   ..initialize().then((_) {
    //     // _controller.play();
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
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
          InkWell(
            onTap: navigateToAddPage,
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.add,
                color: Color(0xFF674AEF),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
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
                  width: 205,
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
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      constraints:
                                          BoxConstraints.expand(height: 50),
                                      child: TabBar(tabs: [
                                        Tab(icon: Icon(Icons.image)),
                                        Tab(icon: Icon(Icons.video_library)),
                                      ]),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          // Container(
                                          //   child: CarouselSlider.builder(
                                          //     itemBuilder:
                                          //         (context, indexCarouselSlider, realIndex) {
                                          //       return InstaImageViewer(
                                          //         child: Container(
                                          //           // margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                                          //           decoration: BoxDecoration(
                                          //             image: DecorationImage(
                                          //               image: NetworkImage(
                                          //                   "${SERVER_IP}/${item["imgString"][indexCarouselSlider]}"),
                                          //               fit: BoxFit.contain,
                                          //             ),
                                          //             color: Colors.transparent,
                                          //             // borderRadius: BorderRadius.circular(32.0),
                                          //           ),
                                          //         ),
                                          //       );
                                          //     },
                                          //     options: CarouselOptions(
                                          //         viewportFraction: 1,
                                          //         autoPlayAnimationDuration:
                                          //             const Duration(
                                          //                 milliseconds: 2000),
                                          //         // autoPlay: true,
                                          //         enlargeCenterPage: true,
                                          //         height: MediaQuery.of(context)
                                          //             .size
                                          //             .height),
                                          //     itemCount:  lengthItemsJPG('.jpg', items[index]["imgString"]).length,
                                          //   ),
                                          // ),
                                          CarouselSliderWidget(items[index]),
                                          // Container(
                                          //   child: CarouselSlider.builder(
                                          //     itemCount: lengthItemsVideo('jpg', items[index]["imgString"]).length,
                                          //     itemBuilder: (context, indexCarouselSlider, realIndex) {
                                          //       // print(items[index]["imgString"][indexCarouselSlider].toString().contains(".mp4"));
                                          //       print('${SERVER_IP}/${item["imgString"][indexCarouselSlider]}');
                                          //       return VideoWidget(true, '${SERVER_IP}/${item["imgString"][indexCarouselSlider]}');
                                          //       //   Stack(
                                          //       //   alignment: Alignment.center,
                                          //       //   children: [
                                          //       //   VideoWidget(true,'${SERVER_IP}/${item["imgString"][index]}')
                                          //       //     // AspectRatio(
                                          //       //     //   aspectRatio:
                                          //       //     //   _controller.value.aspectRatio,
                                          //       //     //   child: VideoPlayer(_controller),
                                          //       //     // ),
                                          //       //     // InkWell(
                                          //       //     //   onTap: () {
                                          //       //     //     setState(() {
                                          //       //     //       _controller.value.isPlaying
                                          //       //     //           ? _controller.pause()
                                          //       //     //           : _controller.play();
                                          //       //     //     });
                                          //       //     //   },
                                          //       //     //   child: Center(
                                          //       //     //     child: _controller.value.isPlaying == true
                                          //       //     //         ? Visibility(
                                          //       //     //       visible: false,
                                          //       //     //       child: CircleAvatar(
                                          //       //     //         radius: 30,
                                          //       //     //         backgroundColor: Colors.white60,
                                          //       //     //         child: Icon(
                                          //       //     //             _controller.value
                                          //       //     //                 .isPlaying ==
                                          //       //     //                 true
                                          //       //     //                 ? Icons.pause
                                          //       //     //                 : Icons.play_arrow,
                                          //       //     //             size: 26,
                                          //       //     //             color: Colors.blue),
                                          //       //     //       ),
                                          //       //     //     )
                                          //       //     //         : Visibility(
                                          //       //     //       visible: true,
                                          //       //     //       child: CircleAvatar(
                                          //       //     //         radius: 30,
                                          //       //     //         backgroundColor: Colors.white60,
                                          //       //     //         child: Icon(
                                          //       //     //             _controller.value
                                          //       //     //                 .isPlaying ==
                                          //       //     //                 true
                                          //       //     //                 ? Icons.pause
                                          //       //     //                 : Icons.play_arrow,
                                          //       //     //             size: 26,
                                          //       //     //             color: Colors.blue),
                                          //       //     //       ),
                                          //       //     //     ),
                                          //       //     //   ),
                                          //       //     // ),
                                          //       //   ],
                                          //       // );
                                          //     },
                                          //     options: CarouselOptions(
                                          //         viewportFraction: 1,
                                          //         autoPlayAnimationDuration:
                                          //             const Duration(
                                          //                 milliseconds: 2000),
                                          //         // autoPlay: true,
                                          //         enlargeCenterPage: true,
                                          //         height: MediaQuery.of(context)
                                          //             .size
                                          //             .height),
                                          //   ),
                                          // ),
                                          CarouselSliderWidgetVideo(
                                              items[index])
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )

                              // Container(
                              //   child: CarouselSlider.builder(
                              //     itemBuilder: (context, index, realIndex) {
                              //       return
                              //         item["imgString"][index].toString().contains('.')
                              //         ? Center(
                              //           child: _controller.value.isInitialized
                              //               ? AspectRatio(
                              //             aspectRatio: _controller.value.aspectRatio,
                              //             child: VideoPlayer(_controller),
                              //           )
                              //               : Container(),
                              //         )
                              //         : Container(
                              //         // margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                              //         decoration: BoxDecoration(
                              //                 image: DecorationImage(
                              //                   image: NetworkImage(
                              //                       "${SERVER_IP}/${item["imgString"][index]}"),
                              //                   fit: BoxFit.cover,
                              //                 ),
                              //               color: Colors.transparent,
                              //               // borderRadius: BorderRadius.circular(32.0),
                              //             ),
                              //       );
                              //     },
                              //     options: CarouselOptions(
                              //         viewportFraction: 1,
                              //         autoPlayAnimationDuration:
                              //             const Duration(milliseconds: 2000),
                              //         // autoPlay: true,
                              //         enlargeCenterPage: true,
                              //         height: MediaQuery.of(context).size.height),
                              //     itemCount: item["imgString"].length,
                              //   ),
                              // ),
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

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddBangTinScreen(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchToDo();
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
    final response = await NhatKyService.FetchNhatKy();
    if (response != null) {
      setState(() {
        items = response;
        // for (int i = 0; i < response.length; i++) {
        //   var listTemp = response[i]["imgString"];
        //   for(int j = 0 ; j < listTemp.length;j++) {
        //     if (listTemp.toString().contains('.jpg')) {
        //       itemImageAPI.add(listTemp[i]);
        //     } else {
        //       itemVideoAPI.add(listTemp[i]);
        //     }
        //   }
        //   // if (response[i]["imgString"].toString().contains('.jpg')) {
        //   //   itemImageAPI.add(response[i]["imgString"]);
        //   // } else {
        //   //   itemVideoAPI.add(response[i]["imgString"]);
        //   // }
        // }
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
        showErrorMessage(context,
            message: 'Giáo viên không được phép like bài viết này ');
      }
    } else {
      final isSuccessSubmitData = await NhatKyService.deleteById(
          item["tableLikes"][0]["id"].toString());

      if (isSuccessSubmitData) {
        // Navigator.pop(context);
        showSuccessMessage(context,
            message: 'Bạn đã bỏ like bài viết thành công');
      } else {
        showErrorMessage(context,
            message: 'Giáo viên không được phép like bài viết này ');
      }
    }
    FetchToDo();
  }

  List lengthItemsJPG(String types, List data) {
    List a = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].toString().contains(types)) {
        a.add(data[i]);
      }
    }
    return a;
  }

  List lengthItemsVideo(String types, List data) {
    List a = [];
    for (int i = 0; i < data.length; i++) {
      if (!data[i].toString().contains(types)) {
        print(data[i]);
        a.add(data[i]);
      }
    }
    return a;
  }

  // Future<void> FetchIDStudent(id) async {
  //   final response =
  //   await HocSinhService.FetchByIDStudent(id);
  //   if (response != null) {
  //     setState(() {
  //       itemsStudent = response;
  //     });
  //   } else {
  //     showErrorMessage(context, message: 'Something went wrong');
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

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
                          decoration: const BoxDecoration(
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

class CarouselSliderWidget extends StatefulWidget {
  final Map? data;
  CarouselSliderWidget(this.data);
  // const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  List data = [];
  void initState() {
    super.initState();
    data = lengthItemsJPG('.jpg', widget.data!["imgString"]);
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Container(
            child: CarouselSlider.builder(
              itemBuilder: (context, indexCarouselSlider, realIndex) {
                return InstaImageViewer(
                  child: Container(
                    // margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${SERVER_IP}${widget.data!["imgString"][indexCarouselSlider]}"),
                        fit: BoxFit.contain,
                      ),
                      color: Colors.transparent,
                      // borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                  // autoPlay: true,
                  enlargeCenterPage: true,
                  height: MediaQuery.of(context).size.height),
              itemCount:
                  lengthItemsJPG('.jpg', widget.data!["imgString"]).length,
            ),
          )
        : Container();
  }

  List lengthItemsJPG(String types, data) {
    List a = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].toString().contains(types)) {
        a.add(data[i]);
      }
    }
    return a;
  }
}

class CarouselSliderWidgetVideo extends StatefulWidget {
  final Map? data;
  CarouselSliderWidgetVideo(this.data);
  // const CarouselSliderWidgetVideo({Key? key}) : super(key: key);

  @override
  State<CarouselSliderWidgetVideo> createState() =>
      _CarouselSliderWidgetVideoState();
}

class _CarouselSliderWidgetVideoState extends State<CarouselSliderWidgetVideo> {
  List data = [];
  void initState() {
    super.initState();
    data = lengthItemsVideo('jpg', widget.data!["imgString"]);
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Container(
            child: CarouselSlider.builder(
              itemBuilder: (context, indexCarouselSlider, realIndex) {
                return VideoWidget(
                    true, '${SERVER_IP}${data[indexCarouselSlider]}');
                //   Stack(
                //   alignment: Alignment.center,
                //   children: [
                //   VideoWidget(true,'${SERVER_IP}/${item["imgString"][index]}')
                //     // AspectRatio(
                //     //   aspectRatio:
                //     //   _controller.value.aspectRatio,
                //     //   child: VideoPlayer(_controller),
                //     // ),
                //     // InkWell(
                //     //   onTap: () {
                //     //     setState(() {
                //     //       _controller.value.isPlaying
                //     //           ? _controller.pause()
                //     //           : _controller.play();
                //     //     });
                //     //   },
                //     //   child: Center(
                //     //     child: _controller.value.isPlaying == true
                //     //         ? Visibility(
                //     //       visible: false,
                //     //       child: CircleAvatar(
                //     //         radius: 30,
                //     //         backgroundColor: Colors.white60,
                //     //         child: Icon(
                //     //             _controller.value
                //     //                 .isPlaying ==
                //     //                 true
                //     //                 ? Icons.pause
                //     //                 : Icons.play_arrow,
                //     //             size: 26,
                //     //             color: Colors.blue),
                //     //       ),
                //     //     )
                //     //         : Visibility(
                //     //       visible: true,
                //     //       child: CircleAvatar(
                //     //         radius: 30,
                //     //         backgroundColor: Colors.white60,
                //     //         child: Icon(
                //     //             _controller.value
                //     //                 .isPlaying ==
                //     //                 true
                //     //                 ? Icons.pause
                //     //                 : Icons.play_arrow,
                //     //             size: 26,
                //     //             color: Colors.blue),
                //     //       ),
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // );
              },
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                  // autoPlay: true,
                  enlargeCenterPage: true,
                  height: MediaQuery.of(context).size.height),
              itemCount: data.length,
            ),
          )
        : Container();
  }

  List lengthItemsVideo(String types, List data) {
    List a = [];
    for (int i = 0; i < data.length; i++) {
      if (!data[i].toString().contains(types)) {
        a.add(data[i]);
      }
    }
    print(a);
    return a;
  }
}

class VideoWidget extends StatefulWidget {
  final bool play;
  final String url;
  VideoWidget(this.play, this.url);
  // const VideoWidget({Key key, @required this.url, @required this.play})
  //     : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  } // This closing tag was missing

  @override
  void dispose() {
    _controller.dispose();
    //    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Center(
            child: _controller.value.isPlaying == true
                ? Visibility(
                    visible: false,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white60,
                      child: Icon(
                          _controller.value.isPlaying == true
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 26,
                          color: Colors.blue),
                    ),
                  )
                : Visibility(
                    visible: true,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white60,
                      child: Icon(
                          _controller.value.isPlaying == true
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 26,
                          color: Colors.blue),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
