// To parse this JSON data, do
//
//     final getdocsandvideoscall = getdocsandvideoscallFromJson(jsonString);

import 'dart:convert';

Getdocsandvideoscall getdocsandvideoscallFromJson(String str) =>
    Getdocsandvideoscall.fromJson(json.decode(str));

String getdocsandvideoscallToJson(Getdocsandvideoscall data) =>
    json.encode(data.toJson());

class Getdocsandvideoscall {
  String offset;
  String limit;
  String loginId;
  String type;
  String source_type;

  Getdocsandvideoscall({
    required this.offset,
    required this.limit,
    required this.loginId,
    required this.type,
    required this.source_type,
  });

  factory Getdocsandvideoscall.fromJson(Map<String, dynamic> json) =>
      Getdocsandvideoscall(
        offset: json["offset"],
        limit: json["limit"],
        loginId: json["login_id"],
        type: json["type"],
        source_type: json["source_type"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "login_id": loginId,
        "type": type,
        "source_type": source_type
      };
}
