// To parse this JSON data, do
//
//     final usercurrentaffairbookmarkcall = usercurrentaffairbookmarkcallFromJson(jsonString);

import 'dart:convert';

Usercurrentaffairbookmarkcall usercurrentaffairbookmarkcallFromJson(
        String str) =>
    Usercurrentaffairbookmarkcall.fromJson(json.decode(str));

String usercurrentaffairbookmarkcallToJson(
        Usercurrentaffairbookmarkcall data) =>
    json.encode(data.toJson());

class Usercurrentaffairbookmarkcall {
  String loginId;
  String currentAffairId;

  Usercurrentaffairbookmarkcall({
    required this.loginId,
    required this.currentAffairId,
  });

  factory Usercurrentaffairbookmarkcall.fromJson(Map<String, dynamic> json) =>
      Usercurrentaffairbookmarkcall(
        loginId: json["login_id"],
        currentAffairId: json["current_affair_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "current_affair_id": currentAffairId,
      };
}
