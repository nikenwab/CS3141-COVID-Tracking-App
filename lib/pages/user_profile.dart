import 'package:flutter/material.dart';
import 'package:hotspot_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:hotspot_app/pages/map.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  /// Sets status string according to status boolean
  void _checkStatus() {
    if (status == false) {
      statusStr = 'Positive';
      status = true;
    } else {
      statusStr = 'Negative';
      status = false;
    }
  }

  /// Request current location and convert to LatLng object
  Future<void> _getCoordinates() async {
    //position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    position = await Geolocator.getCurrentPosition();
    curCoordinates = LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/frame_02_delay-0.05s.jpg'),
              radius: 30,
            ),
            SizedBox(height: 20),
            Text(
              'Name: ',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$usrName',
              style: TextStyle(
                color: Colors.blueAccent,
                letterSpacing: 1.5,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Current Status: ',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    )),
                textStatus(),
              ]),
            ),

            /// Change COVID status button
            SizedBox(height: 20),
            RaisedButton.icon(
              onPressed: () {
                setState(() {
                  _checkStatus();
                });
              },
              icon: Icon(
                Icons.warning,
              ),
              label: Text(
                'Update COVID Status',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.grey,
            ),

            /// Display text for coordinates
            SizedBox(height: 20),
            Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'Current Coordinates: ',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '[${position.latitude}, ${position.longitude}]',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),

            /// Update Coordinates button
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () {
                setState(() {
                  _getCoordinates();
                });
              },
              icon: Icon(
                Icons.add_location,
              ),
              label: Text(
                'Update Location',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.grey,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
