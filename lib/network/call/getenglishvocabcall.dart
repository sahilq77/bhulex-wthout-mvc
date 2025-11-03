import 'dart:convert';

// To parse this JSON data, do
//
//     final getEnglishVocabCall = getEnglishVocabCallFromJson(jsonString);

GetEnglishVocabCall getEnglishVocabCallFromJson(String str) =>
    GetEnglishVocabCall.fromJson(json.decode(str));

String getEnglishVocabCallToJson(GetEnglishVocabCall data) =>
    json.encode(data.toJson());

class GetEnglishVocabCall {
  String category;
  String loginId;
  String offset;
  String limit;

  GetEnglishVocabCall({
    required this.category,
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory GetEnglishVocabCall.fromJson(Map<String, dynamic> json) =>
      GetEnglishVocabCall(
        category: json["category"],
        loginId: json["login_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "login_id": loginId,
        "offset": offset,
        "limit": limit,
      };
}
