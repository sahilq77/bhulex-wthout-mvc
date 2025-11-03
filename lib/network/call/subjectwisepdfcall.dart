// To parse this JSON data, do
//
//     final subjectwisepdfcall = subjectwisepdfcallFromJson(jsonString);

import 'dart:convert';

Subjectwisepdfcall subjectwisepdfcallFromJson(String str) =>
    Subjectwisepdfcall.fromJson(json.decode(str));

String subjectwisepdfcallToJson(Subjectwisepdfcall data) =>
    json.encode(data.toJson());

class Subjectwisepdfcall {
  String loginId;
  int limit;
  String subjectId;
  String examMaterialId;
  int offset;

  Subjectwisepdfcall({
    required this.loginId,
    required this.limit,
    required this.subjectId,
    required this.examMaterialId,
    required this.offset,
  });

  factory Subjectwisepdfcall.fromJson(Map<String, dynamic> json) =>
      Subjectwisepdfcall(
        loginId: json["login_id"],
        limit: json["limit"],
        subjectId: json["subject_id"],
        examMaterialId: json["exam_material_id"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "limit": limit,
        "subject_id": subjectId,
        "exam_material_id": examMaterialId,
        "offset": offset,
      };
}
