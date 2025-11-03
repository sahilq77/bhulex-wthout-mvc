// To parse this JSON data, do
//
//     final attemptedtestcall = attemptedtestcallFromJson(jsonString);

import 'dart:convert';

Attemptedtestcall attemptedtestcallFromJson(String str) =>
    Attemptedtestcall.fromJson(json.decode(str));

String attemptedtestcallToJson(Attemptedtestcall data) =>
    json.encode(data.toJson());

class Attemptedtestcall {
  String loginId;
  String testId;
  String attemptedTestId;
  String parentModule;

  Attemptedtestcall({
    required this.loginId,
    required this.testId,
    required this.attemptedTestId,
    required this.parentModule,
  });

  factory Attemptedtestcall.fromJson(Map<String, dynamic> json) =>
      Attemptedtestcall(
        loginId: json["login_id"],
        testId: json["test_id"],
        attemptedTestId: json["attempted_test_id"],
        parentModule: json["parent_module"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "test_id": testId,
        "attempted_test_id": attemptedTestId,
        "parent_module": parentModule,
      };
}
