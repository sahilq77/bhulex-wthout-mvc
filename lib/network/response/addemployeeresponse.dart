// To parse this JSON data, do
//
//     final addemployeeresponse = addemployeeresponseFromJson(jsonString);

import 'dart:convert';

List<Addemployeeresponse> addemployeeresponseFromJson(String str) =>
    List<Addemployeeresponse>.from(
        json.decode(str).map((x) => Addemployeeresponse.fromJson(x)));

String addemployeeresponseToJson(List<Addemployeeresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Addemployeeresponse {
  String status;
  String message;
  int employeeId;

  Addemployeeresponse({
    required this.status,
    required this.message,
    required this.employeeId,
  });

  factory Addemployeeresponse.fromJson(Map<String, dynamic> json) =>
      Addemployeeresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        employeeId: json["employee_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "employee_id": employeeId,
      };
}
