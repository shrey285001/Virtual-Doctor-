import 'dart:io';

import 'package:VirtualDoctor/UI/SymptomsValidator/Diabetes.dart';
import 'package:VirtualDoctor/UI/SymptomsValidator/HeartDisease.dart';
import 'package:VirtualDoctor/UI/SymptomsValidator/MalariaForm.dart';
import 'package:VirtualDoctor/UI/SymptomsValidator/TuberculosisForm.dart';
import 'package:VirtualDoctor/UI/widgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SymptomsValidator extends StatefulWidget {
  @override
  _SymptomsValidatorState createState() => _SymptomsValidatorState();
}

class _SymptomsValidatorState extends State<SymptomsValidator> {
  List<String> diseaseList = [
    "Select disease",
    "Malaria",
    "Diabetes",
    "Tuberculosis",
    "Heart Disease"
  ];
  String selectedDisease = "Select disease";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeader(
                  image: "assets/images/doctor6.png",
                  textTop: "Lets Check Do",
                  textBottom: "you have symptoms?",
                  width: 120),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: width * 0.85,
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
                  value: selectedDisease,
                  iconSize: 26,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                  onChanged: (String newValue) async {
                    setState(() {
                      selectedDisease = newValue;
                    });
                  },
                  items:
                      diseaseList.map<DropdownMenuItem<String>>((String value) {
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
              selectedDisease == "Heart Disease"
                  ? HeartDiseaseForm()
                  : selectedDisease == "Malaria"
                      ? MalariaForm()
                      : selectedDisease == "Tuberculosis"
                          ? TuberCulosisForm()
                          : selectedDisease == "Diabetes"
                              ? DiabetesForm()
                              : Container()
            ],
          ),
        ),
      ),
    );
  }
}
