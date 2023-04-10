import 'package:blackcoffer/pages/homepage.dart';
import 'package:blackcoffer/pages/login_page.dart';
import 'package:blackcoffer/pages/video_selection_page.dart';
import 'package:flutter/material.dart';
import 'pages/otp_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        "video": (context) => Videopage(),
      },
    );
  }
}
