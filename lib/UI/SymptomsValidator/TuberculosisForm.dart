import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TuberCulosisForm extends StatefulWidget {
  @override
  _TuberCulosisFormState createState() => _TuberCulosisFormState();
}

class _TuberCulosisFormState extends State<TuberCulosisForm> {
  File imageTuberculosis;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Center(
          child: imageTuberculosis == null
              ? Text('No image selected.')
              : Container(
                  child: Image.file(
                    imageTuberculosis,
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
                getImageFromCamera(2);
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
                getImageFromGallery(2);
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
        )
      ],
    ));
  }

  Future<void> getImageFromCamera(int category) async {
    var temp = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imageTuberculosis = File(temp.path);
    });
  }

  Future<void> getImageFromGallery(int category) async {
    var temp = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageTuberculosis = File(temp.path);
    });
  }
}
