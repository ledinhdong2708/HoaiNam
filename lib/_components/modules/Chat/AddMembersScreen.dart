import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/Chat/chat_serivece.dart';
import 'package:appflutter_one/_components/_services/Chat/groupchat_service.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMembersScreen extends StatefulWidget {
  @override
  final String groupId;
  final List<String> members;
  AddMembersScreen({
    required this.groupId,
    required this.members,
    Key? key,
  }) : super(key: key);
  _AddMembersScreenState createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
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
                  labelText: 'Search User',
                ),
                onChanged: (_groupNameController) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    _groupChatService.getUsersMemberNotInGroup(widget.members),
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
                      // Thêm kiểm tra để lọc danh sách người dùng theo tìm kiếm
                      if (userName
                          .toLowerCase()
                          .contains(_groupNameController.text.toLowerCase())) {
                        return CheckboxListTile(
                          title: Text(userName),
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
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addMembersToGroup,
              child: Text("Add"),
            ),
          ],
        ),
      ]),
    );
  }

  void _addMembersToGroup() async {
    try {
      List<String> members = List.from(_selectedUsers);
      await _groupChatService.addMembersToGroup(widget.groupId, members);
      Navigator.pop(context);
    } catch (e) {
      print('Error creating group chat: $e');
      // Handle the error (e.g., show a snackbar to the user)
    }
  }
}
