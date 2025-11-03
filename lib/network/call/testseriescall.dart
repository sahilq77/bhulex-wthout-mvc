// To parse this JSON data, do
//
//     final testseriescall = testseriescallFromJson(jsonString);

import 'dart:convert';

Testseriescall testseriescallFromJson(String str) =>
    Testseriescall.fromJson(json.decode(str));

String testseriescallToJson(Testseriescall data) => json.encode(data.toJson());

class Testseriescall {
  String loginId;
  int offset;
  int limit;

  Testseriescall({
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory Testseriescall.fromJson(Map<String, dynamic> json) => Testseriescall(
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
