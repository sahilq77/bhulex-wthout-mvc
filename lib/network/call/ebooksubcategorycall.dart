// To parse this JSON data, do
//
//     final ebooksubcategorycall = ebooksubcategorycallFromJson(jsonString);

import 'dart:convert';

Ebooksubcategorycall ebooksubcategorycallFromJson(String str) =>
    Ebooksubcategorycall.fromJson(json.decode(str));

String ebooksubcategorycallToJson(Ebooksubcategorycall data) =>
    json.encode(data.toJson());

class Ebooksubcategorycall {
  String loginId;
  String categoryId;

  Ebooksubcategorycall({
    required this.loginId,
    required this.categoryId,
  });

  factory Ebooksubcategorycall.fromJson(Map<String, dynamic> json) =>
      Ebooksubcategorycall(
        loginId: json["login_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "category_id": categoryId,
      };
}
