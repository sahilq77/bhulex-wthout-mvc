// To parse this JSON data, do
//
//     final attemptedtestquestiondetailcall = attemptedtestquestiondetailcallFromJson(jsonString);

import 'dart:convert';

Attemptedtestquestiondetailcall attemptedtestquestiondetailcallFromJson(
        String str) =>
    Attemptedtestquestiondetailcall.fromJson(json.decode(str));

String attemptedtestquestiondetailcallToJson(
        Attemptedtestquestiondetailcall data) =>
    json.encode(data.toJson());

class Attemptedtestquestiondetailcall {
  String loginId;
  String testId;
  String attemptedTestId;
  String parentModule;
  String questionStatus;

  Attemptedtestquestiondetailcall({
    required this.loginId,
    required this.testId,
    required this.attemptedTestId,
    required this.parentModule,
    required this.questionStatus,
  });

  factory Attemptedtestquestiondetailcall.fromJson(Map<String, dynamic> json) =>
      Attemptedtestquestiondetailcall(
        loginId: json["login_id"],
        testId: json["test_id"],
        attemptedTestId: json["attempted_test_id"],
        parentModule: json["parent_module"],
        questionStatus: json["question_status"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "test_id": testId,
        "attempted_test_id": attemptedTestId,
        "parent_module": parentModule,
        "question_status": questionStatus,
      };
}
