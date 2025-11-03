// To parse this JSON data, do
//
//     final ebooktestcall = ebooktestcallFromJson(jsonString);

import 'dart:convert';

Ebooktestcall ebooktestcallFromJson(String str) =>
    Ebooktestcall.fromJson(json.decode(str));

String ebooktestcallToJson(Ebooktestcall data) => json.encode(data.toJson());

class Ebooktestcall {
  String loginId;
  String ebookId;
  String chapterId;
  int limit;
  int offset;

  Ebooktestcall({
    required this.loginId,
    required this.ebookId,
    required this.chapterId,
    required this.limit,
    required this.offset,
  });

  factory Ebooktestcall.fromJson(Map<String, dynamic> json) => Ebooktestcall(
        loginId: json["login_id"],
        ebookId: json["ebook_id"],
        chapterId: json["chapter_id"],
        limit: json["limit"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "ebook_id": ebookId,
        "chapter_id": chapterId,
        "limit": limit,
        "offset": offset,
      };
}
