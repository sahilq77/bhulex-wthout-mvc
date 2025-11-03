// To parse this JSON data, do
//
//     final getMarathiVocabCall = getMarathiVocabCallFromJson(jsonString);

import 'dart:convert';

GetMarathiVocabCall getMarathiVocabCallFromJson(String str) =>
    GetMarathiVocabCall.fromJson(json.decode(str));

String getMarathiVocabCallToJson(GetMarathiVocabCall data) =>
    json.encode(data.toJson());

class GetMarathiVocabCall {
  String category;
  String loginId;
  String offset;
  String limit;

  GetMarathiVocabCall({
    required this.category,
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory GetMarathiVocabCall.fromJson(Map<String, dynamic> json) =>
      GetMarathiVocabCall(
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
