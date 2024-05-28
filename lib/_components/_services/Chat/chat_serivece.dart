import 'dart:convert';

import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/models/chat/message.dart';
import 'package:appflutter_one/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List<String> _contactedUserIds = [];

  void addContactedUserId(String userId) {
    if (!_contactedUserIds.contains(userId)) {
      _contactedUserIds.add(userId);
    }
  }

  List<String> get contactedUserIds => _contactedUserIds;

  Stream<List<Map<String, dynamic>>> getUsersStream() async* {
    String currentUserId = _authService.getCurrentUser()!.uid;
    String? value = await storage.read(key: 'jwt');
    final token = json.decode(value!);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token['accessToken']}",
    };
    yield* _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((user) =>
              user['uid'] != currentUserId && user['appID'] == token['appID'])
          .toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getMessagesWithUserNames() {
    print(_authService.getCurrentUser()!.uid);
    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .where('Users', arrayContains: _authService.getCurrentUser()!.uid)
        .snapshots()
        .asyncMap((snapshot) async {
      List<String> userIds = []; // Danh sách các ID người dùng từ tin nhắn
      for (DocumentSnapshot chatRoomDoc in snapshot.docs) {
        QuerySnapshot messageSnapshots = await FirebaseFirestore.instance
            .collection("chat_rooms")
            .doc(chatRoomDoc.id)
            .collection("messages")
            .get();
        for (DocumentSnapshot messageDoc in messageSnapshots.docs) {
          Map<String, dynamic> messageData =
              messageDoc.data() as Map<String, dynamic>;
          String senderId = messageData['senderID'] as String;
          String receiverId = messageData['receiverID'] as String;

          print(senderId);
          if (!userIds.contains(senderId)) {
            userIds.add(senderId);
          }
          if (!userIds.contains(receiverId)) {
            userIds.add(receiverId);
          }
        }
      }

      List<Map<String, dynamic>> users = [];
      for (String userId in userIds) {
        if (userId != _authService.getCurrentUser()!.uid) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .get();
          if (userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            users.add(userData);
            print(users);
          }
        }
      }

      return users;
    });
  }

  static Future<String?> getUserNameById(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      return userData['username'] as String?;
    } else {
      return null;
    }
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
    await _firestore.collection("chat_rooms").doc(chatRoomID).set({
      'UserIDTo': currentUserID,
      'UserIDFrom': receiverID,
      'Users': FieldValue.arrayUnion([currentUserID, receiverID]),
    }, SetOptions(merge: true));
  }

  Future<void> deleteMessage(String chatRoomID, String messageID) async {
    try {
      await _firestore
          .collection("chat_rooms")
          .doc(chatRoomID)
          .collection("messages")
          .doc(messageID)
          .delete();
    } catch (error) {
      print("Error deleting message: $error");
    }
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
