import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/Chat/chat_serivece.dart';
import 'package:appflutter_one/_components/_services/Chat/groupchat_service.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/Chat/CreateGroupChatPage.dart';
import 'package:appflutter_one/_components/modules/Chat/chat_page.dart';
import 'package:appflutter_one/_components/modules/Chat/group.chat/groupchat_page.dart';
import 'package:appflutter_one/_components/modules/Chat/group.chat/newMessageScreen.dart';
import 'package:appflutter_one/_components/modules/Chat/my_drawer.dart';
import 'package:appflutter_one/_components/modules/Chat/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService(); // Khởi tạo service cho chat
  final AuthService _authService = AuthService();
  // Khởi tạo service cho authentication
  final GroupChatService _groupChatService = GroupChatService();
  List<Map<String, dynamic>> _groupChats = [];

  TextEditingController _searchController = TextEditingController();
  String _searchEmail = ''; // Biến để lưu trữ giá trị tìm kiếm

  // Hàm kiểm tra vai trò của người dùng trong nhóm chat

  // lưu trữ danh sách người dùng nhắn tin
  List<String> _messagedUsers = [];
  List<String> _users = [];
  Map<String, bool> _userHasMessaged = {};
  @override
  void initState() {
    super.initState();
    _updateGroupChats(); // Gọi hàm để cập nhật danh sách nhóm chat
    // _checkUserMessages();
  }

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // cập nhập
  void _updateGroupChats() {
    _groupChatService.getGroupChatsStream().listen((groups) {
      List<String> users = [];
      for (var groupChat in groups) {
        List<String> members = groupChat['members']?.cast<String>() ?? [];
        users.addAll(members);
      }
      setState(() {
        _groupChats = groups;
        _messagedUsers = users.toSet().toList();
      });
    });
  }

  void _createGroupChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGroupChatPage(), // Mở trang tạo nhóm chat
      ),
    );
  }

  void _newMessage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewMessageScreen(), // Mở trang tạo nhóm chat
      ),
    );
  }

  // chat with user
  void navigateToChatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          receiverEmail: 'Email của người nhận',
          receiverID: 'ID của người nhận',
        ),
      ),
    );
  }

  // xoá nhóm chat
  void _deleteGroupChat(String groupId) async {
    try {
      // Check user access before deletion (optional)
      String? currentUserId = _authService.getCurrentUser()?.uid;
      if (currentUserId == null) {
        throw Exception("User not logged in. Cannot delete group chat.");
      }
      bool hasAccess =
          await _groupChatService.checkUserAccess(groupId, currentUserId);
      if (!hasAccess) {
        throw Exception("Unauthorized access to delete group chat");
      }

      await _groupChatService.deleteGroupChat(groupId);

      // Update UI to reflect the deleted group chat
      setState(() {
        _groupChats.removeWhere((groupChat) => groupChat['groupId'] == groupId);
      });

      // Show success message or perform further actions (optional)
    } catch (e) {
      print('Error deleting group chat: $e');
      // Handle deletion errors (optional)
    }
  }

  // thanh tìm kiếm user bằng sendName
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () => _createGroupChat(context),
            icon: const Icon(Icons.group_add),
          ),
          IconButton(
            onPressed: () => _newMessage(context),
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchEmail = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search User',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromARGB(255, 248, 244, 244),
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchEmail = '';
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _buildUserList(),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getMessagesWithUserNames(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        List<Map<String, dynamic>> users = snapshot.data!;
        print("new users");
        print(users);
        List<Widget> tiles = users
            .where((userData) =>
                userData["userName"] != null &&
                userData["userName"]
                    .toLowerCase()
                    .contains(_searchEmail.toLowerCase())) // Áp dụng tìm kiếm
            .map<Widget>((userData) => _buildUserListItem(userData))
            .toList();
        // Bọc mỗi UserTile trong một Container với khung cong và tròn hơn
        List<Widget> userTiles = tiles.map<Widget>((tile) {
          return ListTile(
            subtitle: tile,
          );
        }).toList();

        userTiles.add(Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.group,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Group Chat',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              ..._groupChats.map<Widget>(
                  (groupChat) => _buildGroupChatTile(groupChat, context)),
            ],
          ),
        ));

        return Container(
          margin: const EdgeInsets.only(top: 10.0),
          decoration: const BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView(
            children: userTiles,
          ),
        );
      },
    );
  }

  // title group chat
  Widget _buildGroupChatTile(
      Map<String, dynamic> groupChat, BuildContext context) {
    String groupName = groupChat['name'];
    List<String> members = groupChat['members']?.cast<String>() ?? [];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatPage(
                groupId: groupChat['groupId'],
                groupName: groupName,
                senderId: _authService.getCurrentUser()?.uid ?? '',
                senderName: _authService.getCurrentUser()?.displayName ?? '',
                members: members),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 15)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groupName),
                Text('Members: ${members.length}'),
              ],
            ),
            // IconButton(
            //   icon: Icon(Icons.delete),
            //   onPressed: () {
            //     _deleteGroupChat(groupChat['groupId']); // Gọi hàm xoá nhóm chat
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(userData["userName"] != null
            ? userData["userName"].substring(0, 1)
            : "null"),
      ),
      title: Text(userData["userName"]),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text("Xem thông tin"),
                onTap: () {
                  // Hiển thị màn hình thông tin người dùng
                  _showUserInfoDialog(userData);
                },
              ),
            ),
          ];
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail:
                  userData["userName"], // Thay "email" bằng "userName"
              receiverID: userData["uid"],
            ),
          ),
        );
      },
    );
  }

  void _showUserInfoDialog(Map<String, dynamic> userData) {
    // Hiển thị màn hình modal với thông tin của người dùng
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(userData["userName"]),
          content: Text(
              "Số điện thoại: ${userData != null ? userData["phone"] ?? "Chưa cập nhập" : "Chưa cập nhập"}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }
}
