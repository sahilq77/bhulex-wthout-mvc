// To parse this JSON data, do
//
//     final coursecontentcall = coursecontentcallFromJson(jsonString);

import 'dart:convert';

Coursecontentcall coursecontentcallFromJson(String str) =>
    Coursecontentcall.fromJson(json.decode(str));

String coursecontentcallToJson(Coursecontentcall data) =>
    json.encode(data.toJson());

class Coursecontentcall {
  String loginId;
  String courseId;

  Coursecontentcall({
    required this.loginId,
    required this.courseId,
  });

  factory Coursecontentcall.fromJson(Map<String, dynamic> json) =>
      Coursecontentcall(
        loginId: json["login_id"],
        courseId: json["course_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "course_id": courseId,
      };
}
