import 'dart:convert';
import 'package:VirtualDoctor/UI/VirtualDoctor/Precautions.dart';
import 'package:VirtualDoctor/UI/VirtualDoctor/symptom.dart';
import 'package:http/http.dart' as http;
import 'package:VirtualDoctor/UI/widgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Future<List<Symptom>> fetchSymptoms() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/himanshuj581/Testjson/main/Symptoms_severity.json');
  if (response.statusCode == 200) {
    List responseJson = json.decode(response.body.toString());
    print(response.body);
    List<Symptom> symptomsList = new List();
    symptomsList.add(defaultList);
    for (int i = 0; i < responseJson.length; i++) {
      Symptom symptom = new Symptom(
          symptomName: responseJson[i]["Symptom"],
          weight: responseJson[i]["weight"]);
      symptomsList.add(symptom);
    }
    return symptomsList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Symptom defaultList = new Symptom(symptomName: "Select Symptoms", weight: 0);

class VirtualDoctor extends StatefulWidget {
  @override
  _VirtualDoctorState createState() => _VirtualDoctorState();
}

class _VirtualDoctorState extends State<VirtualDoctor> {
  Future<List<Symptom>> symptoms;
  List<Symptom> selectedSymptoms = new List();
  List<Symptom> symptomsList = new List();

  int count = 1;

  @override
  void initState() {
    super.initState();
    symptoms = fetchSymptoms();
    symptoms.whenComplete(() => symptoms.then((value) {
          setState(() {
            selectedSymptoms.add(defaultList);
            symptomsList = value;
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: symptomsList.length != 0
            ? SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyHeader(
                          image: "assets/images/doctor4.png",
                          textTop: "Hey, Are you feeling sick?",
                          textBottom: "Let me help out!",
                          width: 160),
                      Expanded(
                        child: selectedSymptoms.length != 0
                            ? ListView.builder(
                                itemCount: count,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        padding: EdgeInsets.only(left: 10),
                                        decoration: ShapeDecoration(
                                          color: Colors.white54,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 5.0,
                                                style: BorderStyle.solid,
                                                color: Color(0xff073763)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedSymptoms[index]
                                              .symptomName,
                                          iconSize: 32,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              int weight;
                                              for (int i = 0;
                                                  i < symptomsList.length;
                                                  i++) {
                                                if (symptomsList[i]
                                                        .symptomName ==
                                                    newValue) {
                                                  weight =
                                                      symptomsList[i].weight;
                                                  selectedSymptoms[index] =
                                                      new Symptom(
                                                          weight: weight,
                                                          symptomName:
                                                              newValue);
                                                  break;
                                                }
                                              }
                                            });
                                          },
                                          items: symptomsList
                                              .map<DropdownMenuItem<String>>(
                                                  (Symptom value) {
                                            return DropdownMenuItem<String>(
                                              value: value.symptomName,
                                              child: Text(value.symptomName),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          size: 34,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            count = count - 1;
                                            selectedSymptoms.remove(
                                                selectedSymptoms[index]);
                                          });
                                        },
                                      )
                                    ],
                                  );
                                },
                              )
                            : SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            "assets/icons/smile.png"),
                                        width: 80,
                                      ),
                                      Text(
                                        " It's  good",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "You are healthy.",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "If not ",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "tell  us  the",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "symptoms.",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 50,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: Color(0xffEE7B23),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                              child: Text('Add',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      color: Colors.white70)),
                            ),
                            onTap: () {
                              if (count >= 17) {
                                Toast.show("No more symptoms.", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Color(0xD0073763));
                                return;
                              }
                              setState(() {
                                selectedSymptoms.add(defaultList);
                                count = count + 1;
                              });
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 50,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: Color(0xffEE7B23),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                              child: Text('Lets Find out!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      color: Colors.white70)),
                            ),
                            onTap: () {
                              List<Symptom> symptomsToSend = new List();
                              for (int i = 0;
                                  i < selectedSymptoms.length;
                                  i++) {
                                if (selectedSymptoms[i].symptomName !=
                                    defaultList.symptomName)
                                  symptomsToSend.add(selectedSymptoms[i]);
                              }
                              if (symptomsToSend.length != 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Precautions(
                                              selectedSymptoms: symptomsToSend,
                                            )));
                                setState(() {
                                  count = 1;
                                  selectedSymptoms.clear();
                                  selectedSymptoms.add(defaultList);
                                });
                              } else {
                                Toast.show(
                                    "Please select symptoms you are suffering",
                                    context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Color(0xD0073763));
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : Container(
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ));
  }
}
