// To parse this JSON data, do
//
//     final testsubmitcall = testsubmitcallFromJson(jsonString);

import 'dart:convert';

Testsubmitcall testsubmitcallFromJson(String str) =>
    Testsubmitcall.fromJson(json.decode(str));

String testsubmitcallToJson(Testsubmitcall data) => json.encode(data.toJson());

class Testsubmitcall {
  String loginId;
  String testId;
  DateTime submittedOn;
  String parent_module;
  List<AnswerList> answerList;
  String attempted_test_id;

  Testsubmitcall({
    required this.loginId,
    required this.testId,
    required this.submittedOn,
    required this.parent_module,
    required this.answerList,
    required this.attempted_test_id,
  });

  factory Testsubmitcall.fromJson(Map<String, dynamic> json) => Testsubmitcall(
        loginId: json["login_id"],
        testId: json["test_id"],
        submittedOn: DateTime.parse(json["submitted_on"]),
        parent_module: json["parent_module"],
        attempted_test_id: json["attempted_test_id"],
        answerList: List<AnswerList>.from(
            json["answer_list"].map((x) => AnswerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "test_id": testId,
        "submitted_on": submittedOn.toIso8601String(),
        "parent_module": parent_module,
        "attempted_test_id": attempted_test_id,
        "answer_list": List<dynamic>.from(answerList.map((x) => x.toJson())),
      };
}

class AnswerList {
  String questionId;
  String studentAnswer;

  AnswerList({
    required this.questionId,
    required this.studentAnswer,
  });

  factory AnswerList.fromJson(Map<String, dynamic> json) => AnswerList(
        questionId: json["question_id"],
        studentAnswer: json["student_answer"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "student_answer": studentAnswer,
      };
}
