// To parse this JSON data, do
//
//     final markattendanceresponse = markattendanceresponseFromJson(jsonString);

import 'dart:convert';

List<Markattendanceresponse> markattendanceresponseFromJson(String str) =>
    List<Markattendanceresponse>.from(
        json.decode(str).map((x) => Markattendanceresponse.fromJson(x)));

String markattendanceresponseToJson(List<Markattendanceresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Markattendanceresponse {
  String status;
  String message;

  Markattendanceresponse({
    required this.status,
    required this.message,
  });

  factory Markattendanceresponse.fromJson(Map<String, dynamic> json) =>
      Markattendanceresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
