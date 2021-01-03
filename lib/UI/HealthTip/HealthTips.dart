import 'dart:convert';
import 'package:VirtualDoctor/UI/HealthTip/HealthTipPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

Future<List<HealthTip>> fetchHealthTip() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/himanshuj581/Testjson/main/HealthTips.json');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List responseJson = json.decode(response.body.toString());
    List<HealthTip> healthTipList = createHealthTipList(responseJson);
    return healthTipList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<String>> fetchCategories() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/himanshuj581/Testjson/main/categories.json');
  if (response.statusCode == 200) {
    List responseJson = json.decode(response.body.toString());
    List<String> categoryList = new List();
    for (int i = 0; i < responseJson.length; i++) {
      categoryList.add(responseJson[i]);
    }
    return categoryList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

List<HealthTip> createHealthTipList(List data) {
  List<HealthTip> list = new List();
  for (int i = 0; i < data.length; i++) {
    String type = data[i]["Type"];
    String title = data[i]["Title"];
    List<dynamic> description = data[i]['Description'];
    List<dynamic> url = data[i]['Url'];
    int timestamp = data[i]['Timestamp'];
    HealthTip a = new HealthTip(
        type: type,
        title: title,
        description: description,
        url: url,
        timestamp: timestamp);
    list.add(a);
  }
  return list;
}

class HealthTip {
  final String type;
  final String title;
  final List<dynamic> description;
  final List<dynamic> url;
  final int timestamp;

  HealthTip(
      {this.type, this.title, this.description, this.url, this.timestamp});
}

class HealthTips extends StatefulWidget {
  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  Future<List<HealthTip>> healthTipList;
  Future<List<String>> categoriesList;
  String selectedCategory = "All";
  @override
  void initState() {
    super.initState();
    healthTipList = fetchHealthTip();
    categoriesList = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xff073763),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 3,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xff073763),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                'Timeline',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 35,
              child: Expanded(
                child: FutureBuilder<List<String>>(
                  future: categoriesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return category(snapshot.data[index]);
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<HealthTip>>(
                future: healthTipList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return card(snapshot.data[index]);
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
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
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blueGrey),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Loading...",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget category(String data) {
    return GestureDetector(
      child: Opacity(
        opacity: 0.75,
        child: Container(
          margin: EdgeInsets.only(left: 6),
          padding: EdgeInsets.all(6),
          child: Text('$data',
              style: TextStyle(
                  color: Color(0xff424242),
                  fontSize: 17,
                  fontWeight: FontWeight.w600)),
          decoration: BoxDecoration(
              color: Color(0xFFe0e0e0),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Color(0xaf424242))),
        ),
      ),
      onTap: () {
        setState(() {
          selectedCategory = data;
        });
      },
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

  Widget card(HealthTip data) {
    return data.type == selectedCategory || selectedCategory == "All"
        ? GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: 150,
              child: Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.all(10),
                      child: data.url.length == 0
                          ? Container(
                              child: Image(
                                image:
                                    AssetImage('assets/images/healthTips.jpg'),
                              ),
                            )
                          : Image.network(data.url[0]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            data.title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          margin: EdgeInsets.only(left: 10, top: 3),
                          child: Text(
                            readTimestamp(data.timestamp),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          margin: EdgeInsets.only(left: 10, top: 3),
                          child: Text(
                            data.description.length != 0
                                ? data.description[0]
                                : "",
                            overflow: TextOverflow.fade,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HealthTipPage(
                            type: data.type,
                            title: data.title,
                            description: data.description,
                            url: data.url,
                            timeStamp: data.timestamp,
                          )));
            },
          )
        : Container();
  }
}
