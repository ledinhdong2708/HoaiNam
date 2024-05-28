import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/Chat/chat_serivece.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/Chat/chat_page.dart';
import 'package:appflutter_one/_components/modules/Chat/user_tile.dart';
import 'package:flutter/material.dart';

class NewMessageScreen extends StatefulWidget {
  @override
  _NewMessageScreenState createState() => _NewMessageScreenState();
}

final ChatService _chatService = ChatService();

class _NewMessageScreenState extends State<NewMessageScreen> {
  List<String> _contactedUserIds = []; // Danh sách người dùng đã liên hệ
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _usersList =
      []; // Danh sách người dùng từ Firestore
  List<Map<String, dynamic>> _filteredUsersList =
      []; // Danh sách người dùng được lọc
  String _searchEmail = '';
  final AuthService _authService = AuthService();
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Message"),
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _isSearching = value.trim().isNotEmpty;
                    _searchEmail = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search User',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchEmail = '';
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            if (_isSearching)
              Expanded(
                child: _buildUserList(),
              ),
          ],
        ),
      ]),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        List<Map<String, dynamic>> users = snapshot.data!;

        List<Widget> tiles = users
            .where((userData) =>
                userData["userName"] != null &&
                userData["userName"]
                    .toLowerCase()
                    .contains(_searchEmail.toLowerCase())) // Áp dụng tìm kiếm
            .map<Widget>((userData) => _buildUserListItem(userData))
            .toList();

        if (tiles.isEmpty) {
          return Center(
            child: Text("Không có người dùng nào tên '$_searchEmail'"),
          );
        }
        // Bọc mỗi UserTile trong một Container với khung cong và tròn hơn
        List<Widget> userTiles = tiles.map<Widget>((tile) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 1.0),
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                subtitle: tile,
              ),
            ),
          );
        }).toList();

        return ListView(
          children: userTiles,
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(userData["userName"].substring(0, 1)),
      ),
      title: Text(userData["userName"]),
      trailing: PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text("Xem thông tin"),
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
              receiverEmail: userData["userName"],
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
              child: Text("Đóng"),
            ),
          ],
        );
      },
    );
  }
}
