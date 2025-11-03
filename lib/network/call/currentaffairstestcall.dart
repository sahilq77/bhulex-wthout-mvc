// To parse this JSON data, do
//
//     final currentaffairstestcall = currentaffairstestcallFromJson(jsonString);

import 'dart:convert';

Currentaffairstestcall currentaffairstestcallFromJson(String str) =>
    Currentaffairstestcall.fromJson(json.decode(str));

String currentaffairstestcallToJson(Currentaffairstestcall data) =>
    json.encode(data.toJson());

class Currentaffairstestcall {
  String loginId;
  int limit;
  int offset;
  String categoryId;

  Currentaffairstestcall({
    required this.loginId,
    required this.limit,
    required this.offset,
    required this.categoryId,
  });

  factory Currentaffairstestcall.fromJson(Map<String, dynamic> json) =>
      Currentaffairstestcall(
        loginId: json["login_id"],
        limit: json["limit"],
        offset: json["offset"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "limit": limit,
        "offset": offset,
        "category_id": categoryId,
      };
}
