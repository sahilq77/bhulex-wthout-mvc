// To parse this JSON data, do
//
//     final exammaterialsubjectcall = exammaterialsubjectcallFromJson(jsonString);

import 'dart:convert';

Exammaterialsubjectcall exammaterialsubjectcallFromJson(String str) =>
    Exammaterialsubjectcall.fromJson(json.decode(str));

String exammaterialsubjectcallToJson(Exammaterialsubjectcall data) =>
    json.encode(data.toJson());

class Exammaterialsubjectcall {
  String loginId;
  int limit;
  int offset;

  Exammaterialsubjectcall({
    required this.loginId,
    required this.limit,
    required this.offset,
  });

  factory Exammaterialsubjectcall.fromJson(Map<String, dynamic> json) =>
      Exammaterialsubjectcall(
        loginId: json["login_id"],
        limit: json["limit"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "limit": limit,
        "offset": offset,
      };
}
