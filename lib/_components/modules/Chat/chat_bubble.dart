import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isCurrentUser ? 20 : 0),
            topRight: Radius.circular(isCurrentUser ? 0 : 20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          message,
          style: TextStyle(
            color: isCurrentUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
