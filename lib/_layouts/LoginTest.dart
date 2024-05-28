import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Image(
                  image: AssetImage("images/backgroud_login.jpg"),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  child: Align(
                    alignment: Alignment(0.0, 0.8),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      // width: MediaQuery.of(context).size.width * 0.85,
                      // height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: Color(0xff76d3f2), width: 2),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: TextEditingController(),
                                        obscureText: false,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: BorderSide(
                                                color: Color(0xfff38af6),
                                                width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: BorderSide(
                                                color: Color(0xfff38af6),
                                                width: 2),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: BorderSide(
                                                color: Color(0xfff38af6),
                                                width: 2),
                                          ),
                                          labelText: "Username",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: Color(0xfff38af6),
                                          ),
                                          hintText: "Username",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xfff2f2f3),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          prefixIcon: Icon(Icons.person,
                                              color: Color(0xfff38af6),
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                  width:
                                      MediaQuery.of(context).size.width * 0.16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: TextEditingController(),
                                        obscureText: true,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        decoration: InputDecoration(
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: BorderSide(
                                                color: Color(0xfff38af6),
                                                width: 2),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: BorderSide(
                                                color: Color(0xfff38af6),
                                                width: 2),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: BorderSide(
                                                color: Color(0xfff38af6),
                                                width: 2),
                                          ),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: Color(0xfff38af6),
                                          ),
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xfff2f2f3),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          prefixIcon: Icon(Icons.lock,
                                              color: Color(0xfff38af6),
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Checkbox(
                                      onChanged: (value) {},
                                      activeColor: Color(0xff3a57e8),
                                      autofocus: false,
                                      checkColor: Color(0xffffffff),
                                      hoverColor: Color(0x42000000),
                                      splashRadius: 20,
                                      value: true,
                                    ),
                                    Text(
                                      "Remember Me",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xffbab4b4),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image(
                                      image: AssetImage("images/Groceries.jpg"),
                                      height: 40,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Text(
                                            "Log In",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
