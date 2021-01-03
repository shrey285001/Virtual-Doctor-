import 'dart:convert';
import 'package:VirtualDoctor/UI/HealthServices/HospitalMap.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Hospital {
  final String state;
  final String city;
  final String hospitalId;
  final String hospitalName;
  final String address;
  final String pincode;
  final String phoneNo;
  final String mobile;
  final String fax;
  final String contactPerson;
  final String email;
  final String longitude;
  final String latitude;

  Hospital(
      {this.state,
      this.city,
      this.hospitalId,
      this.hospitalName,
      this.address,
      this.phoneNo,
      this.pincode,
      this.mobile,
      this.fax,
      this.contactPerson,
      this.email,
      this.latitude,
      this.longitude});
}

Future<List<Hospital>> fetchHospitalList() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/himanshuj581/Testjson/main/db.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("123");
    List responseJson = json.decode(response.body.toString());
    print("456");
    List<Hospital> healthTipList = createHospitalList(responseJson);
    print("789");
    return healthTipList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

List<Hospital> createHospitalList(List data) {
  List<Hospital> list = new List();
  for (int i = 0; i < data.length; i++) {
    String state = data[i]["State"].toString();
    String city = data[i]["City"].toString();
    String hospitalId = data[i]["Hospital ID"].toString();
    String hospitalName = data[i]["Hospital Name"].toString();
    String address = data[i]["Address"].toString();
    String pincode = data[i]["Pin Code"].toString();
    String phoneNo = data[i]["Phone No."].toString();
    String mobile = data[i]["Mobile"].toString();
    String fax = data[i]["Fax"].toString();
    String contactPerson = data[i]["Contact Perso"].toString();
    String email = data[i]["Email"].toString();
    String longitude = data[i]["LATITUDE"].toString();
    String latitude = data[i]["LATITUDE"].toString();

    Hospital a = new Hospital(
        state: state,
        city: city,
        hospitalId: hospitalId,
        hospitalName: hospitalName,
        address: address,
        pincode: pincode,
        phoneNo: phoneNo,
        mobile: mobile,
        fax: fax,
        contactPerson: contactPerson,
        email: email,
        latitude: latitude,
        longitude: longitude);
    list.add(a);
  }
  return list;
}

class HospitalList extends StatefulWidget {
  final String state;
  final String city;
  const HospitalList({
    Key key,
    this.state,
    this.city,
  }) : super(key: key);
  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  Future<List<Hospital>> hospitalList;

  void initState() {
    super.initState();
    hospitalList = fetchHospitalList();
  }

  var hospitals = new List();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String state = widget.state;
    String city = widget.city;
    if (city.length + state.length > 25) {
      if (city.length > 14) {
        city = city.substring(0, 14) + '.';
      }
      if (state.length > 14) {
        state = state.substring(0, 14) + '.';
      }
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Color(0xff073763),
        ),
        backgroundColor: Color(0xFFedeeef),
        body: Container(
          width: width,
          height: height,
          margin: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: width * .98,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFedeeef),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(width: 2, height: 36, color: Color(0xFFedeeef)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      city,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFedeeef),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xff073763),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Hospital>>(
                  future: hospitalList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return snapshot.data[index].state == state &&
                                    snapshot.data[index].city == city
                                ? hospitalCard(snapshot.data[index])
                                : Container();
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget hospitalCard(Hospital data) {
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 190,
          width: MediaQuery.of(context).size.width * 0.98,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/123.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.hospitalId,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                data.hospitalName,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  elevation: 200,
                  content: Stack(
                    overflow: Overflow.clip,
                    children: [
                      Container(
                        height: 350,
                        width: MediaQuery.of(context).size.width * 0.98,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/hospital.jpg"),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data.hospitalId,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data.hospitalName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data.address,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "Pincode  " + data.pincode,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Text(
                                  data.phoneNo.toString().length > 25
                                      ? data.phoneNo.toString().substring(0, 25)
                                      : data.phoneNo.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mail, size: 20, color: Colors.white),
                                Text(
                                  data.email.toString().length > 25
                                      ? data.email.toString().substring(0, 25)
                                      : data.email.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Location",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onTap: () {
                                  if (double.tryParse(data.latitude) != null &&
                                      double.tryParse(data.longitude) != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HospitalMap(
                                                  latitude: double.tryParse(
                                                      data.latitude),
                                                  longitude: double.tryParse(
                                                      data.longitude),
                                                  name: data.hospitalName,
                                                )));
                                  } else {
                                    Toast.show(
                                        "Location Not Available", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Color(0xD0073763));
                                  }
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }
}
