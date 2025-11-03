// To parse this JSON data, do
//
//     final gettestdetailscall = gettestdetailscallFromJson(jsonString);

import 'dart:convert';

Gettestdetailscall gettestdetailscallFromJson(String str) =>
    Gettestdetailscall.fromJson(json.decode(str));

String gettestdetailscallToJson(Gettestdetailscall data) =>
    json.encode(data.toJson());

class Gettestdetailscall {
  String loginId;
  String testId;

  Gettestdetailscall({
    required this.loginId,
    required this.testId,
  });

  factory Gettestdetailscall.fromJson(Map<String, dynamic> json) =>
      Gettestdetailscall(
        loginId: json["login_id"],
        testId: json["test_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "test_id": testId,
      };
}
