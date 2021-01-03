import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'HomePage.dart';
import 'LoginPage.dart';

class SplashScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      imageBackground: AssetImage('assets/images/bg1.jpg'),
      seconds: 5,
      navigateAfterSeconds:
          FirebaseAuth.instance.currentUser != null ? HomePage() : LoginPage(),
      image: Image(image: AssetImage('assets/images/logo.png')),
      photoSize: 150,
      loaderColor: Colors.white,
    );
  }
}
