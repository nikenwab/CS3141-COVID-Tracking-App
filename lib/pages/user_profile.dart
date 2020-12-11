import 'package:flutter/material.dart';
import 'package:hotspot_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:hotspot_app/pages/map.dart';
import 'package:hotspot_app/DB/locationDB.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

bool uploadConsent = false;
String uploadConsentStr = "Location upload consent not provided";

class _UserProfileState extends State<UserProfile> {
  /// Sets status string according to status boolean
  void _checkStatus(BuildContext context) {
    if (status == false) {
      statusStr = 'Positive';
      status = true;
      _consentProcess(context);
    } else {
      statusStr = 'Negative';
      status = false;
    }
  }

  // Toggle consent status string and status boolean
  void _uploadConsentStatus(BuildContext context) {
    if (uploadConsent == false) {
      uploadConsent = true;
      uploadConsentStr = "Location upload consent granted";
    } else {
      uploadConsent = false;
      uploadConsentStr = "Location upload consent not provided";
    }
  }

  // Method to prompt user to confirm consent to location upload
  void _consentProcess(BuildContext context) {
    // Show user choice dialog
    showChoiceDialog(
        context,
        Text('Confirm'),
        Text(
            'Do you consent to location uploading? This will upload the last two weeks of location data and all location data thereafter until you revoke consent and/or change COVID status to negative.'),
        () {
      locationDB().getLocationList().then((data) => {
            print("SENDING: " + json.encode(data)),
            http
                .post("http://ba52002020.mis.sbe.mtu.edu/coords",
                    headers: {
                      "accept": "application/json",
                      "content-type": "application/json"
                    },
                    body: json.encode(data))
                .then((res) => {
                      print("Success: " + res.body),
                    })
                .catchError((err) => {print("Error: " + err.toString())})
          });
      // user agreement callback
      // if uploadConsent was previously false, toggle status
      if (uploadConsent == false)
        setState(() {
          _uploadConsentStatus(context);
        });
    }, () {
      // user disagreement callback
      // if uploadConsent was previously true, toggle status
      if (uploadConsent == true)
        setState(() {
          _uploadConsentStatus(context);
        });
    });
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
                textStatus(status, statusStr),
              ]),
            ),

            /// Change COVID status button
            SizedBox(height: 20),
            RaisedButton.icon(
              onPressed: () {
                setState(() {
                  _checkStatus(context);
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

            // Consent Status
            SizedBox(height: 30),
            Text.rich(
              textStatus(!uploadConsent, uploadConsentStr),
            ),

            /// Change Consent Status button
            if (uploadConsent) ...[
              SizedBox(height: 20),
              RaisedButton.icon(
                onPressed: () {
                  setState(() {
                    _uploadConsentStatus(context);
                  });
                },
                icon: Icon(
                  Icons.thumb_down,
                ),
                label: Text(
                  'Revoke Location Upload Consent',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.grey,
              )
            ],

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

  // Function to display a dialog box with yes or no button
  showChoiceDialog(BuildContext context, Text title, Text message,
      Function yesFn, Function noFn) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No, cancel"),
      onPressed: () {
        Navigator.of(context).pop();
        noFn();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes, allow"),
      onPressed: () {
        Navigator.of(context).pop();
        yesFn();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: title,
      content: message,
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
