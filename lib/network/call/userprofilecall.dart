// To parse this JSON data, do
//
//     final userprofilecall = userprofilecallFromJson(jsonString);

import 'dart:convert';

Userprofilecall userprofilecallFromJson(String str) =>
    Userprofilecall.fromJson(json.decode(str));

String userprofilecallToJson(Userprofilecall data) =>
    json.encode(data.toJson());

class Userprofilecall {
  String userId;

  Userprofilecall({
    required this.userId,
  });

  factory Userprofilecall.fromJson(Map<String, dynamic> json) =>
      Userprofilecall(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
