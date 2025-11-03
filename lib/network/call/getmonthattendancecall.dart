// To parse this JSON data, do
//
//     final getmonthattendancecall = getmonthattendancecallFromJson(jsonString);

import 'dart:convert';

Getmonthattendancecall getmonthattendancecallFromJson(String str) =>
    Getmonthattendancecall.fromJson(json.decode(str));

String getmonthattendancecallToJson(Getmonthattendancecall data) =>
    json.encode(data.toJson());

class Getmonthattendancecall {
  String month;
  String year;
  String shiftType, selectemployeetypeid, contractorId;

  Getmonthattendancecall(
      {required this.month,
      required this.year,
      required this.shiftType,
      required this.selectemployeetypeid,
      required this.contractorId});

  factory Getmonthattendancecall.fromJson(Map<String, dynamic> json) =>
      Getmonthattendancecall(
          month: json["month"],
          year: json["year"],
          shiftType: json["shift_type"],
          selectemployeetypeid: json["employee_type"],
          contractorId: json["contractor_id"]);

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "shift_type": shiftType,
        "employee_type": selectemployeetypeid,
        "contractor_id": contractorId,
      };
}
