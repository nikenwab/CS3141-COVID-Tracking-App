import 'dart:convert';

import 'package:flutter/foundation.dart';

Location locationFromJson(String str) =>
    Location.fromJson(json.decode(str));

String locationToJson(Location data) =>
    json.encode(data.toJson());

class Location{
  int id;
  double latitude;
  double longitude;
  String date;

  Location({
    @required
    this.latitude,
    @required
    this.longitude,
    @required
    this.date, id
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
        date:  json["date"],
      );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "date": date,
  };
}