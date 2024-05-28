import 'dart:convert';
import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/User/UserService.dart';
import 'package:appflutter_one/_components/shared/utils/snackbar_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../_components/shared/Navigation/NavigationScreen.dart';
import '../_components/shared/UrlAPI/API_General.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;
  void displayDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: loading
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/LogoSap.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/login-background-2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white, // black at the top
                      Colors.white.withOpacity(
                          0.87), // semi-transparent black in the middle
                      const Color.fromARGB(
                          255, 226, 177, 104), // fully opaque at the bottom
                    ],
                    stops: const [
                      0.0, // black at the top
                      0.3, // semi-transparent black in the middle
                      1.0, // white at the bottom
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    child: Align(
                      alignment: const Alignment(0.0, 0.8),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18, 40, 16, 16),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Text(
                                              'EFBOOK',
                                              style: TextStyle(
                                                fontSize:
                                                    40, // adjust the size as needed
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                  Shadow(
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 8.0,
                                                    color: Color.fromARGB(
                                                        121, 235, 173, 50),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: TextField(
                                                    controller:
                                                        _usernameController,
                                                    obscureText: false,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 14,
                                                      color: Color(0xff000000),
                                                    ),
                                                    decoration: InputDecoration(
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff000000),
                                                                width: 2),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff000000),
                                                                width: 1),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                      ),
                                                      hintText: "Tên đăng nhập",
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 8,
                                                              horizontal: 12),
                                                      prefixIcon: const Icon(
                                                          Icons.person,
                                                          color:
                                                              Color(0xff000000),
                                                          size: 24),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: TextField(
                                                    controller:
                                                        _passwordController,
                                                    obscureText: true,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14,
                                                      color: Color(0xff000000),
                                                    ),
                                                    decoration: InputDecoration(
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff000000),
                                                                width: 2),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff000000),
                                                                width: 1),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                      ),
                                                      hintText: "Mật khẩu",
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 8,
                                                              horizontal: 12),
                                                      prefixIcon: const Icon(
                                                          Icons.lock,
                                                          color:
                                                              Color(0xff000000),
                                                          size: 24),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    var username =
                                                        _usernameController
                                                            .text;
                                                    var password =
                                                        _passwordController
                                                            .text;

                                                    var jwt =
                                                        await attemptLogIn(
                                                            username, password);
                                                    if (jwt != null) {
                                                      storage.write(
                                                          key: "jwt",
                                                          value: jwt);
                                                      await storage.write(
                                                          key: "password",
                                                          value: password);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              NavigationScreen
                                                                  .fromBase64(
                                                                      jwt,
                                                                      password),
                                                        ),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      displayDialog(context,
                                                          "Tên đăng nhập và mật khẩu không đúng");
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 10, 20, 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black87,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: const Text(
                                                          "Đăng nhập",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            // fontStyle: FontStyle.italic,
                                                            // fontFamily: 'Pacifico',
                                                          ),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("Sản phẩm của Công ty Cổ Phần FTI Sài Gòn"),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  Text(" infosg@ftisg.com.vn"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ]),
              )
            ]),
    );
  }

  Future<String?> attemptLogIn(String username, String password) async {
    setState(() {
      loading = true;
    });
    final body = jsonEncode({"username": username, "password": password});
    const url = '${SERVER_IP}api/Users/login';
    final uri = Uri.parse(url);
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE",
      "content-type": "application/json-patch+json",
      "accept": "*/*",
    };
    var res = await http.post(uri, body: body, headers: headers);
    if (res.statusCode == 200) {
      setState(() {
        loading = false;
      });
      return res.body;
    } else {}

    return null;
  }
}
