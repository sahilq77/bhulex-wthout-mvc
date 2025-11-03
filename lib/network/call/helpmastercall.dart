// To parse this JSON data, do
//
//     final helpmastercall = helpmastercallFromJson(jsonString);

import 'dart:convert';

Helpmastercall helpmastercallFromJson(String str) =>
    Helpmastercall.fromJson(json.decode(str));

String helpmastercallToJson(Helpmastercall data) => json.encode(data.toJson());

class Helpmastercall {
  int type;

  Helpmastercall({
    required this.type,
  });

  factory Helpmastercall.fromJson(Map<String, dynamic> json) => Helpmastercall(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
