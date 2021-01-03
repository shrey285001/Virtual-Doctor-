import 'package:VirtualDoctor/UI/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body: Container(
                width: 200,
                alignment: Alignment.center,
                child: Text(
                  "Something went wrong",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              )));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print(FirebaseAuth.instance.currentUser);
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: SplashScreen1());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: Container(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff073763),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Loading...",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
