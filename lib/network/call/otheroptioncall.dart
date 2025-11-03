// To parse this JSON data, do
//
//     final otheroptioncall = otheroptioncallFromJson(jsonString);

import 'dart:convert';

Otheroptioncall otheroptioncallFromJson(String str) =>
    Otheroptioncall.fromJson(json.decode(str));

String otheroptioncallToJson(Otheroptioncall data) =>
    json.encode(data.toJson());

class Otheroptioncall {
  String otherOptionCategoryId;
  int offset;
  int limit;

  Otheroptioncall({
    required this.otherOptionCategoryId,
    required this.offset,
    required this.limit,
  });

  factory Otheroptioncall.fromJson(Map<String, dynamic> json) =>
      Otheroptioncall(
        otherOptionCategoryId: json["other_option_category_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "other_option_category_id": otherOptionCategoryId,
        "offset": offset,
        "limit": limit,
      };
}
