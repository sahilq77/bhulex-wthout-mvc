// To parse this JSON data, do
//
//     final bookmarknewscall = bookmarknewscallFromJson(jsonString);

import 'dart:convert';

Bookmarknewscall bookmarknewscallFromJson(String str) =>
    Bookmarknewscall.fromJson(json.decode(str));

String bookmarknewscallToJson(Bookmarknewscall data) =>
    json.encode(data.toJson());

class Bookmarknewscall {
  String loginId;
  String newsId;

  Bookmarknewscall({
    required this.loginId,
    required this.newsId,
  });

  factory Bookmarknewscall.fromJson(Map<String, dynamic> json) =>
      Bookmarknewscall(
        loginId: json["login_id"],
        newsId: json["news_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "news_id": newsId,
      };
}
