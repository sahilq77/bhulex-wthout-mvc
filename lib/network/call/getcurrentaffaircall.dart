// To parse this JSON data, do
//
//     final getcurrentaffaircall = getcurrentaffaircallFromJson(jsonString);

import 'dart:convert';

Getcurrentaffaircall getcurrentaffaircallFromJson(String str) =>
    Getcurrentaffaircall.fromJson(json.decode(str));

String getcurrentaffaircallToJson(Getcurrentaffaircall data) =>
    json.encode(data.toJson());

class Getcurrentaffaircall {
  String category;
  String loginId;
  String offset;
  String limit;

  Getcurrentaffaircall({
    required this.category,
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory Getcurrentaffaircall.fromJson(Map<String, dynamic> json) =>
      Getcurrentaffaircall(
        category: json["category"],
        loginId: json["login_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "login_id": loginId,
        "offset": offset,
        "limit": limit,
      };
}
