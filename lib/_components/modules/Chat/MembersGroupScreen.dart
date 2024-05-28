import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/Chat/chat_serivece.dart';
import 'package:appflutter_one/_components/_services/Chat/groupchat_service.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MembersGroupScreen extends StatefulWidget {
  @override
  final String groupId;
  final List<String> members;
  MembersGroupScreen({
    required this.groupId,
    required this.members,
    Key? key,
  }) : super(key: key);
  _MembersGroupScreenState createState() => _MembersGroupScreenState();
}

class _MembersGroupScreenState extends State<MembersGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  List<String> _selectedUsers = [];
  final GroupChatService _groupChatService = GroupChatService();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Members (${widget.members.length})"),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  labelText: 'Search User',
                ),
                onChanged: (_groupNameController) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _groupChatService.getUsersMemberInGroup(widget.members),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading..");
                  }
                  List<Map<String, dynamic>> users = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      String userName = users[index]["userName"] ?? "";
                      String uid = users[index]["uid"] ?? "";
                      // Nếu uid trùng khớp với uid của người dùng hiện tại, hiển thị tên là "Bạn"
                      if (uid == _authService.getCurrentUser()!.uid) {
                        userName = "Bạn";
                      }
                      if (userName
                          .toLowerCase()
                          .contains(_groupNameController.text.toLowerCase())) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              userName.substring(0, 1),
                            ),
                          ),
                          title: Text(userName),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(Icons.info),
                                    title: Text("Xem thông tin"),
                                    onTap: () {
                                      // Gọi hàm hiển thị thông tin người dùng
                                      _showUserInfoDialog(users[index]);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text("Xóa khỏi nhóm"),
                                    onTap: () {
                                      // Gọi hàm xóa người dùng khỏi nhóm
                                      _removeUserFromGroup(uid);
                                    },
                                  ),
                                ),
                              ];
                            },
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void _showUserInfoDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user["userName"]),
          content: Text(
              "Số điện thoại: ${user != null ? user["phone"] ?? "Chưa cập nhập" : "Chưa cập nhập"}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  void _removeUserFromGroup(String userId) async {
    try {
      await _groupChatService.removeMemberFromGroup(widget.groupId, userId);
      setState(() {
        widget.members.remove(userId);
      });
    } catch (e) {
      print('Error removing user from group: $e');
    }
  }
}
