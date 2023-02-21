import 'package:blackcoffer/pages/homepage.dart';
import 'package:blackcoffer/pages/login_page.dart';
import 'package:blackcoffer/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'pages/otp_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        "login": (context) => LoginPage(),
        "otp": (context) => OtpPage(),
        "home": (context) => HomePage(),
        "camera": (context) => Mycamera(),
      },
    );
  }
}
