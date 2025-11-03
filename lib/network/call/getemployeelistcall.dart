// To parse this JSON data, do
//
//     final getemployeelistcall = getemployeelistcallFromJson(jsonString);

import 'dart:convert';

Getemployeelistcall getemployeelistcallFromJson(String str) =>
    Getemployeelistcall.fromJson(json.decode(str));

String getemployeelistcallToJson(Getemployeelistcall data) =>
    json.encode(data.toJson());

class Getemployeelistcall {
  String employeeType;
  String shiftid, contractorId;

  Getemployeelistcall(
      {required this.employeeType,
      required this.shiftid,
      required this.contractorId});

  factory Getemployeelistcall.fromJson(Map<String, dynamic> json) =>
      Getemployeelistcall(
        employeeType: json["employee_type"],
        shiftid: json["shift_id"],
        contractorId: json["contractor_id"],
      );

  Map<String, dynamic> toJson() => {
        "employee_type": employeeType,
        "shift_id": shiftid,
        "contractor_id": contractorId
      };
}
