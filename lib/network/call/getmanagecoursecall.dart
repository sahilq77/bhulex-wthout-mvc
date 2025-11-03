// To parse this JSON data, do
//
//     final getcoursecall = getcoursecallFromJson(jsonString);

import 'dart:convert';

Getcoursecall getcoursecallFromJson(String str) =>
    Getcoursecall.fromJson(json.decode(str));

String getcoursecallToJson(Getcoursecall data) => json.encode(data.toJson());

class Getcoursecall {
  String loginId;
  int offset;
  int limit;

  Getcoursecall({
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory Getcoursecall.fromJson(Map<String, dynamic> json) => Getcoursecall(
        loginId: json["login_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "offset": offset,
        "limit": limit,
      };
}
