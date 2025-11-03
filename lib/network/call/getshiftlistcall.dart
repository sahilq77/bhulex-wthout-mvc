// To parse this JSON data, do
//
//     final getshiftlistcall = getshiftlistcallFromJson(jsonString);

import 'dart:convert';

Getshiftlistcall getshiftlistcallFromJson(String str) =>
    Getshiftlistcall.fromJson(json.decode(str));

String getshiftlistcallToJson(Getshiftlistcall data) =>
    json.encode(data.toJson());

class Getshiftlistcall {
  String employeeType;

  Getshiftlistcall({
    required this.employeeType,
  });

  factory Getshiftlistcall.fromJson(Map<String, dynamic> json) =>
      Getshiftlistcall(
        employeeType: json["employee_type"],
      );

  Map<String, dynamic> toJson() => {
        "employee_type": employeeType,
      };
}
