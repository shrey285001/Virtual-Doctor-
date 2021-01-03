import 'dart:io';
import 'dart:math';

import 'package:VirtualDoctor/UI/SymptomsValidator/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MalariaForm extends StatefulWidget {
  @override
  _MalariaFormState createState() => _MalariaFormState();
}

class _MalariaFormState extends State<MalariaForm> {
  File imageMalaria;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Center(
          child: imageMalaria == null
              ? Text('No image selected.')
              : Container(
                  child: Image.file(
                    imageMalaria,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fitHeight,
                  ),
                ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff073763),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Icon(
                    Icons.camera_enhance,
                    color: Colors.white,
                    size: 25,
                  )),
              onTap: () {
                getImageFromCamera();
              },
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff073763),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.white,
                    size: 25,
                  )),
              onTap: () {
                getImageFromGallery();
              },
            ),
          ],
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Result(
                          res: ((new Random()).nextInt(100) % 2).toString(),
                          disease: "Malaria",
                        )));
          },
        )
      ],
    ));
  }

  Future<void> getImageFromCamera() async {
    var temp = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imageMalaria = File(temp.path);
    });
  }

  Future<void> getImageFromGallery() async {
    var temp = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageMalaria = File(temp.path);
    });
  }
}
