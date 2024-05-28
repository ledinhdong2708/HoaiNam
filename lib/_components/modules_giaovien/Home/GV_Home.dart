///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:convert';
import 'dart:developer';

import 'package:appflutter_one/_components/_services/HocSinh/HocSinhService.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/BangTin/BangTinScreen.dart';
import 'package:appflutter_one/_components/modules/Chat/home_page.dart';
import 'package:appflutter_one/_components/modules/Class/DSClassScreen.dart';
import 'package:appflutter_one/_components/modules/CourseScreen/CourseScreen.dart';
import 'package:appflutter_one/_components/modules/DSHocSinh/DSHocSinhScreen.dart';
import 'package:appflutter_one/_components/modules/DanThuoc/DSDanThuocScreen.dart';
import 'package:appflutter_one/_components/modules/DiemDanh/DSDiemDanhScreen.dart';
import 'package:appflutter_one/_components/modules/DinhDuong/DinhDuongScreen.dart';
import 'package:appflutter_one/_components/modules/HocPhi/DSHocPhiScreen.dart';
import 'package:appflutter_one/_components/modules/KhoaHoc/DSKhoaHocScreen.dart';
import 'package:appflutter_one/_components/modules/MaterBieuDo/DSMaterBieuDoScreen.dart';
import 'package:appflutter_one/_components/modules/PhanCongGiaoVien/ChiTietPhanCongGiaoVienScreen.dart';
import 'package:appflutter_one/_components/modules/Profile/ProfileScreen.dart';
import 'package:appflutter_one/_components/modules/SoBeNgoan/SoBeNgoanScreen.dart';
import 'package:appflutter_one/_components/modules/ThoiKhoaBieuScreen/ThoiKhoaBieuScreen.dart';
import 'package:appflutter_one/_components/modules/TinTuc/TinTucScreen.dart';
import 'package:appflutter_one/_components/modules_giaovien/HoatDong/GV_DSPhanCongSreen.dart';
import 'package:appflutter_one/_components/modules_giaovien/HoatDong/GV_HoatDongSreen.dart';
import 'package:appflutter_one/_components/modules_giaovien/XinNghiPhep/GV_XinNghiPhepScreen.dart';
import 'package:appflutter_one/_layouts/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../_services/HocPhi/HocPhiService.dart';
import '../../_services/Notification/NotificationService.dart';
import '../../_services/User/UserService.dart';
import '../../_services/XinNghiPhep/XinNghiPhepService.dart';
import '../../modules/404/404Screen.dart';
import '../../modules/HoatDong/HoatDongScreen.dart';
import '../../modules/MaterHocPhi/DSMaterHocPhiScreen.dart';
import '../../modules/SucKhoe/DSSucKhoeScreen.dart';
import '../../modules/XinNghiPhep/DSXinNghiPhepScreen.dart';
import '../../shared/UrlAPI/API_General.dart';
import '../../shared/utils/snackbar_helper.dart';

class GV_HomeScreen extends StatefulWidget {
  const GV_HomeScreen({super.key});

  // HomeScreen(this.jwt, this.payload);
  // factory HomeScreen.fromBase64(String jwt) => HomeScreen(
  //     jwt,
  //     json.decode(
  //         ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));
  // final String jwt;
  // final Map<String, dynamic> payload;
  @override
  State<GV_HomeScreen> createState() => _GV_HomeScreen();
}

