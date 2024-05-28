import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreenTest01 extends StatelessWidget {
  // List<FlutterVizBottomNavigationBarModel> flutterVizBottomNavigationBarItems =
  // [
  //   FlutterVizBottomNavigationBarModel(icon: Icons.home, label: "Trang chủ"),
  //   FlutterVizBottomNavigationBarModel(
  //       icon: Icons.account_circle, label: "Tài khoản")
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: flutterVizBottomNavigationBarItems
      //       .map((FlutterVizBottomNavigationBarModel item) {
      //     return BottomNavigationBarItem(
      //       icon: Icon(item.icon),
      //       label: item.label,
      //     );
      //   }).toList(),
      //   backgroundColor: Color(0xffffffff),
      //   currentIndex: 0,
      //   elevation: 8,
      //   iconSize: 24,
      //   selectedItemColor: Color(0xff0800ff),
      //   unselectedItemColor: Color(0xff9e9e9e),
      //   selectedFontSize: 14,
      //   unselectedFontSize: 14,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: false,
      //   onTap: (value) {},
      // ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ///***If you have exported images you must have to copy those images in assets/images directory.
            // Image(
            //   image: AssetImage("images/backgroud_login.jpg"),
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.cover,
            // ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Lottie.network(
                                    "https://assets8.lottiefiles.com/packages/lf20_8ydmsved.json",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                    repeat: true,
                                    animate: true,
                                  ),
                                  Align(
                                    alignment: Alignment(0.0, 0.3),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset("images/avatar.jpg",
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Trần Thái Bảo",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ImageIcon(
                                    AssetImage("images/user_avatar.png"),
                                    size: 20,
                                    color: Color(0xff0026ff),
                                  ),
                                  Text(
                                    "Bộ phận kho",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff0019ff),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: BoxDecoration(
                      color: Color(0x00ffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child:
                    GridView(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xff5f75e6),
                                  shape: BoxShape.circle,
                                ),

                                child: ImageIcon(
                                  NetworkImage(
                                      "https://cdn3.iconfinder.com/data/icons/real-estate-126/210/949-128.png"),
                                  size: 30,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  "\nNạp tiền điện thoại",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xffe260b7),
                                  shape: BoxShape.circle,
                                ),
                                child: ImageIcon(
                                  NetworkImage(
                                      "https://cdn1.iconfinder.com/data/icons/budicon-chroma-design/24/scissor-128.png"),
                                  size: 30,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  "\nThanh toán hóa đơn",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
