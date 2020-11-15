import 'package:flutter_appmockup/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Temporary list for testing marker cluster function
List<Marker> markerList = [
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.119272, -88.548200),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x88ff3838),
      )),
    ),
  ),
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.119265, -88.548078),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x8832a852),
      )),
    ),
  ),
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.119401, -88.547794),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x88ff3838),
      )),
    ),
  ),
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.119178, -88.547450),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x8832a852),
      )),
    ),
  ),
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.118816, -88.546117),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x88ff3838),
      )),
    ),
  ),
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.118619, -88.545797),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x8832a852),
      )),
    ),
  ),
  new Marker(
    width: 25.0,
    height: 25.0,
    point: LatLng(47.118495, -88.546376),
    builder: (ctx) => new Container(
      child: new ClipOval(
          child: Container(
        width: 25.0,
        height: 25.0,
        color: Color(0x88ff3838),
      )),
    ),
  ),
];

class Map extends StatefulWidget {
  // Build the stateful widget for Map
  // This allows for code to run asynchronously
  @override
  _MapState createState() {
    return new _MapState();
  }
}

class _MapState extends State<Map> {
  // Stores the JSON list of coordinates
  // TODO - figure out the right datatype
  List<dynamic> _coordList = [];

  // The constructor for MapState will attempt to get data from backend
  _MapState() {
    // Call function to call backend
    getCoords()
        .then((res) => setState(() {
              // Update the list of coordinates based on backend call
              _coordList = res;
            }))
        .catchError((err) =>
            // TODO - figure out how to handle the error with a user popup
            print('ERROR: Check your internet connection'));
  }

  // Calls the backend server to get the coordinate list
  // This will ultimately have parameters for what section of map to use
  Future<List<dynamic>> getCoords() async {
    // Temporary server URL for development
    final response = await http.get("http://cs3141.etekweb.net:3000");

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
  // TODO - Allow for variable marker size with point aggregation
  List<Marker> buildHeatmap(input) {
    // The data coming in should be formatted like this:
    // final input = [
    //   {"lat": 47.10663, "lng": -88.589029},
    //   {"lat": 47.108655, "lng": -88.588764},
    //   {"lat": 47.108005, "lng": -88.589118}
    // ];

    // Iterate through all objects in list
    // TODO for scalability: we will need to write the backend such that it only
    // returns a sensible number of points at a time, within some margin of the
    // user's screen area.
    // When the user pans outside of the area, we'll make another API call
    for (var i = 0; i < input.length; i++) {
      // Build a LatLng of the current point in the array
      final point =
          LatLng(input[i].values.elementAt(0), input[i].values.elementAt(1));

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

  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
          center: curCoordinates, zoom: 15.0, plugins: [MarkerClusterPlugin()]),
      layers: [
        // Load map
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),

        // Current location point
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: curCoordinates,
              builder: (ctx) => new Container(
                child: new Icon(Icons.add_location),
              ),
            ),
          ],
        ),

        //
        //  TEST LAYER USING MARKERLIST
        //
        // Marker Cluster Layer
        new MarkerClusterLayerOptions(

            // Determines cluster radius
            maxClusterRadius: 50,
            disableClusteringAtZoom: 20,

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
    );
  }
}
