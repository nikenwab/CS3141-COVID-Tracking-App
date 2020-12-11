import 'dart:convert';

import 'package:flutter/foundation.dart';
//This is our location class for storing location to a DB
Location locationFromJson(String str) =>
    Location.fromJson(json.decode(str));

String locationToJson(Location data) =>
    json.encode(data.toJson());
//All location instances have these properties
class Location{
  int id;
  double latitude;
  double longitude;
  String date;
//Constructor
  Location({
    this.id,
    this.latitude,
    this.longitude,
    this.date,
  });
//Gets values from the location instance
  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        date:  json["date"],
      );
//Creates an instance of a map with parameters
  Map<String, dynamic> toJson() => {
    "id": id,
    "latitude": latitude,
    "longitude": longitude,
    "date": date,
  };
}