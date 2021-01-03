import 'dart:convert';
import 'package:VirtualDoctor/UI/SymptomsValidator/result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HeartDiseaseForm extends StatefulWidget {
  @override
  _HeartDiseaseFormState createState() => _HeartDiseaseFormState();
}

class _HeartDiseaseFormState extends State<HeartDiseaseForm> {
  HeartDiseaseFormDetail heartDiseaseFormDetail = new HeartDiseaseFormDetail();
  String gender = "Gender";
  String chestPain = "Chest Pain";
  String fastingBloodSugar = "Fasting Blood Sugar greater than 120mg/dl";
  String restingECG = "Resting Electrocardiographic results";
  String exerciseInducedAngina = "Exercise Induces Angina";
  String slope = "Slope of the peak exercise ST segment";
  String vessel = "Number of major vessels Colored by flourosopy";
  String thalassemia = "Thalassemia";

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
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            onChanged: (value) {
              setState(() {
                heartDiseaseFormDetail.age = int.tryParse(value);
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
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                gender = newValue;
                if (newValue == "Male") {
                  heartDiseaseFormDetail.gender = 0;
                } else if (newValue == "Female") {
                  heartDiseaseFormDetail.gender = 1;
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
            value: chestPain,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                chestPain = newValue;
                if (newValue == "Typical angina") {
                  heartDiseaseFormDetail.chestPain = 1;
                } else if (newValue == "Atypical angina") {
                  heartDiseaseFormDetail.chestPain = 2;
                } else if (newValue == "Non-anginal pain") {
                  heartDiseaseFormDetail.chestPain = 3;
                } else if (newValue == "Anon-anginal pain") {
                  heartDiseaseFormDetail.chestPain = 4;
                }
              });
            },
            items: [
              "Chest Pain",
              "Typical angina",
              "Atypical angina",
              "Non-anginal pain",
              "Anon-anginal pain"
            ].map<DropdownMenuItem<String>>((String value) {
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
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                hintText: 'Resting Blood Pressure',
                suffix: Text("mmHg")),
            onChanged: (value) {
              setState(() {
                heartDiseaseFormDetail.bp = int.tryParse(value);
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
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                hintText: 'Serum Cholestrol',
                suffix: Text("mg/dl")),
            onChanged: (value) {
              setState(() {
                setState(() {
                  heartDiseaseFormDetail.serumchl = int.tryParse(value);
                });
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
            value: fastingBloodSugar,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                fastingBloodSugar = newValue;
                if (newValue == "Yes") {
                  heartDiseaseFormDetail.fastingbloodsugar = 1;
                } else if (newValue == "No") {
                  heartDiseaseFormDetail.fastingbloodsugar = 2;
                }
              });
            },
            items: ["Fasting Blood Sugar greater than 120mg/dl", "Yes", "No"]
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
            value: restingECG,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                restingECG = newValue;
                if (newValue == "Normal") {
                  heartDiseaseFormDetail.ecg = 0;
                } else if (newValue == "Having ST-T") {
                  heartDiseaseFormDetail.ecg = 1;
                } else if (newValue == "Having hypertrophy") {
                  heartDiseaseFormDetail.ecg = 2;
                }
              });
            },
            items: [
              "Resting Electrocardiographic results",
              "Normal",
              "Having ST-T",
              "Having hypertrophy"
            ].map<DropdownMenuItem<String>>((String value) {
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
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              hintText: 'Maximum Heart Rate Achieved',
            ),
            onChanged: (value) {
              setState(() {
                heartDiseaseFormDetail.maxHeartRate = int.tryParse(value);
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
            value: exerciseInducedAngina,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                exerciseInducedAngina = newValue;
                if (newValue == "Yes") {
                  heartDiseaseFormDetail.exerciseInducedAngina = 1;
                } else if (newValue == "No") {
                  heartDiseaseFormDetail.exerciseInducedAngina = 0;
                }
              });
            },
            items: ["Exercise Induces Angina", "Yes", "No"]
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
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              hintText: 'ST depression induced by exercise relative to rest',
            ),
            onChanged: (value) {
              setState(() {
                heartDiseaseFormDetail.stDepressiong = int.tryParse(value);
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
            value: slope,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                slope = newValue;
                if (newValue == "upsloping") {
                  heartDiseaseFormDetail.peakSlope = 1;
                } else if (newValue == "flat") {
                  heartDiseaseFormDetail.peakSlope = 2;
                } else if (newValue == "downsloping") {
                  heartDiseaseFormDetail.peakSlope = 3;
                }
              });
            },
            items: [
              "Slope of the peak exercise ST segment",
              "upsloping",
              "flat",
              "downsloping"
            ].map<DropdownMenuItem<String>>((String value) {
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
            value: vessel,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                vessel = newValue;
                if (newValue == "0") {
                  heartDiseaseFormDetail.majorVessel = 0;
                } else if (newValue == "1") {
                  heartDiseaseFormDetail.majorVessel = 1;
                } else if (newValue == "2") {
                  heartDiseaseFormDetail.majorVessel = 2;
                } else if (newValue == "3") {
                  heartDiseaseFormDetail.majorVessel = 2;
                }
              });
            },
            items: [
              "Number of major vessels Colored by flourosopy",
              "0",
              "1",
              "2",
              "3"
            ].map<DropdownMenuItem<String>>((String value) {
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
            value: thalassemia,
            iconSize: 26,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            onChanged: (String newValue) {
              setState(() {
                thalassemia = newValue;
                if (newValue == "0") {
                  heartDiseaseFormDetail.thalassemia = 0;
                } else if (newValue == "1") {
                  heartDiseaseFormDetail.thalassemia = 1;
                } else if (newValue == "2") {
                  heartDiseaseFormDetail.thalassemia = 2;
                } else if (newValue == "3") {
                  heartDiseaseFormDetail.thalassemia = 2;
                }
              });
            },
            items: ["Thalassemia", "0", "1", "2", "3"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 20,
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
            if (heartDiseaseFormDetail.age == -1 ||
                heartDiseaseFormDetail.gender == -1 ||
                heartDiseaseFormDetail.bp == -1 ||
                heartDiseaseFormDetail.chestPain == -1 ||
                heartDiseaseFormDetail.ecg == -1 ||
                heartDiseaseFormDetail.exerciseInducedAngina == -1 ||
                heartDiseaseFormDetail.fastingbloodsugar == -1 ||
                heartDiseaseFormDetail.majorVessel == -1 ||
                heartDiseaseFormDetail.maxHeartRate == -1 ||
                heartDiseaseFormDetail.peakSlope == -1 ||
                heartDiseaseFormDetail.serumchl == -1 ||
                heartDiseaseFormDetail.stDepressiong == -1 ||
                heartDiseaseFormDetail.thalassemia == -1 ||
                gender == "Gender" ||
                chestPain == "Chest Pain" ||
                fastingBloodSugar ==
                    "Fasting Blood Sugar greater than 120mg/dl" ||
                restingECG == "Resting Electrocardiographic results" ||
                exerciseInducedAngina == "Exercise Induces Angina" ||
                slope == "Slope of the peak exercise ST segment" ||
                vessel == "Number of major vessels Colored by flourosopy" ||
                thalassemia == "Thalassemia") {
              Toast.show("Please Provide Values", context,
                  duration: Toast.LENGTH_SHORT,
                  gravity: Toast.BOTTOM,
                  backgroundColor: Color(0xdf073763));
            } else {
              Future<String> result = predictHeartDisease([
                heartDiseaseFormDetail.age,
                heartDiseaseFormDetail.gender,
                heartDiseaseFormDetail.chestPain,
                heartDiseaseFormDetail.bp,
                heartDiseaseFormDetail.serumchl,
                heartDiseaseFormDetail.fastingbloodsugar,
                heartDiseaseFormDetail.ecg,
                heartDiseaseFormDetail.maxHeartRate,
                heartDiseaseFormDetail.exerciseInducedAngina,
                heartDiseaseFormDetail.stDepressiong,
                heartDiseaseFormDetail.peakSlope,
                heartDiseaseFormDetail.majorVessel,
                heartDiseaseFormDetail.thalassemia
              ]);
              result.whenComplete(() => result.then((value) {
                    print(value);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Result(
                                  res: value,
                                  disease: "Angiographic Heart Disease",
                                )));
                  }));
            }
          },
        ),
        SizedBox(
          height: 20,
        )
      ],
    ));
  }

  Future<String> predictHeartDisease(var body) async {
    var client = new http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/heartDisease");
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

class HeartDiseaseFormDetail {
  int age = -1;
  int gender = -1;
  int chestPain = -1;
  int bp = -1;
  int serumchl = -1;
  int fastingbloodsugar = -1;
  int ecg = -1;
  int maxHeartRate = -1;
  int exerciseInducedAngina = -1;
  int stDepressiong = -1;
  int peakSlope = -1;
  int majorVessel = -1;
  int thalassemia = -1;
}
