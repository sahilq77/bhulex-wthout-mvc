// To parse this JSON data, do
//
//     final ebookcategorycall = ebookcategorycallFromJson(jsonString);

import 'dart:convert';

Ebookcategorycall ebookcategorycallFromJson(String str) =>
    Ebookcategorycall.fromJson(json.decode(str));

String ebookcategorycallToJson(Ebookcategorycall data) =>
    json.encode(data.toJson());

class Ebookcategorycall {
  String loginId;

  Ebookcategorycall({
    required this.loginId,
  });

  factory Ebookcategorycall.fromJson(Map<String, dynamic> json) =>
      Ebookcategorycall(
        loginId: json["login_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
      };
}
