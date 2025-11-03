// To parse this JSON data, do
//
//     final yeartypecall = yeartypecallFromJson(jsonString);

import 'dart:convert';

Yeartypecall yeartypecallFromJson(String str) =>
    Yeartypecall.fromJson(json.decode(str));

String yeartypecallToJson(Yeartypecall data) => json.encode(data.toJson());

class Yeartypecall {
  String loginId;
  String examMaterialId;
  String examId;
  String yearId;
  int limit;
  int offset;

  Yeartypecall({
    required this.loginId,
    required this.examMaterialId,
    required this.examId,
    required this.yearId,
    required this.limit,
    required this.offset,
  });

  factory Yeartypecall.fromJson(Map<String, dynamic> json) => Yeartypecall(
        loginId: json["login_id"],
        examMaterialId: json["exam_material_id"],
        examId: json["exam_id"],
        yearId: json["year_id"],
        limit: json["limit"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "exam_material_id": examMaterialId,
        "exam_id": examId,
        "year_id": yearId,
        "limit": limit,
        "offset": offset,
      };
}
