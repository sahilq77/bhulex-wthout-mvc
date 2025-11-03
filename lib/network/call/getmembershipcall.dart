// To parse this JSON data, do
//
//     final getmembershipcall = getmembershipcallFromJson(jsonString);

import 'dart:convert';

Getmembershipcall getmembershipcallFromJson(String str) =>
    Getmembershipcall.fromJson(json.decode(str));

String getmembershipcallToJson(Getmembershipcall data) =>
    json.encode(data.toJson());

class Getmembershipcall {
  String loginId;

  Getmembershipcall({
    required this.loginId,
  });

  factory Getmembershipcall.fromJson(Map<String, dynamic> json) =>
      Getmembershipcall(
        loginId: json["login_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
      };
}
