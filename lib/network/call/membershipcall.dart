// To parse this JSON data, do
//
//     final membershipcall = membershipcallFromJson(jsonString);

import 'dart:convert';

Membershipcall membershipcallFromJson(String str) =>
    Membershipcall.fromJson(json.decode(str));

String membershipcallToJson(Membershipcall data) => json.encode(data.toJson());

class Membershipcall {
  String loginId;

  Membershipcall({
    required this.loginId,
  });

  factory Membershipcall.fromJson(Map<String, dynamic> json) => Membershipcall(
        loginId: json["login_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
      };
}
