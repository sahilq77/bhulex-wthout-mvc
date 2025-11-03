// To parse this JSON data, do
//
//     final setuserdoubtscall = setuserdoubtscallFromJson(jsonString);

import 'dart:convert';

Setuserdoubtscall setuserdoubtscallFromJson(String str) =>
    Setuserdoubtscall.fromJson(json.decode(str));

String setuserdoubtscallToJson(Setuserdoubtscall data) =>
    json.encode(data.toJson());

class Setuserdoubtscall {
  String login_id;
  String doubtQuestion;

  Setuserdoubtscall({
    required this.login_id,
    required this.doubtQuestion,
  });

  factory Setuserdoubtscall.fromJson(Map<String, dynamic> json) =>
      Setuserdoubtscall(
        login_id: json["login_id"],
        doubtQuestion: json["doubt_question"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": login_id,
        "doubt_question": doubtQuestion,
      };
}