class _GV_HomeScreen extends State<GV_HomeScreen> {
  NotificationService _notificationService = NotificationService();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List categoryMenu_New = [
    {"id": "1", "name": "Học sinh", "stringPage": "HS"},

    {"id": "2", "name": "Thời khóa biểu", "stringPage": "TKB"},
    {"id": "3", "name": "Sổ bé ngoan", "stringPage": "SBN"},
    {"id": "4", "name": "Nhật ký", "stringPage": "NK"},
    {"id": "5", "name": "Sức khỏe", "stringPage": "SK"},
    {"id": "6", "name": "Xin nghỉ", "stringPage": "XN"},
    {"id": "7", "name": "Dinh dưỡng", "stringPage": "DD"},
    {"id": "9", "name": "Điểm danh", "stringPage": "DDD"},
    {"id": "11", "name": "Tin tức", "stringPage": "TT"},
    {"id": "32", "name": "Hoạt động", "stringPage": "HDGV"},
    {"id": "26", "name": "DM Sức khỏe", "stringPage": "BDMater"},
    {"id": "8", "name": "Xin Nghỉ Phép Giáo Viên", "stringPage": "XNGV"},
    // {"id": "36", "name": "DM học phí", "stringPage": "MHP"},
    {"id": "25", "name": "Dặn thuốc", "stringPage": "DT"},
    {"id": "12", "name": "Tin Nhắn", "stringPage": "TN"},
    {"id": "39", "name": "Đăng xuất", "stringPage": "DX"},
  ];
  List adsList = [
    {"text": "Mục 1", "img": "1"},
    {"text": "Mục 2", "img": "2"},
    {"text": "Mục 3", "img": "3"},
    {"text": "Mục 4", "img": "4"},
  ];

  Map? items;
  Map? items_XinNghiPhep;
  bool loading = false;
  static get text => null;

  static get img => null;

  var userNameLogin = "System";

