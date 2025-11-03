// To parse this JSON data, do
//
//     final getOtPcall = getOtPcallFromJson(jsonString);

import 'dart:convert';

generateOrderUpdateEntryApi generateOrderDeleteApicallFromJson(String str) =>
    generateOrderUpdateEntryApi.fromJson(json.decode(str));

String generateOrderDeleteApicallToJson(generateOrderUpdateEntryApi data) =>
    json.encode(data.toJson());

class generateOrderUpdateEntryApi {
  String id;

  generateOrderUpdateEntryApi({
    required this.id,
  });

  factory generateOrderUpdateEntryApi.fromJson(Map<String, dynamic> json) =>
      generateOrderUpdateEntryApi(
        id: json["generated_last_id"],
      );

  Map<String, dynamic> toJson() => {
        "generated_last_id": id,
      };
}
