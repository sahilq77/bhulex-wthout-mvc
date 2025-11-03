// To parse this JSON data, do
//
//     final docvideotestcall = docvideotestcallFromJson(jsonString);

import 'dart:convert';

Docvideotestcall docvideotestcallFromJson(String str) =>
    Docvideotestcall.fromJson(json.decode(str));

String docvideotestcallToJson(Docvideotestcall data) =>
    json.encode(data.toJson());

class Docvideotestcall {
  String loginId;
  int limit;
  int offset;

  Docvideotestcall({
    required this.loginId,
    required this.limit,
    required this.offset,
  });

  factory Docvideotestcall.fromJson(Map<String, dynamic> json) =>
      Docvideotestcall(
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
