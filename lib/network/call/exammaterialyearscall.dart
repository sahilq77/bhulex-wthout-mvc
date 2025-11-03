// To parse this JSON data, do
//
//     final exammaterialyearscall = exammaterialyearscallFromJson(jsonString);

import 'dart:convert';

Exammaterialyearscall exammaterialyearscallFromJson(String str) =>
    Exammaterialyearscall.fromJson(json.decode(str));

String exammaterialyearscallToJson(Exammaterialyearscall data) =>
    json.encode(data.toJson());

class Exammaterialyearscall {
  String loginId;
  String examMaterialId;
  String examId;
  int limit;
  int offset;

  Exammaterialyearscall({
    required this.loginId,
    required this.examMaterialId,
    required this.examId,
    required this.limit,
    required this.offset,
  });

  factory Exammaterialyearscall.fromJson(Map<String, dynamic> json) =>
      Exammaterialyearscall(
        loginId: json["login_id"],
        examMaterialId: json["exam_material_id"],
        examId: json["exam_id"],
        limit: json["limit"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "exam_material_id": examMaterialId,
        "exam_id": examId,
        "limit": limit,
        "offset": offset,
      };
}
