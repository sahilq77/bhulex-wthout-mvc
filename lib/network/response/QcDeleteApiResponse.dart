import 'dart:convert';

// Function to parse the JSON response into a list of QcDeleteApiResponse
List<QcDeleteApiResponse> qcDeleteApiResponseFromJson(String str) =>
    List<QcDeleteApiResponse>.from(
        json.decode(str).map((x) => QcDeleteApiResponse.fromJson(x)));

// Function to convert a list of QcDeleteApiResponse to JSON
String qcDeleteApiResponseToJson(List<QcDeleteApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QcDeleteApiResponse {
  String status;
  String message;

  QcDeleteApiResponse({
    required this.status,
    required this.message,
  });

  // Factory constructor to create a QcDeleteApiResponse from a JSON map
  factory QcDeleteApiResponse.fromJson(Map<String, dynamic> json) =>
      QcDeleteApiResponse(
        status: json["status"] as String,
        message: json["message"] as String,
      );

  // Method to convert a QcDeleteApiResponse instance to a map (if needed)
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
