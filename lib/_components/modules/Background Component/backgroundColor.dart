import 'package:flutter/material.dart';

Container backgroundColor(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white, // black at the top
          Colors.white
              .withOpacity(0.87), // semi-transparent black in the middle
          const Color.fromARGB(
              255, 226, 177, 104), // fully opaque at the bottom
        ],
        stops: const [
          0.0, // black at the top
          0.3, // semi-transparent black in the middle
          1.0, // white at the bottom
        ],
      ),
    ),
  );
}
