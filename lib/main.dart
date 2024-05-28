import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:appflutter_one/APIs/firebaseChat_options.dart';
import 'package:appflutter_one/APIs/firebase_api.dart';
import 'package:appflutter_one/_layouts/splash%20.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '_components/shared/Navigation/NavigationScreen.dart';
import '_layouts/LoginScreen.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification received");
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultChatFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  await FirebaseMessaging.instance.getAPNSToken().then((String? token) {
    print('APNS Token: $token');
  });

  await FirebaseMessaging.instance.subscribeToTopic("TPITO");
  await FirebaseApi().initNotifications();

  // Đông test Push Notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
}

@pragma('vm:entry-point')

// const SERVER_IP = 'https://10.0.2.2:7194';

final storage = FlutterSecureStorage(
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

// final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class MyApp extends StatelessWidget {
  Future<Map<String, String>> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    var password = await storage.read(key: "password");
    if (jwt == null || password == null) {
      return {"jwt": "", "username": "", "password": ""};
    }
    return {"jwt": jwt, "password": password};
  }

  // const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Map<String, String>>(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          var data = snapshot.data!;
          var jwt = data["jwt"]!;
          var password = data["password"]!;
          if (jwt.isNotEmpty) {
            var jwtParts = jwt.split(".");
            if (jwtParts.length != 3) {
              return LoginScreen();
            } else {
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwtParts[1]))));
              if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                  .isAfter(DateTime.now())) {
                return NavigationScreen(jwt, payload, password);
              } else {
                return SplashScreen();
              }
            }
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  print("NOTIFICATIOn TITILE " + notification!.title.toString());
  // if (notification != null && android != null && !kIsWeb) {
  //   flutterLocalNotificationsPlugin.show(
  //     notification.hashCode,
  //     notification.title,
  //     notification.body,
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         channelDescription: channel.description,
  //         // TODO add a proper drawable resource to android, for now using
  //         //      one that already exists in example app.
  //         icon: 'launch_background',
  //       ),
  //     ),
  //   );
  // }
}
