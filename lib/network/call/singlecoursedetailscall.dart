// To parse this JSON data, do
//
//     final singlecoursedetailscall = singlecoursedetailscallFromJson(jsonString);

import 'dart:convert';

Singlecoursedetailscall singlecoursedetailscallFromJson(String str) =>
    Singlecoursedetailscall.fromJson(json.decode(str));

String singlecoursedetailscallToJson(Singlecoursedetailscall data) =>
    json.encode(data.toJson());

class Singlecoursedetailscall {
  String loginId;
  String courseId;

  Singlecoursedetailscall({
    required this.loginId,
    required this.courseId,
  });

  factory Singlecoursedetailscall.fromJson(Map<String, dynamic> json) =>
      Singlecoursedetailscall(
        loginId: json["login_id"],
        courseId: json["course_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "course_id": courseId,
      };
}
