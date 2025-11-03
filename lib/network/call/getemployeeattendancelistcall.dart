// To parse this JSON data, do
//
//     final getemployeeattendancelistcall = getemployeeattendancelistcallFromJson(jsonString);

import 'dart:convert';

Getemployeeattendancelistcall getemployeeattendancelistcallFromJson(
        String str) =>
    Getemployeeattendancelistcall.fromJson(json.decode(str));

String getemployeeattendancelistcallToJson(
        Getemployeeattendancelistcall data) =>
    json.encode(data.toJson());

class Getemployeeattendancelistcall {
  String date;
  String shiftType, selectemployeetypeid, contractorId;

  Getemployeeattendancelistcall(
      {required this.date,
      required this.shiftType,
      required this.selectemployeetypeid,
      required this.contractorId});

  factory Getemployeeattendancelistcall.fromJson(Map<String, dynamic> json) =>
      Getemployeeattendancelistcall(
          date: json["date"],
          shiftType: json["shift_type"],
          selectemployeetypeid: json["employee_type"],
          contractorId: json["contractor_id"]);

  Map<String, dynamic> toJson() => {
        "date": date,
        "shift_type": shiftType,
        "employee_type": selectemployeetypeid,
        "contractor_id": contractorId
      };
}
