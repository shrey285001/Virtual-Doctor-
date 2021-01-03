import 'package:VirtualDoctor/UI/widgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class Result extends StatefulWidget {
  String res;
  String disease;
  Result({Key key, this.res, this.disease}) : super(key: key);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyHeader(
                  image: "assets/images/doctor6.png",
                  textTop: "Your Input",
                  textBottom: "shows...",
                  width: 120),
              Container(
                height: MediaQuery.of(context).size.height * 0.43,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color:
                        widget.res == "1" ? Colors.red[200] : Colors.green[200],
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        widget.res == "1"
                            ? FontAwesome5.sad_tear
                            : FontAwesome5.smile,
                        size: 100,
                        color: widget.res == "1"
                            ? Color(0xff800000)
                            : Color(0xff006400)),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.res == "1"
                          ? "Your chances of suffering with ${widget.disease} are greater than 50%"
                          : "Your chances of suffering with ${widget.disease} are less than 50%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.res == "1"
                              ? Color(0xff800000)
                              : Color(0xff006400),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
