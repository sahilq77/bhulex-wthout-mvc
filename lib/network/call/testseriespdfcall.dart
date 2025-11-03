// To parse this JSON data, do
//
//     final testseriespdfcall = testseriespdfcallFromJson(jsonString);

import 'dart:convert';

Testseriespdfcall testseriespdfcallFromJson(String str) =>
    Testseriespdfcall.fromJson(json.decode(str));

String testseriespdfcallToJson(Testseriespdfcall data) =>
    json.encode(data.toJson());

class Testseriespdfcall {
  String testId;
  int offset;
  int limit;
  String loginId;

  Testseriespdfcall({
    required this.testId,
    required this.offset,
    required this.limit,
    required this.loginId,
  });

  factory Testseriespdfcall.fromJson(Map<String, dynamic> json) =>
      Testseriespdfcall(
        testId: json["test_id"],
        offset: json["offset"],
        limit: json["limit"],
        loginId: json["login_id"],
      );

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "offset": offset,
        "limit": limit,
        "login_id": loginId,
      };
}
