// To parse this JSON data, do
//
//     final mocktestcall = mocktestcallFromJson(jsonString);

import 'dart:convert';

Mocktestcall mocktestcallFromJson(String str) =>
    Mocktestcall.fromJson(json.decode(str));

String mocktestcallToJson(Mocktestcall data) => json.encode(data.toJson());

class Mocktestcall {
  String loginId;
  int limit;
  int offset;

  Mocktestcall({
    required this.loginId,
    required this.limit,
    required this.offset,
  });

  factory Mocktestcall.fromJson(Map<String, dynamic> json) => Mocktestcall(
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
