import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset = 0;
  final double width;
  const MyHeader(
      {Key key, this.image, this.textTop, this.textBottom, this.width})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 30, top: 50, right: 20),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF073763),
              Color(0xFF0762A3),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Image.asset(
                widget.image,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                width: widget.width,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: width * 0.5, top: 90),
              child: Text(
                "${widget.textTop} \n${widget.textBottom}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.textTop.length > 12 ? 21 : 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
