import 'package:flutter_appmockup/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

/// Create Widget
class Map extends StatelessWidget {
  Widget build(BuildContext context) {

    /// Add Flutter_Map to widget
    return new FlutterMap(

      /// Set Initial Map properties
      options: new MapOptions(
        center: curCoordinates,
        zoom: 15.0,
      ),

      /// Request OpenStreetMap for Layer
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",

            subdomains: ['a', 'b', 'c']
        ),

        /// Add Marker Layer
        new MarkerLayerOptions(
          markers: [

            /// Add marker to layer
            // Default for now
            new Marker(

              // Marker properties
              width: 80.0,
              height: 80.0,
              point: curCoordinates,

              // Marker icon
              builder: (ctx) =>
              new Container(
                child: new Icon(Icons.add_location),
              ),

            ),
          ],
        ),
      ],
    );
  }
}