import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/Chat/chat_serivece.dart';
import 'package:appflutter_one/_components/_services/Chat/groupchat_service.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateGroupChatPage extends StatefulWidget {
  @override
  _CreateGroupChatPageState createState() => _CreateGroupChatPageState();
}

class _CreateGroupChatPageState extends State<CreateGroupChatPage> {
  final TextEditingController _groupNameController = TextEditingController();
  List<String> _selectedUsers = [];
  final GroupChatService _groupChatService = GroupChatService();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isAllFieldsValid() {
    return _groupNameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group Chat"),
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
                  labelText: 'Group Name',
                ),
                onChanged: (_groupNameController) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                // Thay _chatService.getUsersStream() bằng service thích hợp để lấy danh sách người dùng
                stream: _chatService.getUsersStream(),
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
                      return ListTile(
                        title: Text(userName),
                        leading: CircleAvatar(
                          child: Text(
                            userName.substring(0, 1),
                          ),
                        ),
                        trailing: Checkbox(
                          value: _selectedUsers.contains(uid),
                          onChanged: (isChecked) {
                            setState(() {
                              if (isChecked!) {
                                _selectedUsers.add(uid);
                              } else {
                                _selectedUsers.remove(uid);
                              }
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: isAllFieldsValid() ? _createGroup : null,
              child: Text("Create Group"),
            ),
          ],
        ),
      ]),
    );
  }

  void _createGroup() async {
    try {
      String groupName = _groupNameController.text;
      String currentUserID = _authService.getCurrentUser()!.uid!;
      List<String> members = List.from(_selectedUsers);
      members.add(currentUserID);
      await _groupChatService.createGroupChat(
          groupName, members, currentUserID);
      Navigator.pop(context);
    } catch (e) {
      print('Error creating group chat: $e');
      // Handle the error (e.g., show a snackbar to the user)
    }
  }
}
