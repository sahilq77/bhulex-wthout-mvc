// To parse this JSON data, do
//
//     final exammaterialcall = exammaterialcallFromJson(jsonString);

import 'dart:convert';

Exammaterialcall exammaterialcallFromJson(String str) =>
    Exammaterialcall.fromJson(json.decode(str));

String exammaterialcallToJson(Exammaterialcall data) =>
    json.encode(data.toJson());

class Exammaterialcall {
  String loginId;
  int limit;
  int offset;

  Exammaterialcall({
    required this.loginId,
    required this.limit,
    required this.offset,
  });

  factory Exammaterialcall.fromJson(Map<String, dynamic> json) =>
      Exammaterialcall(
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
