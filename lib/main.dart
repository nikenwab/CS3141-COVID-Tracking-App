import 'package:flutter/material.dart';
import 'package:hotspot_app/pages/home.dart';
import 'package:hotspot_app/pages/user_profile.dart';
import 'package:hotspot_app/pages/map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:hotspot_app/DB/locationDB.dart';
// BA5200 stuff
import 'package:hotspot_app/pages/Casemap.dart';
import 'package:hotspot_app/pages/Dailychecklist.dart';
import 'package:hotspot_app/pages/Findatestingcenter.dart';
import 'package:hotspot_app/pages/Sanitation.dart';
import 'package:hotspot_app/pages/XDCasestatistics.dart';
import 'package:hotspot_app/pages/XDSymptoms.dart';
import 'package:hotspot_app/pages/LiveChat.dart';
import 'package:hotspot_app/pages/Login.dart';

import 'DB/location.dart';

String usrName = "Gilligan the Parrot";
bool status = false;

//Initialization variables
//Temp user profiles gilligan
//stores covid status bool
String statusStr = 'Negative';
//Instance of location and a temp location list
final locationDB dbManager = new locationDB();
List<Location> locationList = List<Location>();
int updateIndex;

void main() => runApp(myApp());

/// Returns formatted text to determine color of status description
TextSpan textStatus(bool condition, String text) {
  if (condition == true) {
    return TextSpan(
        text: '$text',
        style: TextStyle(
          color: Colors.red,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ));
  } else {
    return TextSpan(
        text: '$text',
        style: TextStyle(
          color: Colors.green,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ));
  }
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  //DB variables
  // Position position = new Position(longitude: -88.545214, latitude: 47.115992);
  // LatLng curCoordinates = LatLng(47.114992, -88.545214);
  // Location location = new Location(id: 0,latitude: 47.115992, longitude: -88.545214,date: DateTime.now().toString());
  Position position;
  LatLng curCoordinates;
  Location location = Location();

//These are all of the pages that will be available to users

  int index = 0;
  List<Widget> list = [
    Home(),
    UserProfile(),
    Map(),
    Dailychecklist(),
    Findatestingcenter(),
    Sanitation(),
    XDCasestatistics(),
    XDSymptoms(),
    LiveChat(),
    Login(),
  ];

  List<String> navBarText = [
    'Home',
    'User Profile',
    'Map',
    'Daily Checklist',
    'Find a Testing Center',
    'Sanitation Supplies',
    'Case Statistics',
    'COVID-19 Symptoms',
    'Live Chat',
    'Login',
  ];
//Grabs the location at the current moment in time and returns a position variable
  Future<Position> locateDevice() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }
    return position;
  }

  //simply updates location
  _getCurrentLocation() async {
    position = await locateDevice();
    setState(() {
      curCoordinates = LatLng(position.latitude, position.longitude);
    });
  }

  //recursive method to store coordinates every 15 min
  void _timer() {
    Future.delayed(Duration(minutes: 15)).then((_) async {
      //Checks that status is true
      if (status == false) {
        _getCurrentLocation();
        locationList = await dbManager.getLocationList();
        int tempIndex = locationList.length;
        //The number of iterations in 2 weeks
        if (updateIndex >= 1344) {
          updateIndex = 0;
        }

        //if the data is less than 2 weeks old begin updating
        if (tempIndex <= 1344) {
          Location lo = new Location(
              latitude: position.latitude,
              longitude: position.longitude,
              date: DateTime.now().toString());
          setState(() {
            location = lo;
            locationList.add(lo);
            print("location added>>  ${locationList[updateIndex].latitude}");
          });
        }
        //if the data is more than 2 weeks old begin updating
        else if (tempIndex >= 1344) {
          print(updateIndex);
          print(await dbManager.getLocationList().toString());
          dbManager.updateLocation(locationList[updateIndex]).then((id) => {
                setState(() {
                  print("db updated>> ");
                  updateIndex++;
                }),
                location = null,
              });
        }
        setState(() {
          print("timer check passed");
        });
      }
      _timer();
    });
  }

//Initialize the app and begin recursive timer method
  @override
  Future<void> initState() {
    super.initState();
    updateIndex = 0;
    _getCurrentLocation();
    _timer();
    print("initStateSuccess");
  }

//Our build function to create a drawer with page navigation
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(navBarText[index]),
          backgroundColor: Color(0xFF1956B4),
          centerTitle: true,
        ),
        body: list[index],
        drawer: MyDrawer(
          onTap: (ctx, i) {
            setState(() {
              //_getCoordinates();
              //print(position.latitude);
              index = i;
              Navigator.pop(ctx);
            });
          },
        ),
      ),
      //UserProfile(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;
  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black54),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/frame_02_delay-0.05s.jpg'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Gilligan The Parrot',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Current Status: ',
                                style: TextStyle(color: Colors.grey)),
                            textStatus(status, statusStr),
                          ],
                        ),
                      )
                    ]),
              ),
            ),

            /// Opens Home screen
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => onTap(context, 0),
            ),

            /// Opens Profile screen
            ListTile(
              leading: Icon(Icons.portrait),
              title: Text('User Profile'),
              onTap: () => onTap(context, 1),
            ),

            /// Opens Map screen
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              onTap: () => onTap(context, 2),
            ),

            /// Opens Daily Checklist screen
            ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text('Daily Checklist'),
              onTap: () => onTap(context, 3),
            ),

            /// Opens Testing Center screen
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Find a Testing Center'),
              onTap: () => onTap(context, 4),
            ),

            /// Opens Sanitation screen
            ListTile(
              leading: Icon(Icons.hot_tub),
              title: Text('Sanitation Supplies'),
              onTap: () => onTap(context, 5),
            ),

            /// Opens XD Case Statistics screen
            ListTile(
              leading: Icon(Icons.assessment_outlined),
              title: Text('Case Statistics'),
              onTap: () => onTap(context, 6),
            ),

            /// Opens XD Symptoms screen
            ListTile(
              leading: Icon(Icons.device_thermostat),
              title: Text('COVID-19 Symptoms'),
              onTap: () => onTap(context, 7),
            ),

            /// Opens XD Symptoms screen
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Live Chat'),
              onTap: () => onTap(context, 8),
            ),

            /// Opens XD Symptoms screen
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('Login'),
              onTap: () => onTap(context, 9),
            ),
          ],
        )));
  }
}
