// To parse this JSON data, do
//
//     final testseriestestcall = testseriestestcallFromJson(jsonString);

import 'dart:convert';

Testseriestestcall testseriestestcallFromJson(String str) =>
    Testseriestestcall.fromJson(json.decode(str));

String testseriestestcallToJson(Testseriestestcall data) =>
    json.encode(data.toJson());

class Testseriestestcall {
  String testId;
  int offset;
  int limit;
  String loginId;

  Testseriestestcall({
    required this.testId,
    required this.offset,
    required this.limit,
    required this.loginId,
  });

  factory Testseriestestcall.fromJson(Map<String, dynamic> json) =>
      Testseriestestcall(
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
