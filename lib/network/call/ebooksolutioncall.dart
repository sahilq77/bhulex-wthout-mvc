// To parse this JSON data, do
//
//     final ebooklsolutioncall = ebooklsolutioncallFromJson(jsonString);

import 'dart:convert';

Ebooklsolutioncall ebooklsolutioncallFromJson(String str) =>
    Ebooklsolutioncall.fromJson(json.decode(str));

String ebooklsolutioncallToJson(Ebooklsolutioncall data) =>
    json.encode(data.toJson());

class Ebooklsolutioncall {
  String loginId;
  String ebookId;

  Ebooklsolutioncall({
    required this.loginId,
    required this.ebookId,
  });

  factory Ebooklsolutioncall.fromJson(Map<String, dynamic> json) =>
      Ebooklsolutioncall(
        loginId: json["login_id"],
        ebookId: json["ebook_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "ebook_id": ebookId,
      };
}
