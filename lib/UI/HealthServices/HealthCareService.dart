import 'package:VirtualDoctor/UI/HealthServices/HospitalList.dart';
import 'package:VirtualDoctor/UI/widgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HealthCareService extends StatefulWidget {
  @override
  _HealthCareServiceState createState() => _HealthCareServiceState();
}

class _HealthCareServiceState extends State<HealthCareService> {
  String state = 'Select State';
  String city = 'Select City';
  List<String> cityList = ['Select City'];
  List<String> stateList = [
    'Select State',
    'Andhra Pradesh',
    'Assam',
    'Bihar',
    'Chattisgarh',
    'Dadra & Nagar Haveli',
    'Daman & Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu & Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Meghalaya',
    'Odisha',
    'Pondicherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamilnadu',
    'Telangana',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyHeader(
                    image: "assets/images/doctor2.png",
                    textTop: "Localised \n   Health",
                    textBottom: " Services",
                    width: 140,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: width * 0.9,
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
                      value: state,
                      iconSize: 32,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),
                      onChanged: (String newValue) async {
                        if (newValue != 'Select State') {
                          var response = await http.get(
                              "https://raw.githubusercontent.com/himanshuj581/Testjson/main/States.json");
                          if (response.statusCode == 200) {
                            var jsonResponse =
                                convert.jsonDecode(response.body);
                            cityList.clear();
                            cityList.add("Select City");
                            for (int i = 0; i < jsonResponse.length; i++) {
                              if (jsonResponse[i]['State'] == newValue)
                                cityList.add(jsonResponse[i]['City']);
                            }
                          }
                        } else {
                          cityList.clear();
                          cityList.add("Select City");
                        }
                        setState(() {
                          state = newValue;
                        });
                      },
                      items: stateList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: width * 0.9,
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
                      value: city,
                      iconSize: 32,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),
                      onChanged: (String newValue) {
                        setState(() {
                          city = newValue;
                        });
                      },
                      items: cityList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                  ),
                  GestureDetector(
                    child: Container(
                      width: width * 0.9,
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: Color(0xffEE7B23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      child: Text('Search',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0,
                              color: Colors.white70)),
                    ),
                    onTap: () {
                      if (state == 'Select State' && city == 'Select City') {
                        Toast.show("Please select a state and a city", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Color(0xD0073763));
                      } else if (state == 'Select State') {
                        Toast.show("Please select a state", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Color(0xD0073763));
                      } else if (city == 'Select City') {
                        Toast.show("Please select a city", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            backgroundColor: Color(0xD0073763));
                      } else {
                        String a = state, b = city;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HospitalList(
                                      state: a,
                                      city: b,
                                    )));
                        setState(() {
                          state = "Select State";
                          city = "Select City";
                          cityList = ["Select City"];
                        });
                      }
                    },
                  )
                ],
              ),
            )));
  }
}
