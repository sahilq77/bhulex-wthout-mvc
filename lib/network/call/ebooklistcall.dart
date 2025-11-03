// To parse this JSON data, do
//
//     final ebooklistcall = ebooklistcallFromJson(jsonString);

import 'dart:convert';

Ebooklistcall ebooklistcallFromJson(String str) =>
    Ebooklistcall.fromJson(json.decode(str));

String ebooklistcallToJson(Ebooklistcall data) => json.encode(data.toJson());

class Ebooklistcall {
  String loginId;
  String categoryId;
  String subCategoryId;

  Ebooklistcall({
    required this.loginId,
    required this.categoryId,
    required this.subCategoryId,
  });

  factory Ebooklistcall.fromJson(Map<String, dynamic> json) => Ebooklistcall(
        loginId: json["login_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
      };
}
