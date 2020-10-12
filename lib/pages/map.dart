import 'package:flutter_appmockup/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class Map extends StatelessWidget {
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: curCoordinates,
        zoom: 15.0,
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
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

        // Begin Heatmap Code

        // Each layer has two transparent circles inside of each other
        // This creates the effect of a heatmap

        // Example Layer 1: Walmart
        new CircleLayerOptions(circles: [
          new CircleMarker(
            // Lat-long should be the same for both CircleMarkers in the layer
            point: LatLng(47.106630, -88.589029),
            // The radius of the outer circle (should be larger than inner)
            radius: 26.0,
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
            radius: 19.0,
            // See color notes above
            color: Color(0x70FF9504),
          ),
        ]),

        // Example Layer 2: Applebees
        // See comments on Example Layer 1 for details
        new CircleLayerOptions(circles: [
          new CircleMarker(
            point: LatLng(47.108655, -88.588764),
            radius: 20.0,
            color: Color(0x70ffee04),
          ),
          new CircleMarker(
            point: LatLng(47.108655, -88.588764),
            radius: 10.0,
            color: Color(0x70ffee04),
          ),
        ]),

        // Example Layer 3: Gas station
        // See comments on Example Layer 1 for details
        new CircleLayerOptions(circles: [
          new CircleMarker(
            point: LatLng(47.108005, -88.589118),
            radius: 10.0,
            color: Color(0x70ffee04),
          ),
          new CircleMarker(
            point: LatLng(47.108005, -88.589118),
            radius: 5.0,
            color: Color(0x70ffee04),
          ),
        ]),

        // End heatmap code
      ],
    );
  }
}
