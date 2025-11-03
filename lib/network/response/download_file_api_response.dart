// To parse this JSON data, do
//
//     final downloadFileApiResponse = downloadFileApiResponseFromJson(jsonString);

import 'dart:convert';

List<DownloadFileApiResponse> downloadFileApiResponseFromJson(String str) =>
    List<DownloadFileApiResponse>.from(
        json.decode(str).map((x) => DownloadFileApiResponse.fromJson(x)));

String downloadFileApiResponseToJson(List<DownloadFileApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DownloadFileApiResponse {
  String status;
  String message;

  DownloadFileApiResponse({
    required this.status,
    required this.message,
  });

  factory DownloadFileApiResponse.fromJson(Map<String, dynamic> json) =>
      DownloadFileApiResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
