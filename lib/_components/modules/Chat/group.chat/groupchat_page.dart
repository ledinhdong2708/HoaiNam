import 'package:appflutter_one/_components/_services/Chat/auth_service.dart';
import 'package:appflutter_one/_components/_services/Chat/groupchat_service.dart';
import 'package:appflutter_one/_components/models/chat/group_message.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundColor.dart';
import 'package:appflutter_one/_components/modules/Background%20Component/backgroundImage.dart';
import 'package:appflutter_one/_components/modules/Chat/AddMembersScreen.dart';
import 'package:appflutter_one/_components/modules/Chat/MembersGroupScreen.dart';
import 'package:appflutter_one/_components/modules/Chat/chat_bubble.dart';
import 'package:appflutter_one/_components/modules/Chat/home_page.dart';
import 'package:appflutter_one/_components/modules/Chat/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class GroupChatPage extends StatefulWidget {
  final String groupId;
  final String senderId;
  final String senderName;
  final String groupName;
  final List<String> members;

  GroupChatPage({
    required this.groupId,
    required this.senderId,
    required this.senderName,
    required this.groupName,
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final FocusNode _myFocusNode = FocusNode();
  final GroupChatService _groupChatService = GroupChatService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _myFocusNode.addListener(() {
      if (_myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
  }

  @override
  void dispose() {
    _myFocusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendGroupMessage() async {
    if (_messageController.text.isNotEmpty) {
      if (_groupChatService.getCurrentUser() != null) {
        await _groupChatService.sendGroupMessage(
          widget.groupId,
          _messageController.text,
          widget.senderId,
          widget.senderName,
        );
        _messageController.clear();
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'exit':
                  break;
                case 'add':
                  break;
                case 'view':
                  break;
                case 'delete':
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'exit',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Thoát'),
                ),
                onTap: () async {
                  try {
                    await _groupChatService.exitGroup(widget.groupId);
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lỗi khi tạo nhóm'),
                      ),
                    );
                  }
                },
              ),
              PopupMenuItem<String>(
                value: 'add',
                child: ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Thêm người'),
                ),
                onTap: () async {
                  try {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMembersScreen(
                              groupId: widget.groupId, members: widget.members),
                        ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lỗi '),
                      ),
                    );
                  }
                },
              ),
              PopupMenuItem<String>(
                value: 'view',
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Xem thành viên'),
                ),
                onTap: () async {
                  try {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MembersGroupScreen(
                              groupId: widget.groupId, members: widget.members),
                        ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lỗi '),
                      ),
                    );
                  }
                },
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Giải tán nhóm'),
                ),
                onTap: () async {
                  try {
                    // Check if the current user is admin before allowing to delete the group
                    bool isAdmin = await _groupChatService.isUserAdmin(
                        widget.groupId, _authService.getCurrentUser()!.uid);
                    if (isAdmin) {
                      await _groupChatService.deleteGroup(widget.groupId);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Bạn không có quyền giải tán nhóm'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lỗi khi giải tán nhóm: $e'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: Stack(children: [
        backgroundImage(),
        backgroundColor(context),
        Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(),
          ],
        ),
      ]),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _groupChatService.getGroupMessagesStream(widget.groupId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        List<DocumentSnapshot> messages = snapshot.data!.docs;

        // Sắp xếp tin nhắn theo thứ tự tăng dần của thời gian
        messages.sort((a, b) {
          Map<String, dynamic> dataA = a.data() as Map<String, dynamic>;
          Map<String, dynamic> dataB = b.data() as Map<String, dynamic>;
          Timestamp timestampA = dataA['timestamp'];
          Timestamp timestampB = dataB['timestamp'];
          return timestampA.compareTo(timestampB);
        });

        return ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(messages[index]);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    GroupMessage message =
        GroupMessage.fromMap(doc.data() as Map<String, dynamic>);

    // Lấy thông tin userName của người gửi từ dữ liệu tin nhắn
    String senderName = message.senderName;

    // Kiểm tra xem tin nhắn có phải từ người dùng hiện tại không
    bool isCurrentUser = message.senderId == _authService.getCurrentUser()!.uid;

    // Căn chỉnh tin nhắn sang phải nếu nó từ người dùng hiện tại
    var alignment =
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // Extract timestamp from message
    Timestamp timestamp = message.timestamp;

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          if (!isCurrentUser) // Hiển thị userName ở trên tin nhắn của người gửi
            FutureBuilder<String?>(
              future: _authService.getUserName(
                  message.senderId), // Sử dụng phương thức getUserName
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                String userName = snapshot.data ?? 'Unknown';
                return Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ChatBubble(
            message: message.message,
            isCurrentUser: isCurrentUser,
          ),
          Text(
            '${DateFormat('HH:mm').format(timestamp.toDate())}', // Hiển thị giờ từ timestamp
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              focusNode: _myFocusNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendGroupMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
