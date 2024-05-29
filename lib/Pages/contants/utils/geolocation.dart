import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class GeoLocationScreen extends StatefulWidget {
  const GeoLocationScreen({super.key});

  @override
  State<GeoLocationScreen> createState() => _GeoLocationScreenState();
}

class _GeoLocationScreenState extends State<GeoLocationScreen> {
  String currentAddress = 'My Address';
   Position? currentPosition ;

  Future<Position>_determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Fluttertoast.showToast(msg: "PLease keep your location on");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        Fluttertoast.showToast(msg: "Location Permission is denied");
    }
  }
    if(permission == LocationPermission.deniedForever){
      Fluttertoast.showToast(msg: "Permission is declined Forever ");
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentPosition = position;
        currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    }catch(e){
      print(e);
    }throw("exception");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: EdgeInsets.all(28.0),
        child: Column(
          children: [
            Text(
              currentAddress,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
            ),
            currentPosition != null ? Text('Latitude: ${currentPosition!.latitude}') : Container(),
            currentPosition != null ? Text('Longitude: ${currentPosition!.longitude}') : Container(),
            TextButton(
              onPressed: () {
                _determinePosition();
              },
              child: Text('Locate Me'),
            ),
          ],
        ),
      ),
    );
  }
}
