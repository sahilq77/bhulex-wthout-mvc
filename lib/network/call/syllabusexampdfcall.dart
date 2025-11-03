// To parse this JSON data, do
//
//     final syllabusexampdfcall = syllabusexampdfcallFromJson(jsonString);

import 'dart:convert';

Syllabusexampdfcall syllabusexampdfcallFromJson(String str) =>
    Syllabusexampdfcall.fromJson(json.decode(str));

String syllabusexampdfcallToJson(Syllabusexampdfcall data) =>
    json.encode(data.toJson());

class Syllabusexampdfcall {
  String loginId;
  int limit;
  String examId;
  String examYearId;
  String examTypeId;
  int offset;

  Syllabusexampdfcall({
    required this.loginId,
    required this.limit,
    required this.examId,
    required this.examYearId,
    required this.examTypeId,
    required this.offset,
  });

  factory Syllabusexampdfcall.fromJson(Map<String, dynamic> json) =>
      Syllabusexampdfcall(
        loginId: json["login_id"],
        limit: json["limit"],
        examId: json["exam_id"],
        examYearId: json["exam_year_id"],
        examTypeId: json["exam_type_id"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "limit": limit,
        "exam_id": examId,
        "exam_year_id": examYearId,
        "exam_type_id": examTypeId,
        "offset": offset,
      };
}
