import 'package:flutter/material.dart';
import 'package:hotspot_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:hotspot_app/pages/map.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

bool uploadConsent = false;
bool termsAccepted = false;
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

  MaterialButton _showTerms(BuildContext context) {
    if (!termsAccepted) {
      return MaterialButton(
          height: 50,
          child: Text("View Terms of Usage"),
          color: Colors.amber,
          onPressed: () {

            showPopupWindow(
              context,
              gravity: KumiPopupGravity.center,
              //curve: Curves.elasticOut,
              bgColor: Colors.grey.withOpacity(0.5),
              clickOutDismiss: true,
              clickBackDismiss: true,
              customAnimation: false,
              customPop: false,
              customPage: false,
              underStatusBar: false,
              underAppBar: true,
              offsetX: 0,
              offsetY: 0,
              duration: Duration(milliseconds: 200),
              /*
              onShowStart: (pop) {
                print("showStart");
              },
              onShowFinish: (pop) {
                print("showFinish");
              },
              onDismissStart: (pop) {
                print("dismissStart");
              },
              onDismissFinish: (pop) {
                print("dismissFinish");
              },
              onClickOut: (pop){
                print("onClickOut");
              },
              onClickBack: (pop){
                print("onClickBack");
              },
              */
              childFun: (pop) {
                return Container(

                  key: GlobalKey(),
                  padding: EdgeInsets.all(0),
                  height: 600,
                  width: 350,
                  color: Colors.white,

                  child: Scaffold(

                      appBar: AppBar(
                        title: Text('Terms of Usage'),
                        centerTitle: true,
                        backgroundColor: Colors.blueAccent,
                      ),

                      body: Padding(

                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                          child: Column (
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[

                                Container(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: 300,
                                      height: 400,
                                      child: Text(
                                          "PLEASE READ AND HIT ACCEPT BELOW TO INDICATE YOUR UNDERSTANDING AND ACCEPTANCE OF THE "
                                              "FOLLOWING TERMS\n\n"
                                              "1) You consent to the access to your location via GPS tracking.\n"
                                              "2) By agreeing to participate in this method of determining your location, you consent to the"
                                              " use of your data, generated by any GPS data by this application, to be utilized as they deem "
                                              "necessary, through their normal course of business."
                                      ),
                                    )
                                ),

                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: MaterialButton(
                                    height: 50,
                                    minWidth: 150,
                                    color: Colors.amberAccent,
                                    child: Text("Accept"),

                                    onPressed: () {
                                      setState(() {
                                        termsAccepted = true;
                                      });
                                    },
                                  ),
                                )


                              ]
                          )
                      )
                  ),
                );
              },
            );

          }
      );



    } else {

      return MaterialButton(
          height: 50,
          child: Text("Terms accepted!"),
          color: Colors.amber,
          onPressed: () {
            setState(() {
              _showTerms(context);
            });
            termsAccepted = false;
          }
      );

    }

  }

  KumiPopupWindow popupWindow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 00, 30, 0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              width: 60.0,
              height: 60.0,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: AssetImage(
                    'assets/frame_02_delay-0.05s.jpg',
                  ),
                ),
              ),
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
            SizedBox(height: 20),
            RaisedButton.icon(
              onPressed: () {
                _consentProcess(context);
              },
              icon: Icon(
                Icons.upload_file,
              ),
              label: Text(
                'Toggle Location Upload Consent',
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
            _showTerms(context),
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
