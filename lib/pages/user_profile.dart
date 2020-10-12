import 'package:flutter/material.dart';
import 'package:flutter_appmockup/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  /// Sets status string according to status boolean
  void _checkStatus() {

    /// If COVID status is positive set bool to true
    if (status == false) {
      statusStr = 'Positive';
      status = true;

      /// If COVID status is negative set bool to false
    } else {
      statusStr = 'Negative';
      status = false;
    }
  }

  /// Request current location and convert to LatLng object
  Future<void> _getCoordinates() async {

    /// Call getCurrentPosition from geoLocator plugin
    position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    /// Convert position to native LatLng object
    curCoordinates = LatLng(position.latitude, position.longitude);

  }

  /// Create Widget
  @override
  Widget build(BuildContext context) {

    /// Create scaffold within widget
    return Scaffold(

      /// Create appbar within scaffold
      appBar: AppBar(

        /// Set title text and properties
        title: Text('User Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      /// Create padding style form
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),

        /// Add Column to padded body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// Avatar profile picture
            CircleAvatar(
              backgroundImage: AssetImage('assets/frame_02_delay-0.05s.jpg'),
              radius: 30,
            ),

            /// Create box for Name
            SizedBox(height: 20),
            Text(
              'Name: ',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Display name from usrName String
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

            /// Create text span for status
            SizedBox(height: 30),
        Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Current Status: ',
                  style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  )
              ),
              textStatus(),
              ]
          ),
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
              TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Current Coordinates: ',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '[${position.latitude}, ${position.longitude}',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              ),
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