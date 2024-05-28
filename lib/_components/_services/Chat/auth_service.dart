import 'dart:convert';

import 'package:appflutter_one/_components/_services/User/UserService.dart';
import 'package:appflutter_one/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage storagePass = FlutterSecureStorage();

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<UserCredential> signInWithEmailAndPassword(
      emailResult, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailResult,
        password: password,
      );
      String uid = userCredential.user!.uid;

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<String?> getUserName(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('Users').doc(userId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        return userData?['userName'];
      } else {
        return null;
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error getting user name: $e');
      return null;
    }
  }

  Future<UserCredential> signUpWithEmailPassword(
      String email, password, userName, phone) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = _auth.currentUser!.uid;
      String? value = await storage.read(key: 'jwt');
      final token = json.decode(value!);
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token['accessToken']}",
      };
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'uid': uid,
        'email': email,
        'userName': userName,
        'phone': phone,
        'appID': token['appID'],
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('phone', isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking phone number existence: $e');
      return false;
    }
  }

  // Đổi mật khẩu
  Future<void> changePassword(String newPassword) async {
    try {
      if (newPassword != "") {
        User? user = _auth.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
        } else {
          throw Exception("No user signed in");
        }
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    clearLocalData();
    return await _auth.signOut();
  }

  Future<void> clearLocalData() async {
    // Tạo một FlutterSecureStorage để quản lý dữ liệu cục bộ an toàn
    final storage = FlutterSecureStorage();

    try {
      // Xóa tất cả các giá trị lưu trữ cục bộ
      await storage.deleteAll();
    } catch (e) {
      // Xử lý lỗi nếu có
    }
  }

  Future<void> userNameFireBase(password) async {
    String uid = "";
    final response = await UserService.FetchUserByIdFireBase();
    print(response);
    if (response != null) {
      print(response);
      uid = response["userFireBaseDTO"]["uid"];
      print(uid);
      getEmailFromUid(uid);
      getEmailFromUid(uid).listen((emailResult) {
        if (emailResult.isNotEmpty) {
          LoginFireBase(emailResult, password!);
        } else {}
      });
    }
  }

  Future<void> LoginFireBase(emailResult, password) async {
    print(emailResult);
    print(password);
    try {
      final authResult = signInWithEmailAndPassword(
        emailResult,
        password,
      );
      // Do something after successful login
    } catch (e) {
      print("Lỗi: $e");
      // Handle login failure
    }
  }

  Stream<String> getEmailFromUid(String uid) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data()['email'];
      } else {
        return "";
      }
    });
  }

  createUserWithEmailAndPassword(String text, String text2) {}
  // errors
}
