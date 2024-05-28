import 'package:flutter/material.dart';

class DanhThiepUdemy extends StatelessWidget {
  const DanhThiepUdemy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("images/logotron_morris.jpg"),
            ),
            Text(
              'ntdong',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'FLUTER DEVERLOP',
              style: TextStyle(
                  fontFamily: 'Source Code Pro',
                  fontSize: 20,
                  color: Colors.teal.shade100,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(color: Colors.teal.shade100),
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '+84 123 456 789',
                    style: TextStyle(
                        fontFamily: 'Source Code Pro',
                        fontSize: 20,
                        color: Colors.teal.shade900,
                        letterSpacing: 2.5),
                  ),
                )
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal,
                ),
                title: Text(
                  'ntdong@ftisg.com.vn',
                  style: TextStyle(
                      fontFamily: 'Source Code Pro',
                      fontSize: 20,
                      color: Colors.teal.shade900,
                      letterSpacing: 2.5),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
// Row(
// children: [
// Icon(Icons.mail, color: Colors.teal),
// SizedBox(width: 10,),
// Text(
// 'ntdong@ftisg.com.vn',
// style: TextStyle(
// fontFamily: 'Source Code Pro',
// fontSize: 20,
// color: Colors.teal.shade900,
// letterSpacing: 2.5),
// )
// ],
// ),