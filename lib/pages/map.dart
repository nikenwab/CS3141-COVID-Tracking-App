import 'dart:async';

import 'package:hotspot_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool loaded = false;

class Map extends StatefulWidget {
  // Build the stateful widget for Map
  // This allows for code to run asynchronously
  @override
  _MapState createState() {
    return new _MapState();
  }
}

// Sample center position
Position position = new Position(longitude: -88.545214, latitude: 47.115992);
LatLng curCoordinates = LatLng(47.114992, -88.545214);

class _MapState extends State<Map> {
  // Stores the JSON list of coordinates
  // TODO - figure out the right datatype
  List<dynamic> _coordList = [];

  //map controller plugin
  //This plugin allows for a mapstate implementation for specific options such
  //as updating location for a time interval
  MapController mapController = MapController();
  //another plugin class that creates methods for user map options
  UserLocationOptions userLocationOptions;
  //List to hold marker value
  List<Marker> markers = [];
  //A stream controller is a class apart of the plugin that allows for reading
  //new location values and making them available for use
  StreamController<LatLng> markerLocationStream = StreamController.broadcast();

  //Simple method to know if a callback function has been executed
  onTapFAB() {
    print('helloworld');
    userLocationOptions.updateMapLocationOnPositionChange = true;
  }

  // Calls the backend server to get the coordinate list
  // This will ultimately have parameters for what section of map to use
  Future<List<dynamic>> getCoords() async {
    print("Getting coords...");
    final response = await http.get("http://ba52002020.mis.sbe.mtu.edu/coords");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON and return the list
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // Builds the CircleMarkers needed for the heatmap
  List<Marker> buildHeatmap(input) {
    // The data coming in should be formatted like this:
    // final input = [
    //   {"id": 0, "latitude": 47.10663, "longitude": -88.589029},
    //   {"id": 1, "latitude": 47.108655, "longitude": -88.588764},
    //   {"id": 2, "latitude": 47.108005, "longitude": -88.589118}
    // ];
    List<Marker> markerList = [];

    // Iterate through all objects in list
    // TODO for scalability: we will need to write the backend such that it only
    // returns a sensible number of points at a time, within some margin of the
    // user's screen area.
    // When the user pans outside of the area, we'll make another API call
    for (var i = 0; i < input.length; i++) {
      // Build a LatLng of the current point in the array
      final point =
          LatLng(input[i].values.elementAt(1), input[i].values.elementAt(2));

      // Adds marker to global markerList
      markerList.add(new Marker(
        width: 25.0,
        height: 25.0,
        point: point,
        builder: (ctx) => new Container(
          child: new ClipOval(
              child: Container(
            width: 25.0,
            height: 25.0,
            color: Color(0x88ff3838),
          )),
        ),
      ));
    }
    return markerList;
  }

  showAlertDialog(BuildContext context, Text title, Text message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      }, // dismiss dialog
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: title,
      content: message,
      actions: [
        okButton,
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

  Widget build(BuildContext context) {
    // Attempt to get coordinates from backend server / db
    if (!loaded) {
      getCoords()
          .then((res) => setState(() {
                // Update the list of coordinates based on backend call
                _coordList = res;
              }))
          .catchError((err) => showAlertDialog(
              context,
              Text('Network Error'),
              Text(
                  'Could not retrieve points. Check your Internet connection.')));
      loaded = true;
    } else {
      print("Loaded");
    }

    //Checks for changes in position
    markerLocationStream.stream.listen((onData) {});
    //creates an instance of location options
    userLocationOptions = UserLocationOptions(
        context: context,
        //creates an instance of a map controller
        mapController: mapController,
        markers: markers,
        // [
        //   new Marker(
        //     width: 80.0,
        //     height: 80.0,
        //     point: curCoordinates,
        //     builder: (ctx) => new Container(
        //       child: new Icon(Icons.add_location),
        //     ),
        //   ),
        // ],
        //Prints location to the console every interval
        //*******************onLocationUpdate: (LatLng pos) =>
            //***************print("onLocationUpdate ${pos.toString()}"),
        //more developer options
        updateMapLocationOnPositionChange: false,
        showMoveToCurrentLocationFloatingActionButton: true,
        moveToCurrentLocationFloatingActionButton: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              loaded = false;
              userLocationOptions.updateMapLocationOnPositionChange = true;
            });
          },
        ),
        zoomToCurrentLocationOnLoad: true,
        fabBottom: 50,
        fabRight: 50,
        verbose: false,
        locationUpdateInBackground: true,
        locationUpdateIntervalMs: 5000);
    //userLocationOptions.updateMapLocationOnPositionChange = false;

    //locks map to a specific location
    //userLocationOptions.updateMapLocationOnPositionChange = true;

    return new FlutterMap(
      options: new MapOptions(
          center: curCoordinates,
          zoom: 15.0,
          plugins: [MarkerClusterPlugin(), UserLocationPlugin()]),
      layers: [
        // Load map
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),

        // Current location point
        new MarkerLayerOptions(
          markers: markers,
        ),
        userLocationOptions,

        // Generate all heatmap markers based on what is currently in coordList
        // new CircleLayerOptions(circles: buildHeatmap(_coordList)),
        //
        //  TEST LAYER USING MARKERLIST
        //
        // Marker Cluster Layer
        new MarkerClusterLayerOptions(

            // Determines cluster radius
            maxClusterRadius: 50,
            disableClusteringAtZoom: 0,

            // Size needs to be larger than children
            // so that marker can "grow" on cluster
            size: Size(150, 150),

            // Uses builder function to populate list
            markers: buildHeatmap(_coordList),

            // Disables polygon on marker tap
            showPolygon: false,
            builder: (context, markers) {
              // Floating button on marker
              return new Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              );
              /* return new FloatingActionButton(

                // Disables shadows for FAB
                elevation: 0,
                disabledElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,

                // Makes FAB transparent
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                splashColor: Colors.transparent,

                // Circle clip for Container
                child: ClipOval(

                    // Container for Heatmap Circle
                    child: Container(
                  color: Color(0x88ff3838),

                  // Size dependent on cluster size

                  width: ((15 * markers.length.toDouble())),
                  height: ((15 * markers.length.toDouble())),
                )),

                // On Press action
                onPressed: null,
              ); */
            }),
      ],
      mapController: mapController,
    );
  }

  //cleans flutter- must call super, closes listener
  void dispose() {
    markerLocationStream.close();
    super.dispose();
  }
}
