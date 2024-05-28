import 'dart:convert';

import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/User/UserService.dart';
import 'package:appflutter_one/_components/modules/Home/HomeScreen.dart';
import 'package:appflutter_one/_components/modules/Profile/ProfileScreen.dart';
import 'package:appflutter_one/_components/modules_giaovien/Home/GV_Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../modules_phuhuynh/Home/PH_HomeScreen.dart';

class NavigationScreen extends StatefulWidget {
  final String jwt;
  final Map<String, dynamic> payload;
  final String password;

  NavigationScreen(this.jwt, this.payload, this.password);

  factory NavigationScreen.fromBase64(String jwt, String password) {
    return NavigationScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))),
      password,
    );
  }

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List pages = [];
  var userNameLogin = "System";
  final _auth = AuthService();
  void initState() {
    setState(() {
      final jwtS = widget.jwt.split(".")[1];
      final json = "[" + widget.payload.toString() + "]";
      if (widget.payload["role"] == "1") {
        pages = [const HomeScreen(), const ProfileScreen()];
      } else if (widget.payload["role"] == "2") {
        pages = [const GV_HomeScreen(), const ProfileScreen()];
      } else if (widget.payload["role"] == "3") {
        pages = [const PH_HomeScreen(), const ProfileScreen()];
      }
      userNameAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    _auth.userNameFireBase(widget.password);
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.assessment),
          //     label: 'Master',
          //     backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tài khoản',
              backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> userNameAPI() async {
    // final SharedPreferences prefs = await _prefs;
    String? value = await storage.read(key: 'jwt');
    // String? value = await prefs.getString("jwt");
    final body = json.decode(value!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${body['accessToken']}",
    };
    String credentials = "username:password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String decoded = stringToBase64.decode(body['username']);
    userNameLogin = decoded;
  }
}
