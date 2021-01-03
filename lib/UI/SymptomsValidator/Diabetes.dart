import 'dart:convert';
import 'package:VirtualDoctor/UI/SymptomsValidator/result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DiabetesForm extends StatefulWidget {
  @override
  _DiabetesFormState createState() => _DiabetesFormState();
}

class _DiabetesFormState extends State<DiabetesForm> {
  String gender = "Gender";
  Diabetes diabetes = new Diabetes();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Age',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.age = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: gender,
              iconSize: 26,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              onChanged: (String newValue) {
                setState(() {
                  gender = newValue;
                  if (gender == "Male") {
                    diabetes.preganent = 0;
                  }
                });
              },
              items: ["Gender", "Male", "Female"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          gender == "Female"
              ? Container(
                  width: width * 0.7,
                  padding: EdgeInsets.only(left: 10),
                  decoration: ShapeDecoration(
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 5.0,
                          style: BorderStyle.solid,
                          color: Color(0xff073763)),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'No. of times preganant',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      setState(() {
                        diabetes.preganent = int.tryParse(value);
                      });
                    },
                  ),
                )
              : Container(),
          if (gender == "Female")
            SizedBox(
              height: 10,
            ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Glucose',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.glucose = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Blood Pressure',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.bp = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Skin Thickness',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.skinThick = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Insulin',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.insulin = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'BMI',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.bmi = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.7,
            padding: EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: Colors.white54,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 5.0,
                    style: BorderStyle.solid,
                    color: Color(0xff073763)),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Diabetes Pedigree Function',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              onChanged: (value) {
                setState(() {
                  diabetes.diabetesPedigree = int.tryParse(value);
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Color(0xffEE7B23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              child: Text('Submit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white70)),
            ),
            onTap: () {
              if (diabetes.preganent == -1 ||
                  diabetes.age == -1 ||
                  diabetes.glucose == -1 ||
                  diabetes.bp == -1 ||
                  diabetes.skinThick == -1 ||
                  diabetes.insulin == -1 ||
                  diabetes.bmi == -1 ||
                  diabetes.diabetesPedigree == -1 ||
                  gender == "Gender") {
                Toast.show("Please Provide Values", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Color(0xdf073763));
              } else {
                Future<String> result = predictDiabetes([
                  diabetes.preganent,
                  diabetes.glucose,
                  diabetes.bp,
                  diabetes.skinThick,
                  diabetes.insulin,
                  diabetes.bmi,
                  diabetes.diabetesPedigree,
                  diabetes.age
                ]);
                result.whenComplete(() => result.then((value) {
                      print(value);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Result(
                                    res: value,
                                    disease: "Diabetes Disease",
                                  )));
                    }));
              }
            },
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<String> predictDiabetes(var body) async {
    var client = new http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/diabetes");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = "[" + json.encode(body) + "]";
    try {
      var resp = await client.post(uri, headers: headers, body: jsonString);
      //var resp = await http.get(Uri.parse("http://127.0.0.1:5000"));
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(resp.body);
        print(result);
        return result["prediction"];
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: " + e.toString());
      return null;
    }
    return null;
  }
}

class Diabetes {
  int preganent = -1;
  int glucose = -1;
  int bp = -1;
  int skinThick = -1;
  int insulin = -1;
  int bmi = -1;
  int diabetesPedigree = -1;
  int age = -1;
}
