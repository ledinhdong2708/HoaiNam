import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/shared/UrlAPI/API_General.dart';
import 'package:flutter/material.dart';

import '../../_services/NhatKy/NhatKyService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../shared/utils/snackbar_helper.dart';

class BinhLuanScreen extends StatefulWidget {
  final Map? item;
  const BinhLuanScreen({Key? key, this.item}) : super(key: key);

  @override
  State<BinhLuanScreen> createState() => _BinhLuanScreenState();
}

class _BinhLuanScreenState extends State<BinhLuanScreen> {
  NotificationService _notificationService = NotificationService();
  bool isLoading = false;
  List items = [];
  final TextEditingController contentController = TextEditingController();
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
          "Bình luận",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemCount: items.length,
                    shrinkWrap: false,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = items[index] as Map;
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                maxRadius: 16,
                                child: items[index]["student"]["imagePatch"] ==
                                        null
                                    ? Image.asset('images/avatar.jpg')
                                    : Image.network(
                                        "${SERVER_IP}${items[index]["student"]["imagePatch"]}")),
                            SizedBox(
                              width: 16.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Hexcolor('#E9F1FE'),
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index]["student"]
                                              ["nameStudent"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          items[index]["content"],
                                          style: TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${DateTime.parse(items[index]["createDate"]).day}/${DateTime.parse(items[index]["createDate"]).month}/${DateTime.parse(items[index]["createDate"]).year} - ${DateTime.parse(items[index]["createDate"]).hour}:${DateTime.parse(items[index]["createDate"]).minute}",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black26,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                height: 61,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.grey)
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.face,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {}),
                            Expanded(
                              child: TextField(
                                controller: contentController,
                                decoration: InputDecoration(
                                    hintText: "Nhập...",
                                    hintStyle:
                                        TextStyle(color: Colors.blueAccent),
                                    border: InputBorder.none),
                              ),
                            ),
                            // IconButton(
                            //   icon: Icon(Icons.photo_camera,
                            //       color: Colors.blueAccent),
                            //   onPressed: () {},
                            // ),
                            // IconButton(
                            //   icon: Icon(Icons.attach_file,
                            //       color: Colors.blueAccent),
                            //   onPressed: () {},
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent, shape: BoxShape.circle),
                      child: InkWell(
                        onTap: () {
                          submitBinhLuan(widget.item);
                        },
                        child: Icon(
                          Icons.send_sharp,
                          color: Colors.white,
                        ),
                        onLongPress: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> FetchToDo() async {
    final response = await NhatKyService.FetchBinhLuan(widget.item!["id"]);
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

  Future<void> submitBinhLuan(item) async {
    final body = {
      "id": 0,
      "content": contentController.text,
      "createDate": "2024-01-13T04:36:21.077Z",
      "status": item["status"],
      "nhatKyId": item["id"],
      "userId": item["userId"],
      // "studentId": item["studentId"],
      "appID": item["appID"],
    };
    if (contentController.text != null || contentController != "") {
      final isSuccessSubmitData = await NhatKyService.submitComent(body);

      // if (isSuccessSubmitData) {
      //   // Navigator.pop(context);
      //   showSuccessMessage(context, message: 'Bạn đã like bài viết thành công');
      // } else {
      //   showErrorMessage(context, message: 'Bạn đã like bài viết thất bại');
      // }
    }
    contentController.text = "";
    FetchToDo();
  }
}
