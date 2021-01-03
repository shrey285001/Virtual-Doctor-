import 'package:VirtualDoctor/UI/HealthServices/HealthCareService.dart';
import 'package:VirtualDoctor/UI/HealthTip/HealthTips.dart';
import 'package:VirtualDoctor/UI/LoginPage.dart';
import 'package:VirtualDoctor/UI/PersonalAssistant/PersonalAssistantBot.dart';
import 'package:VirtualDoctor/UI/SymptomsValidator/SymptomsValidator.dart';
import 'package:VirtualDoctor/UI/VirtualDoctor/virtualDoctor.dart';
import 'package:VirtualDoctor/UI/widgets/Header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool menuShow = false;
  String password = "";
  String confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              menuShow = false;
            });
          },
          child: Container(
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
                      width: 150),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              RaisedButton(
                                child: Image.asset(
                                  "assets/icons/Health_Tips.png",
                                  width: 100,
                                  height: 100,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    menuShow = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HealthTips()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: Color(0xff073763), width: 5)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Health Tips',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff073763),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              RaisedButton(
                                child: Image.asset(
                                  "assets/icons/Localised_Health_Service.png",
                                  width: 100,
                                  height: 100,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    menuShow = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HealthCareService()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: Color(0xff073763), width: 5)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Health Service',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff073763),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              RaisedButton(
                                child: Image.asset(
                                  "assets/icons/Symptoms_Validation.png",
                                  width: 100,
                                  height: 100,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    menuShow = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SymptomsValidator()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: Color(0xff073763), width: 5)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Symptoms Validation',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff073763),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              RaisedButton(
                                child: Image.asset(
                                  "assets/icons/Personlised_Assistant.png",
                                  width: 100,
                                  height: 100,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    menuShow = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalAssistantBot()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: Color(0xff073763), width: 5)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Personlised Assistant',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff073763),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        children: [
                          RaisedButton(
                            child: Image.asset(
                              "assets/icons/Virtual_Doctor.png",
                              width: 100,
                              height: 100,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                menuShow = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VirtualDoctor()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: Color(0xff073763), width: 5)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Virtual Doctor',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff073763),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Icon(
                    Icons.menu,
                    size: 30,
                    color: Color(0xff073763),
                  ),
                ),
                onTap: () {
                  setState(() {
                    menuShow = !menuShow;
                  });
                },
              ),
              menuShow
                  ? Column(
                      children: [
                        GestureDetector(
                          child: Container(
                              color: Colors.white,
                              width: 120,
                              height: 65,
                              alignment: Alignment.center,
                              child: Text(
                                "Change Password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff073763)),
                              )),
                          onTap: () {
                            setState(() {
                              menuShow = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    elevation: 200,
                                    content: Stack(
                                      overflow: Overflow.clip,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.98,
                                          height: 200,
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Are you sure to change password?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff073763)),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    child: Container(
                                                      width: 110,
                                                      height: 45,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Reset",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                    onTap: () async {
                                                      try {
                                                        FirebaseAuth auth =
                                                            FirebaseAuth
                                                                .instance;
                                                        auth.sendPasswordResetEmail(
                                                            email: auth
                                                                .currentUser
                                                                .email);
                                                        Toast.show(
                                                            "Password Reset Link sent to your mail.",
                                                            context,
                                                            backgroundRadius:
                                                                20,
                                                            duration: Toast
                                                                .LENGTH_LONG,
                                                            gravity:
                                                                Toast.BOTTOM,
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF073763),
                                                            textColor:
                                                                Colors.white);

                                                        Navigator.pop(context);
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
                                                      height: 45,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Back",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        Container(
                          color: Colors.white,
                          width: 120,
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                              color: Colors.white,
                              width: 120,
                              height: 35,
                              alignment: Alignment.center,
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff073763)),
                              )),
                          onTap: () {
                            setState(() {
                              menuShow = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    elevation: 200,
                                    content: Stack(
                                      overflow: Overflow.clip,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.98,
                                          height: 150,
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Are you sure to logout?",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff073763)),
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
                                                      height: 45,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Logout",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.redAccent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                    onTap: () async {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signOut();

                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              LoginPage(),
                                                        ),
                                                        (route) => false,
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      width: 110,
                                                      height: 45,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Back",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        Container(
                          color: Colors.white,
                          width: 120,
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        )
      ],
    ));
  }
}
