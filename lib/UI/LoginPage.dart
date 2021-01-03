import 'package:VirtualDoctor/UI/HomePage.dart';
import 'package:VirtualDoctor/UI/widgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signInPage = true;
  String email = "";
  String resetEmail = "";
  String password = "";
  String confirmPassword = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: signInPage
          ? Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyHeader(
                      image: "assets/images/doctor1.png",
                      textTop: "Bind  With",
                      textBottom: "       ❤",
                      width: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: width * 0.9,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: Icon(Icons.visibility_off),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              }),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Forget password?',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      elevation: 200,
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.98,
                                        height: 250,
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Are you sure to reset password?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff073763)),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: width * 0.9,
                                              child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Email',
                                                    suffixIcon:
                                                        Icon(Icons.email),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      resetEmail = value;
                                                    });
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    width: 110,
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Reset ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                  onTap: () async {
                                                    try {
                                                      FirebaseAuth auth =
                                                          FirebaseAuth.instance;
                                                      auth.sendPasswordResetEmail(
                                                          email: resetEmail);
                                                      Toast.show(
                                                          "Password Reset Link sent to your mail.",
                                                          context,
                                                          backgroundRadius: 20,
                                                          duration:
                                                              Toast.LENGTH_LONG,
                                                          gravity: Toast.BOTTOM,
                                                          backgroundColor:
                                                              Color(0xFF073763),
                                                          textColor:
                                                              Colors.white);

                                                      Navigator.pop(context);
                                                      setState(() {
                                                        resetEmail = "";
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    width: 110,
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Back",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      resetEmail = "";
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            child: Text('Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.white)),
                            color: Color(0xffEE7B23),
                            onPressed: () async {
                              if (email == "") {
                                Toast.show("Please Provide Email ID", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Color(0xD0073763));
                                return;
                              }
                              if (password == "") {
                                Toast.show("Please Provide Password", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Color(0xD0073763));
                                return;
                              }
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage(),
                                  ),
                                  (route) => false,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  Toast.show(
                                      "No user found for that email.", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Color(0xD0073763));
                                } else if (e.code == 'wrong-password') {
                                  Toast.show(
                                      "Wrong password provided for that user.",
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Color(0xD0073763));
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          email = "";
                          password = "";
                          confirmPassword = "";
                          signInPage = false;
                        });
                      },
                      child: Text.rich(
                        TextSpan(
                            text: 'Don\'t have an account,',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'Signup',
                                style: TextStyle(
                                    color: Color(0xffEE7B23),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyHeader(
                      image: "assets/images/doctor1.png",
                      textTop: "Bind  With",
                      textBottom: "       ❤",
                      width: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Signup',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: width * 0.9,
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            suffixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: width * 0.9,
                      child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: Icon(Icons.visibility_off),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: width * 0.9,
                      child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirmed Password',
                            suffixIcon: Icon(Icons.visibility_off),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          }),
                    ),
                    password != confirmPassword && confirmPassword.length != 0
                        ? Container(
                            margin:
                                EdgeInsets.only(left: 10.0, right: 30, top: 10),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Password doesn\'t match!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            child: Text('SignUp',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: Colors.white)),
                            color: Color(0xffEE7B23),
                            onPressed: () async {
                              if (email == "") {
                                Toast.show("Please Provide Email ID", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Color(0xD0073763));
                              }
                              if (password == confirmPassword) {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage(),
                                    ),
                                    (route) => false,
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    Toast.show(
                                        "The password provided is too weak.",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Color(0xD0073763));
                                  } else if (e.code == 'email-already-in-use') {
                                    Toast.show(
                                        "The account already exists for that email.",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Color(0xD0073763));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                Toast.show("Password doesn't match", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Color(0xD0073763));
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          email = "";
                          password = "";
                          confirmPassword = "";
                          signInPage = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40.0),
                        child: Text.rich(
                          TextSpan(
                              text: 'Already have an account,',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: 'SignIn',
                                  style: TextStyle(
                                      color: Color(0xffEE7B23),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
    );
  }
}
