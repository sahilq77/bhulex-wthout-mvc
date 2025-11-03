// To parse this JSON data, do
//
//     final getdistrictcall = getdistrictcallFromJson(jsonString);

import 'dart:convert';

Getdistrictcall getdistrictcallFromJson(String str) =>
    Getdistrictcall.fromJson(json.decode(str));

String getdistrictcallToJson(Getdistrictcall data) =>
    json.encode(data.toJson());

class Getdistrictcall {
  String stateId;

  Getdistrictcall({
    required this.stateId,
  });

  factory Getdistrictcall.fromJson(Map<String, dynamic> json) =>
      Getdistrictcall(
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
      };
}
