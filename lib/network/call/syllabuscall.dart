// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

Syllabuscall syllabuscallFromJson(String str) =>
    Syllabuscall.fromJson(json.decode(str));

String syllabuscallToJson(Syllabuscall data) => json.encode(data.toJson());

class Syllabuscall {
  int offset;
  int limit;

  Syllabuscall({
    required this.offset,
    required this.limit,
  });

  factory Syllabuscall.fromJson(Map<String, dynamic> json) => Syllabuscall(
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
      };
}
