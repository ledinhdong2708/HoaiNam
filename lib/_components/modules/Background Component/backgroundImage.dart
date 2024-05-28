import 'package:flutter/material.dart';

Container backgroundImage() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/login-background-2.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  );
}
