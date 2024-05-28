import 'package:appflutter_one/_components/modules/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_02epxjye.json",
              width: screenWidth / 3 * 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 7),
              child: Text(
                "Sorry, we can't find page",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: OutlinedButton(onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => HomeScreen()
                //     )
                // );
              }
              , child: const Text('Về trang chủ')),
            )
          ],
        ),
      ),
    );
  }
}