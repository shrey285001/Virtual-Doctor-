import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HealthTipPage extends StatefulWidget {
  final String type;
  final String title;
  final List<dynamic> description;
  final List<dynamic> url;
  final int timeStamp;
  const HealthTipPage(
      {Key key,
      this.type,
      this.title,
      this.description,
      this.url,
      this.timeStamp})
      : super(key: key);
  @override
  _HealthTipPageState createState() => _HealthTipPageState();
}

class _HealthTipPageState extends State<HealthTipPage> {
  @override
  Widget build(BuildContext context) {
    String description = "";
    for (int i = 0; i < widget.description.length; i++) {
      description += widget.description[i] + "\n\n";
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: widget.url.length != 0
                          ? NetworkImage(widget.url[0])
                          : AssetImage("assets/images/healthTips.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 32,
                              color: Color(0xfffdfdfd),
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.type,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xfffdfdfd),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              readTimestamp(widget.timeStamp),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xfffdfdfd),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }
}
