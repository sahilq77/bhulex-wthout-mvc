// To parse this JSON data, do
//
//     final getOtPcall = getOtPcallFromJson(jsonString);

import 'dart:convert';

GenerateOrderDeleteApicall generateOrderDeleteApicallFromJson(String str) =>
    GenerateOrderDeleteApicall.fromJson(json.decode(str));

String generateOrderDeleteApicallToJson(GenerateOrderDeleteApicall data) =>
    json.encode(data.toJson());

class GenerateOrderDeleteApicall {
  String id;

  GenerateOrderDeleteApicall({
    required this.id,
  });

  factory GenerateOrderDeleteApicall.fromJson(Map<String, dynamic> json) =>
      GenerateOrderDeleteApicall(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
