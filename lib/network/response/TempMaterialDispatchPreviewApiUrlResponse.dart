// To parse this JSON data, do
//
//     final tempMaterialDispatchPreviewApiUrlResponse = tempMaterialDispatchPreviewApiUrlResponseFromJson(jsonString);

import 'dart:convert';

List<TempMaterialDispatchPreviewApiUrlResponse>
    tempMaterialDispatchPreviewApiUrlResponseFromJson(String str) =>
        List<TempMaterialDispatchPreviewApiUrlResponse>.from(json
            .decode(str)
            .map((x) => TempMaterialDispatchPreviewApiUrlResponse.fromJson(x)));

String tempMaterialDispatchPreviewApiUrlResponseToJson(
        List<TempMaterialDispatchPreviewApiUrlResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempMaterialDispatchPreviewApiUrlResponse {
  String status;
  String message;
  String data;

  TempMaterialDispatchPreviewApiUrlResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TempMaterialDispatchPreviewApiUrlResponse.fromJson(
          Map<String, dynamic> json) =>
      TempMaterialDispatchPreviewApiUrlResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
