// To parse this JSON data, do
//
//     final getprofilecall = getprofilecallFromJson(jsonString);

import 'dart:convert';

Getprofilecall getprofilecallFromJson(String str) =>
    Getprofilecall.fromJson(json.decode(str));

String getprofilecallToJson(Getprofilecall data) => json.encode(data.toJson());

class Getprofilecall {
  String loginId;

  Getprofilecall({
    required this.loginId,
  });

  factory Getprofilecall.fromJson(Map<String, dynamic> json) => Getprofilecall(
        loginId: json["login_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
      };
}
