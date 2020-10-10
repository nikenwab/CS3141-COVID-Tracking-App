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
        new CircleLayerOptions(circles: [
          new CircleMarker(
            point: LatLng(47.106630, -88.589029),
            radius: 26.0,
            color: Color(0x70FF9504),
          ),
          new CircleMarker(
            point: LatLng(47.106630, -88.589029),
            radius: 19.0,
            color: Color(0x70FF9504),
          ),
        ]),
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
      ],
    );
  }
}