  var imageStudent = "";
  void initState() {
    setState(() {
      userNameAPI();
      FetchIdByStudent();
    });

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
      backgroundColor: Colors.grey[300],

      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 10),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 246, 177, 74),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24))),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard,
                              size: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 3, bottom: 15),
                        //   child: Text(
                        //     "Hi, Technical",
                        //     style: TextStyle(
                        //       fontSize: 25,
                        //       fontWeight: FontWeight.w600,
                        //       letterSpacing: 1,
                        //       wordSpacing: 2,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          alignment: Alignment.center,
                          // decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        50), // Đặt góc bo tròn để tạo hình tròn
                                    child: imageStudent == null ||
                                            imageStudent == {} ||
                                            imageStudent == ""
                                        ? Image.asset("images/17.png",
                                            fit: BoxFit.cover)
                                        : Image.network(
                                            "${SERVER_IP}${imageStudent}",
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 92,
                                  width: 92,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, bottom: 15),
                                      child: Text(
                                        "${userNameLogin}",
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          wordSpacing: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Column(
                      children: [
                        GridView.builder(
                          itemCount: categoryMenu_New.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.9),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                var menus =
                                    categoryMenu_New[index]["stringPage"];
                                log('data: $menus');
                                if (menus == "HS") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DSHocSinhScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "TKB") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ThoiKhoaBieuScreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "SBN") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SoBeNgoanScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "NK") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BangTinScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "SK") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DSSucKhoeScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "XN") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DSXinNghiPhepScreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "DD") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DinhDuongScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "HP") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DSHocPhiScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                }
                                // else if (menus == "HDD") {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => HoatDongScreen(
                                //               categoryMenu_New[index]["id"],
                                //               categoryMenu_New[index]["name"])));
                                // }
                                else if (menus == "DDD") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DSDiemDanhScreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "HA") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CourseScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "HS") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DSHocSinhScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "TT") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TinTucScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "BDMater") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DSMaterBieuDoScreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "DT") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DSDanThuocScreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "K") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DSKhoaHocScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "L") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DSClassScreen(
                                              categoryMenu_New[index]["id"],
                                              categoryMenu_New[index]
                                                  ["name"])));
                                } else if (menus == "DX") {
                                  logout();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                } else if (menus == "HDGV") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GV_HoatDongSreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "MHP") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DSMaterHocPhiScreen(
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else if (menus == "TN") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                } else if (menus == "XNGV") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GV_XinNghiPhepScreen(
                                                  items_XinNghiPhep,
                                                  categoryMenu_New[index]["id"],
                                                  categoryMenu_New[index]
                                                      ["name"])));
                                } else {
                                  // Xử lý trường hợp ngược lại
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotFoundScreen()));
                                  // Navigator.push( context, MaterialPageRoute( builder: (context) => CourseScreen(categoryMenu_New[index]["id"], categoryMenu_New[index]["name"])));
                                }

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           CourseScreen(adsList[index]["img"], adsList[index]["text"]),
                                //     ));
                              },
                              child: Container(
                                height:
                                    120, // Tổng chiều cao bao gồm cả hình ảnh và văn bản
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Căn giữa các phần tử trong Column
                                  children: [
                                    Container(
                                      height:
                                          95, // Chiều cao của container hình ảnh
                                      width:
                                          95, // Chiều rộng của container hình ảnh
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10), // Góc bo tròn

                                        color: Colors
                                            .white, // Màu nền của menu là trắng
                                        border: const Border(
                                          bottom: BorderSide(
                                            color: Color(
                                                0xFFBDBDBD), // Màu xám nhạt
                                            width: 2, // Độ dày của khung viền
                                          ),
                                        ),
                                      ),
                                      margin: const EdgeInsets.all(
                                          12), // Khoảng cách lề
                                      child: Center(
                                        child: Container(
                                          height: 70, // Chiều cao của hình ảnh
                                          width: 70, // Chiều rộng của hình ảnh
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                15), // Góc bo tròn của hình ảnh
                                          ),
                                          child: Image.asset(
                                            "images/${categoryMenu_New[index]["id"]}.png",
                                            fit: BoxFit
                                                .cover, // Điều chỉnh kích thước hình ảnh phù hợp
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      categoryMenu_New[index]["name"]
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black.withOpacity(0.7),
                                        fontFamily: 'Roboto',
                                        shadows: [
                                          Shadow(
                                            offset:
                                                Offset(1, 1), // Bóng của chữ
                                            blurRadius: 2,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
      ]),
      // bottomNavigationBar: BottomNavigationBar(
      //   showUnselectedLabels: true,
      //   iconSize: 30,
      //   selectedItemColor: Color(0xFF674AEF),
      //   selectedFontSize: 18,
      //   unselectedItemColor: Colors.grey,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //         backgroundColor: Colors.blue),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.assessment),
      //         label: 'Master',
      //         backgroundColor: Colors.blue),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'Tài khoản',
      //         backgroundColor: Colors.blue),
      //   ],
      //   currentIndex: _selectedIndex,
      //   // selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: School',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 3: Settings',
  //     style: optionStyle,
  //   ),
  // ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      navigateToPage(index);
    } else if (index == 1) {
    } else if (index == 2) {
      navigateToPage(index);
    }
  }

  Future<void> navigateToPage(int id) async {
    if (id == 0) {
      // final route = MaterialPageRoute(
      //   builder: (context) => HomeScreen("", {})
      // );
      // await Navigator.push(context, route);
    } else if (id == 2) {
      final route = MaterialPageRoute(builder: (context) => ProfileScreen());
      await Navigator.push(context, route);
    }
  }

  Future<void> userNameAPI() async {
    setState(() {
      loading = true;
    });
    final response = await UserService.FetchUserById();
    try {
      if (response != null) {
        setState(() {
          userNameLogin = response["lastName"];
          if (response["avatar"] != null || response["avatar"] != "") {
            imageStudent = response["avatar"];
          } else {
            imageStudent = "";
          }
          setState(() {
            loading = false;
          });
        });
      } else {
        showErrorMessage(context, message: 'Không có dữ liệu');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> logoutFirebase() async {
    print("nào");
    await FirebaseAuth.instance.signOut();

    // Clear local user data (adjust according to your local storage mechanism)
    final storage = FlutterSecureStorage();
    await storage.deleteAll();

    // Display success message or navigate to login screen
  }

  Future<void> logout() async {
    print("nào");
    logoutFirebase();
    final response = await UserService.logout();
    if (response != null) {
      print("nào");
      showSuccessMessage(context, message: 'Logout success');
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }

  Future<void> FetchIdByStudent() async {
    final response = await HocSinhService.FetchIdByStudent();
    if (response != null) {
      setState(() {
        imageStudent = response["imagePatch"];
        print(response);
      });
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }
}
