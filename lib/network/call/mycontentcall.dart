// To parse this JSON data, do
//
//     final mycontentcall = mycontentcallFromJson(jsonString);

import 'dart:convert';

Mycontentcall mycontentcallFromJson(String str) =>
    Mycontentcall.fromJson(json.decode(str));

String mycontentcallToJson(Mycontentcall data) => json.encode(data.toJson());

class Mycontentcall {
  String loginId;
  int offset;
  int limit;

  Mycontentcall({
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory Mycontentcall.fromJson(Map<String, dynamic> json) => Mycontentcall(
        loginId: json["login_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "offset": offset,
        "limit": limit,
      };
}
