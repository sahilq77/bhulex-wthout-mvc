// To parse this JSON data, do
//
//     final getnewscall = getnewscallFromJson(jsonString);

import 'dart:convert';

Getnewscall getnewscallFromJson(String str) =>
    Getnewscall.fromJson(json.decode(str));

String getnewscallToJson(Getnewscall data) => json.encode(data.toJson());

class Getnewscall {
  String category;
  String loginId;
  String offset;
  String limit;

  Getnewscall({
    required this.category,
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory Getnewscall.fromJson(Map<String, dynamic> json) => Getnewscall(
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
