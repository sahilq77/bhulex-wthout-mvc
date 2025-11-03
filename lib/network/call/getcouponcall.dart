// To parse this JSON data, do
//
//     final getcouponcall = getcouponcallFromJson(jsonString);

import 'dart:convert';

Getcouponcall getcouponcallFromJson(String str) =>
    Getcouponcall.fromJson(json.decode(str));

String getcouponcallToJson(Getcouponcall data) => json.encode(data.toJson());

class Getcouponcall {
  String loginId;
  String type;

  Getcouponcall({
    required this.loginId,
    required this.type,
  });

  factory Getcouponcall.fromJson(Map<String, dynamic> json) => Getcouponcall(
        loginId: json["login_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "type": type,
      };
}
