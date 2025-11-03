// To parse this JSON data, do
//
//     final getUniqueTblAppShotsPerHourApiResponse = getUniqueTblAppShotsPerHourApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetUniqueTblAppShotsPerHourApiResponse>
    getUniqueTblAppShotsPerHourApiResponseFromJson(String str) =>
        List<GetUniqueTblAppShotsPerHourApiResponse>.from(json
            .decode(str)
            .map((x) => GetUniqueTblAppShotsPerHourApiResponse.fromJson(x)));

String getUniqueTblAppShotsPerHourApiResponseToJson(
        List<GetUniqueTblAppShotsPerHourApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUniqueTblAppShotsPerHourApiResponse {
  String status;
  String message;

  GetUniqueTblAppShotsPerHourApiResponse({
    required this.status,
    required this.message,
  });

  factory GetUniqueTblAppShotsPerHourApiResponse.fromJson(
          Map<String, dynamic> json) =>
      GetUniqueTblAppShotsPerHourApiResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
