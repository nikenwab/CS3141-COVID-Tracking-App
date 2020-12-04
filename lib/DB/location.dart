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
    this.id,
    this.latitude,
    this.longitude,
    this.date,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        date:  json["date"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "latitude": latitude,
    "longitude": longitude,
    "date": date,
  };
}