// To parse this JSON data, do
//
//     final testseriessinglecall = testseriessinglecallFromJson(jsonString);

import 'dart:convert';

Testseriessinglecall testseriessinglecallFromJson(String str) =>
    Testseriessinglecall.fromJson(json.decode(str));

String testseriessinglecallToJson(Testseriessinglecall data) =>
    json.encode(data.toJson());

class Testseriessinglecall {
  String testId;
  String loginId;

  Testseriessinglecall({
    required this.testId,
    required this.loginId,
  });

  factory Testseriessinglecall.fromJson(Map<String, dynamic> json) =>
      Testseriessinglecall(
        testId: json["test_id"],
        loginId: json["login_id"],
      );

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "login_id": loginId,
      };
}
