import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String name;
  const HospitalMap({Key key, this.latitude, this.longitude, this.name})
      : super(key: key);
  @override
  _HospitalMapState createState() => _HospitalMapState();
}

class _HospitalMapState extends State<HospitalMap> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double latitude = widget.latitude;
    double longitude = widget.longitude;
    LatLng location = LatLng(latitude, longitude);
    Set<Marker> marker = {
      Marker(
          icon: BitmapDescriptor.fromAsset('assets/icons/hospitalIcon.png'),
          markerId: MarkerId('myMarker'),
          draggable: false,
          position: location)
    };
    return Scaffold(
      backgroundColor: Color(0xFFD4D4D4),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              markers: marker,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: location,
                zoom: 15.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: 10, top: MediaQuery.of(context).size.height * 0.83),
            width: MediaQuery.of(context).size.width * 0.94,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: Color(0xff073763),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
