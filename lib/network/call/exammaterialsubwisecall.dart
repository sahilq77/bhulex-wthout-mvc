import 'dart:convert';

Exammaterialsubwisecall exammaterialsubwisecallFromJson(String str) =>
    Exammaterialsubwisecall.fromJson(json.decode(str));

String exammaterialsubwisecallToJson(Exammaterialsubwisecall data) =>
    json.encode(data.toJson());

class Exammaterialsubwisecall {
  String loginId;
  int limit;
  int offset;
  String examMaterialId; // New parameter

  Exammaterialsubwisecall({
    required this.loginId,
    required this.limit,
    required this.offset,
    required this.examMaterialId, // Include in constructor
  });

  factory Exammaterialsubwisecall.fromJson(Map<String, dynamic> json) =>
      Exammaterialsubwisecall(
        loginId: json["login_id"],
        limit: int.parse(json["limit"].toString()), // Convert limit to int
        offset: int.parse(json["offset"].toString()), // Convert offset to int
        examMaterialId: json["exam_material_id"], // Extract new parameter
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "limit": limit,
        "offset": offset,
        "exam_material_id": examMaterialId, // Include new parameter in JSON
      };
}
