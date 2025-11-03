// To parse this JSON data, do
//
//     final examwisepdfcall = examwisepdfcallFromJson(jsonString);

import 'dart:convert';

Examwisepdfcall examwisepdfcallFromJson(String str) =>
    Examwisepdfcall.fromJson(json.decode(str));

String examwisepdfcallToJson(Examwisepdfcall data) =>
    json.encode(data.toJson());

class Examwisepdfcall {
  String loginId;
  int limit;
  String examId;
  String examYearId;
  String examTypeId;
  String examMaterialId;
  int offset;

  Examwisepdfcall({
    required this.loginId,
    required this.limit,
    required this.examId,
    required this.examYearId,
    required this.examTypeId,
    required this.examMaterialId,
    required this.offset,
  });

  factory Examwisepdfcall.fromJson(Map<String, dynamic> json) =>
      Examwisepdfcall(
        loginId: json["login_id"],
        limit: json["limit"],
        examId: json["exam_id"],
        examYearId: json["exam_year_id"],
        examTypeId: json["exam_type_id"],
        examMaterialId: json["exam_material_id"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "limit": limit,
        "exam_id": examId,
        "exam_year_id": examYearId,
        "exam_type_id": examTypeId,
        "exam_material_id": examMaterialId,
        "offset": offset,
      };
}
