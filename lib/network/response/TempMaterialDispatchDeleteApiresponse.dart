// To parse this JSON data, do
//
//     final tempMaterialDispatchDeleteApiresponse = tempMaterialDispatchDeleteApiresponseFromJson(jsonString);

import 'dart:convert';

List<TempMaterialDispatchDeleteApiresponse>
    tempMaterialDispatchDeleteApiresponseFromJson(String str) =>
        List<TempMaterialDispatchDeleteApiresponse>.from(json
            .decode(str)
            .map((x) => TempMaterialDispatchDeleteApiresponse.fromJson(x)));

String tempMaterialDispatchDeleteApiresponseToJson(
        List<TempMaterialDispatchDeleteApiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempMaterialDispatchDeleteApiresponse {
  String status;
  String message;

  TempMaterialDispatchDeleteApiresponse({
    required this.status,
    required this.message,
  });

  factory TempMaterialDispatchDeleteApiresponse.fromJson(
          Map<String, dynamic> json) =>
      TempMaterialDispatchDeleteApiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
