import 'dart:convert';
import 'package:VirtualDoctor/UI/VirtualDoctor/symptom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Precaution>> fetchPrecautions() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/himanshuj581/Testjson/main/symptom_precaution');
  if (response.statusCode == 200) {
    List responseJson = json.decode(response.body.toString());
    List<Precaution> precautionList = new List();
    for (int i = 0; i < responseJson.length; i++) {
      Precaution precaution = new Precaution(
          disease: responseJson[i]["Disease"],
          p1: responseJson[i]["Precaution-1"],
          p2: responseJson[i]["Precaution-2"],
          p3: responseJson[i]["Precaution-3"],
          p4: responseJson[i]["Precaution-4"]);
      precautionList.add(precaution);
    }
    return precautionList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Precautions extends StatefulWidget {
  final List<Symptom> selectedSymptoms;

  const Precautions({Key key, this.selectedSymptoms}) : super(key: key);
  @override
  _PrecautionsState createState() => _PrecautionsState();
}

class _PrecautionsState extends State<Precautions> {
  bool flag = false;
  List<int> valuesToPredict = [];
  Future<String> futureDisease;
  String disease = "";
  Future<List<Precaution>> futurePrecautionList;
  Precaution precaution;

  @override
  void initState() {
    for (int i = 0; i < widget.selectedSymptoms.length; i++) {
      valuesToPredict.add(widget.selectedSymptoms[i].weight);
    }
    for (int i = widget.selectedSymptoms.length; i < 17; i++) {
      valuesToPredict.add(0);
    }
    futureDisease = predictDisease(valuesToPredict);
    futureDisease.whenComplete(() => futureDisease.then((value) {
          setState(() {
            disease = value;
          });
        }));

    futurePrecautionList = fetchPrecautions();
    futurePrecautionList.whenComplete(() => futurePrecautionList.then((value) {
          setState(() {
            for (int i = 0; i < value.length; i++) {
              if (disease == value[i].disease) {
                precaution = new Precaution(
                    disease: value[i].disease,
                    p1: value[i].p1,
                    p2: value[i].p2,
                    p3: value[i].p3,
                    p4: value[i].p4);
                break;
              }
            }
          });
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        flag = true;
      });
    });
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Color(0xD0073763),
        ),
        body: flag
            ? Stack(children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.all(5),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 40, left: 20, right: 20, bottom: 30),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(110),
                            topRight: Radius.circular(110),
                            bottomLeft: Radius.circular(110)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(top: 30, left: 20, right: 20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Hey, I just gone through the symptoms you are suffering with.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "There are chances that you are suffering with...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            precaution != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '" ' + precaution.disease + ' "',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              alignment: Alignment.center,
                              child: Text(
                                "Here are the precautions you should take...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            precaution != null && precaution.p1 != ""
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "1. " + precaution.p1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            precaution != null && precaution.p2 != ""
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "2. " + precaution.p2,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            precaution != null && precaution.p3 != ""
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "3. " + precaution.p3,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            precaution != null && precaution.p4 != ""
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "4. " + precaution.p4,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "If there are severe effect.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Immidiately make a visit to nearest Hospital",
                                style: TextStyle(
                                    color: Color(0xFFCB0000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "WE WISH YOU HEALTH \nLIFE!!",
                                style: TextStyle(
                                    color: Color(0xFF017D28),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 400,
                            )
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff071763), Color(0xffEE7B23)]),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(110),
                          topRight: Radius.circular(110),
                          bottomLeft: Radius.circular(110)),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital,
                        color: Colors.red,
                      ),
                      Text(
                        " Prescription ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.local_hospital,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Container(
                    width: 150,
                    child: Image.asset("assets/images/doctor3.png"),
                  ),
                )
              ])
            : Container(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 300,
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
                          width: 150,
                          child: Image.asset("assets/images/doctorMoving.gif")),
                      SizedBox(height: 20),
                      Text(
                        "Please wait,",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "I am writing your prescription...",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ));
  }

  Future<String> predictDisease(var body) async {
    var client = new http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/predict");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = "[" + json.encode(body) + "]";
    try {
      var resp = await client.post(uri, headers: headers, body: jsonString);
      //var resp = await http.get(Uri.parse("http://127.0.0.1:5000"));
      if (resp.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(resp.body);
        print(result);
        return result["disease"];
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }
}

class Precaution {
  String disease;
  String p1;
  String p2;
  String p3;
  String p4;
  Precaution({this.disease, this.p1, this.p2, this.p3, this.p4});
}
