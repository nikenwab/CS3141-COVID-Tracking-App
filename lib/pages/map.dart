import 'dart:async';

import 'package:flutter_appmockup/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_location/user_location.dart';

Position position = new Position(longitude: -88.545214, latitude: 47.115992);
LatLng curCoordinates = LatLng(47.114992, -88.545214);

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

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
  StreamController<LatLng> markerLocationStream = StreamController();

  //Simple method to know if a callback function has been executed
  onTapFAB(){
    print('helloworld');
    userLocationOptions.updateMapLocationOnPositionChange = true;
  }

  Widget build(BuildContext context) {
  //Checks for changes in position
    markerLocationStream.stream.listen((onData){

    });
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
      onLocationUpdate: (LatLng pos) =>
          print("onLocationUpdate ${pos.toString()}"),
      //more developer options
      updateMapLocationOnPositionChange: false,
      showMoveToCurrentLocationFloatingActionButton: true,
      moveToCurrentLocationFloatingActionButton:
        IconButton(
          icon: Icon(Icons.my_location),
              onPressed: () {
            setState(() {
              userLocationOptions.updateMapLocationOnPositionChange = true;
            });
              },
        ),
      zoomToCurrentLocationOnLoad: true,
      fabBottom: 50,
      fabRight: 50,
      verbose: false,
      locationUpdateInBackground: true,
      locationUpdateIntervalMs: 5000
    );
    //userLocationOptions.updateMapLocationOnPositionChange = false;

    //locks map to a specific location
    //userLocationOptions.updateMapLocationOnPositionChange = true;

    return new FlutterMap(
      options: new MapOptions(
        center: curCoordinates,
        zoom: 15.0,
        plugins: [
          UserLocationPlugin()
        ],
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        new MarkerLayerOptions(
          markers:
          markers,
        ),
        userLocationOptions,

        // Begin heat map Code

        // Each layer has two transparent circles inside of each other
        // This creates the effect of a heat map

        // Example Layer 1: Walmart
        new CircleLayerOptions(circles: [
          new CircleMarker(
            // Lat-long should be the same for both CircleMarkers in the layer
            point: LatLng(47.106630, -88.589029),
            // The radius of the outer circle (should be larger than inner)
            radius: 50.0,
            useRadiusInMeter: true,
            // Each color is in the format 0xAARRGGBB
            // This allows for opacity to be changed
            // You can find appropriate color values using this tool:
            // http://peteroupc.github.io/colorpicker/demo.html
            // Use the fourth item down on the list
            color: Color(0x70FF9504),
          ),
          new CircleMarker(
            // Lat-long should be the same for both CircleMarkers in the layer
            point: LatLng(47.106630, -88.589029),
            // The radius of the inner circle (should be larger than outer)
            radius: 40.0,
            useRadiusInMeter: true,
            // See color notes above
            color: Color(0x70FF9504),
          ),
        ]),

        // Example Layer 2: Applebees
        // See comments on Example Layer 1 for details
        new CircleLayerOptions(circles: [
          new CircleMarker(
            point: LatLng(47.108655, -88.588764),
            radius: 30.0,
            useRadiusInMeter: true,
            color: Color(0x70ffee04),
          ),
          new CircleMarker(
            point: LatLng(47.108655, -88.588764),
            radius: 20.0,
            useRadiusInMeter: true,
            color: Color(0x70ffee04),
          ),
        ]),

        // Example Layer 3: Gas station
        // See comments on Example Layer 1 for details
        new CircleLayerOptions(circles: [
          new CircleMarker(
            point: LatLng(47.108005, -88.589118),
            radius: 20.0,
            useRadiusInMeter: true,
            color: Color(0x70ffee04),
          ),
          new CircleMarker(
            point: LatLng(47.108005, -88.589118),
            radius: 10.0,
            useRadiusInMeter: true,
            color: Color(0x70ffee04),
          ),
        ]),

        // End heat map code
      ],
      mapController: mapController,
    );
  }
  //cleans flutter- must call super, closes listener
  void dispose(){
    markerLocationStream.close();
    dispose();
  }
}
