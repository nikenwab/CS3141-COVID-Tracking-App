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

import 'DB/location.dart';

//Position position = new Position(longitude: -88.545214, latitude: 47.115992);
//LatLng curCoordinates = LatLng(47.114992, -88.545214);
String usrName = "Gilligan the Parrot";
bool status = false;
String statusStr = 'Negative';
final locationDB dbManager = new locationDB();
List<Location> locationList;
int updateIndex;

void main() => runApp(myApp());

/// Returns formatted text to determine color of status description
TextSpan textStatus() {
  if (status == true) {
    return TextSpan(
        text: '$statusStr',
        style: TextStyle(
          color: Colors.red,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ));
  } else {
    return TextSpan(
        text: '$statusStr',
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
  Position position;
  LatLng curCoordinates;
  Location location;

  int index = 0;
  List<Widget> list = [
    Home(),
    UserProfile(),
    Map(),
    Dailychecklist(),
    Findatestingcenter(),
    Sanitation(),
    XDCasestatistics(),
    XDSymptoms()
  ];

  Future<Position> locateDevice() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    }on PlatformException {
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
    print("Location check passed");
  }

  //recursive method to store coordinates every 15 min
  void _timer() {
    Future.delayed(Duration(seconds: 30)).then((_) {
      _getCurrentLocation();
      if (Location == null) {
        Location lo = new Location(latitude: position.latitude, longitude: position.longitude,date: DateTime.now().toString());
        dbManager.insertLocation(lo).then((id)=>{
          print("location recorded>>  ${curCoordinates.latitude}")
        });
      } else {
        // Location.latitude = position.latitude;
        // Location.longitude = curCoordinates.longitude;
        // Location.date = DateTime.now().toString();

        dbManager.updateLocation(location).then((id) => {
          setState((){
            locationList[updateIndex].latitude = curCoordinates.latitude;
            locationList[updateIndex].longitude = curCoordinates.longitude;
            locationList[updateIndex].date = DateTime.now().toString();
          }),
          location = null
        });
      }
      setState(() {

        print("timer check passed");
      });
      _timer();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Nav Bar"),
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
                            textStatus(),
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
              title: Text('Profile'),
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
              leading: Icon(Icons.face),
              title: Text('XD Case Statistics'),
              onTap: () => onTap(context, 6),
            ),

            /// Opens XD Symptoms screen
            ListTile(
              leading: Icon(Icons.add_alarm),
              title: Text('XD Symptoms'),
              onTap: () => onTap(context, 7),
            ),
          ],
        )));
  }
}
