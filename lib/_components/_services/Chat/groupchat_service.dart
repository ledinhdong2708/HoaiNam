import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/SharedService/SharedService.dart';
import 'package:appflutter_one/_components/models/chat/group_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import class Group

class GroupChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  Future<void> deleteGroupChat(String groupId) async {
    try {
      // Check user access before deletion (optional)
      String? currentUserId = _authService.getCurrentUser()?.uid;
      if (currentUserId == null) {
        throw Exception("User not logged in. Cannot delete group chat.");
      }
      bool hasAccess = await checkUserAccess(groupId, currentUserId);
      if (!hasAccess) {
        throw Exception("Unauthorized access to delete group chat");
      }

      // Delete group document from 'groups' collection
      await _firestore.collection('groups').doc(groupId).delete();

      // Delete group information from each member's documents
      await _firestore
          .collection('users')
          .get()
          .then((querySnapshot) => querySnapshot.docs.forEach((doc) async {
                String memberId = doc.id;
                await _firestore
                    .collection('users')
                    .doc(memberId)
                    .collection('groups')
                    .doc(groupId)
                    .delete();
              }));

      // Delete group messages subcollection (optional)
      await _firestore
          .collection('group_messages')
          .doc(groupId)
          .collection('messages')
          .get()
          .then((querySnapshot) =>
              querySnapshot.docs.forEach((doc) => doc.reference.delete()));
    } catch (e) {
      print('Error deleting group chat: $e');
      throw e;
    }
  }

  Future<void> createGroupChat(
      String groupName, List<String> members, String adminId) async {
    try {
      String groupId = _firestore.collection('groups').doc().id;

      await _firestore.collection('groups').add({
        'name': groupName,
        'members': members,
        'groupId': groupId,
        'adminId': adminId,
      });

      for (String memberId in members) {
        String role = await getUserRole(memberId);

        await _firestore
            .collection('users')
            .doc(memberId)
            .collection('groups')
            .doc(groupId)
            .set({
          'name': groupName,
          'groupId': groupId,
          'canViewChat': true,
          'role': role,
        });
      }
    } catch (e) {
      print('Error creating group chat: $e');
      throw e;
    }
  }

  Stream<List<Map<String, dynamic>>> getUsersMemberNotInGroup(
      List<String> membersInGroup) {
    String currentUserId = _authService.getCurrentUser()!.uid;
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where((user) =>
              user['uid'] != currentUserId &&
              !membersInGroup.contains(user['uid']))
          .toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersMemberInGroup(
      List<String> membersInGroup) {
    String currentUserId = _authService.getCurrentUser()!.uid;
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where((user) => membersInGroup.contains(user['uid']))
          .toList();
    });
  }

  Future<void> addMembersToGroup(
      String groupId, List<String> newMembers) async {
    try {
      // Lấy thông tin của nhóm từ Firestore dựa trên groupId
      final groupQuery = await _firestore
          .collection('groups')
          .where('groupId', isEqualTo: groupId)
          .limit(1)
          .get();

      // Kiểm tra xem nhóm có tồn tại không
      if (groupQuery.docs.isNotEmpty) {
        // Lấy dữ liệu của nhóm từ query
        final groupData = groupQuery.docs.first.data() as Map<String, dynamic>;

        // Lấy danh sách thành viên từ dữ liệu nhóm
        List<String> members = List.from(groupData['members'] as List<dynamic>);

        // Thêm các thành viên mới vào danh sách thành viên
        members.addAll(newMembers);

        // Loại bỏ bất kỳ thành viên trùng lặp nào
        members = members.toSet().toList();

        // Cập nhật dữ liệu nhóm trong Firestore để thêm mới thành viên
        await _firestore
            .collection('groups')
            .doc(groupQuery.docs.first.id)
            .update({
          'members': members,
        });

        print('Thêm thành viên vào nhóm thành công');
      } else {
        print('Không tìm thấy nhóm có groupId: $groupId');
      }
    } catch (e) {
      print('Lỗi khi thêm thành viên vào nhóm: $e');
      throw e;
    }
  }

  Future<void> exitGroup(String groupId) async {
    try {
      final groupQuery = await _firestore
          .collection('groups')
          .where('groupId', isEqualTo: groupId)
          .limit(1)
          .get();

      if (groupQuery.docs.isNotEmpty) {
        final groupIdToDelete = groupQuery.docs.first.id;

        final groupData = groupQuery.docs.first.data() as Map<String, dynamic>;

        final members = List.from(groupData['members'] as List<dynamic>);

        members.remove(_authService.getCurrentUser()!.uid);

        await _firestore.collection('groups').doc(groupIdToDelete).update({
          'members': members,
        });

        print('Người dùng đã thoát khỏi nhóm thành công');
      } else {
        print('Không tìm thấy nhóm có groupId: $groupId');
      }
    } catch (e) {
      print('Lỗi khi thoát khỏi nhóm: $e');
      throw e;
    }
  }

  Future<bool> isUserAdmin(String groupId, String userId) async {
    try {
      final groupQuery = await _firestore
          .collection('groups')
          .where('groupId', isEqualTo: groupId)
          .limit(1)
          .get();

      if (groupQuery.docs.isNotEmpty) {
        final groupIdToDelete = groupQuery.docs.first.id;

        final groupData = groupQuery.docs.first.data() as Map<String, dynamic>;
        print("object");
        print(groupData);
        String admins = groupData['adminId'];
        print(admins);
        // Kiểm tra xem userId có trong danh sách quản trị viên không
        return admins.contains(userId);
      } else {
        // Xử lý trường hợp không tìm thấy nhóm
        return false;
      }
    } catch (e) {
      // Xử lý lỗi
      print('Error checking user admin status: $e');
      throw e;
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      final groupQuery = await _firestore
          .collection('groups')
          .where('groupId', isEqualTo: groupId)
          .limit(1)
          .get();

      if (groupQuery.docs.isNotEmpty) {
        final groupIdToDelete = groupQuery.docs.first.id;

        await _firestore.collection('groups').doc(groupIdToDelete).delete();

        print('Nhóm đã được xóa thành công');
      } else {
        print('Không tìm thấy nhóm có groupId: $groupId');
      }
    } catch (e) {
      print('Lỗi khi xóa nhóm: $e');
      throw e;
    }
  }

  Future<void> removeMemberFromGroup(String groupId, String uid) async {
    try {
      // Lấy thông tin của nhóm từ Firestore dựa trên groupId
      final groupQuery = await _firestore
          .collection('groups')
          .where('groupId', isEqualTo: groupId)
          .limit(1)
          .get();

      if (groupQuery.docs.isNotEmpty) {
        final groupIdToDelete = groupQuery.docs.first.id;
        final groupData = groupQuery.docs.first.data() as Map<String, dynamic>;
        final members = List.from(groupData['members'] as List<dynamic>);
        members.remove(uid);
        await _firestore.collection('groups').doc(groupIdToDelete).update({
          'members': members,
        });

        print('Người dùng đã thoát khỏi nhóm thành công');
      } else {
        print('Không tìm thấy nhóm có groupId: $groupId');
      }
    } catch (e) {
      print('Lỗi khi thoát khỏi nhóm: $e');
      throw e;
    }
  }

  Stream<List<Map<String, dynamic>>> getGroupChatsStream() {
    return _firestore
        .collection("groups")
        .where('members', arrayContains: _authService.getCurrentUser()!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final group = doc.data();
        return group;
      }).toList();
    });
  }

  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }

  Future<String?> getUserRoleInGroupChat(String groupId, String? userId) async {
    // Thực hiện các bước để lấy vai trò của người dùng trong nhóm chat
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('groupChats')
          .doc(groupId)
          .get();

      Map<String, dynamic>? groupChatData = snapshot.data();

      if (groupChatData != null) {
        // Lấy thông tin vai trò của người dùng từ dữ liệu nhóm chat
        String? userRole = groupChatData['roles'][userId];

        return userRole;
      }
    } catch (e) {
      print('Error getting user role: $e');
    }

    return null; // Trả về null nếu không lấy được vai trò của người dùng
  }

  Future<String> getUserRole(String userId) async {
    // Lấy thông tin User từ Firestore
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(userId).get();

    // Truy cập vào dữ liệu của tài liệu User
    Map<String, dynamic>? userData = userSnapshot.data();

    return userData?['role'] as String? ?? 'member';
  }

  // Phương thức để thêm thành viên vào nhóm chat
  Future<void> addMemberToGroup(String groupId, String memberId) async {
    try {
      // Tạo một tài liệu mới trong Firestore
      await _firestore.collection('group_members').add({
        'groupId': groupId,
        'userId': memberId,
      });
    } catch (e) {
      print('Error adding member to group: $e');
      throw e; // Re-throw để cho phép lớp gọi xử lý ngoại lệ theo cách phù hợp
    }
  }

  // Phương thức để lấy danh sách người dùng từ Firestore
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Lấy trường "email" của mỗi người dùng
        final String email = doc.data()["email"];

        // Trả về một Map chứa thông tin của mỗi người dùng
        return {
          "email": email,
          // Các trường khác nếu cần
        };
      }).toList();
    });
  }

// group message
  Future<void> sendGroupMessage(String groupId, String message, String senderId,
      String senderName) async {
    try {
      String messageId =
          FirebaseFirestore.instance.collection('group_messages').doc().id;

      GroupMessage groupMessage = GroupMessage(
        messageId: messageId,
        groupId: groupId,
        senderId: senderId,
        senderName: senderName,
        message: message,
        timestamp: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('group_messages')
          .doc(
              groupId) // Use groupId as document ID instead of generating a new one
          .collection('messages')
          .doc(messageId)
          .set(groupMessage.toMap());
    } catch (e) {
      print('Error sending group message: $e');
      throw e;
    }
  }

  Stream<QuerySnapshot> getGroupMessagesStream(String groupId) {
    return FirebaseFirestore.instance
        .collection('group_messages')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  checkUserAccess(String groupId, String currentUserId) {}
}
