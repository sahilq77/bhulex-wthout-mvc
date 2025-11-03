import 'dart:convert';

// To parse this JSON data, do
//
//     final englishBookmarkCall = englishBookmarkCallFromJson(jsonString);

EnglishBookmarkCall englishBookmarkCallFromJson(String str) =>
    EnglishBookmarkCall.fromJson(json.decode(str));

String englishBookmarkCallToJson(EnglishBookmarkCall data) =>
    json.encode(data.toJson());

class EnglishBookmarkCall {
  String loginId;
  String englishWordId;

  EnglishBookmarkCall({
    required this.loginId,
    required this.englishWordId,
  });

  factory EnglishBookmarkCall.fromJson(Map<String, dynamic> json) =>
      EnglishBookmarkCall(
        loginId: json["login_id"],
        englishWordId: json["english_vocabulary_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "english_vocabulary_id": englishWordId,
      };
}
