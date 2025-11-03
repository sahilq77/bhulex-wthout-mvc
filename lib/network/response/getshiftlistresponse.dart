// To parse this JSON data, do
//
//     final getshiftlistresponse = getshiftlistresponseFromJson(jsonString);

import 'dart:convert';

List<Getshiftlistresponse> getshiftlistresponseFromJson(String str) =>
    List<Getshiftlistresponse>.from(
        json.decode(str).map((x) => Getshiftlistresponse.fromJson(x)));

String getshiftlistresponseToJson(List<Getshiftlistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getshiftlistresponse {
  String status;
  String message;
  List<ShiftlistDatum> data;

  Getshiftlistresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getshiftlistresponse.fromJson(Map<String, dynamic> json) =>
      Getshiftlistresponse(
        status: json["status"],
        message: json["message"],
        data: List<ShiftlistDatum>.from(
            json["data"].map((x) => ShiftlistDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShiftlistDatum {
  String id;
  String shiftName;
  String shiftCode;
  String inTime;
  String outTime;
  String totalWorkingHours;
  String lateMarkMargin;
  String earlyGoMargin;
  String lateGoMargin;
  String otMinWorking;
  String otMaxWorking;
  String weekendType;
  dynamic breakTime;
  String firstHalfStart;
  String firstHalfEnd;
  String firstHalfWorkingHours;
  String secondHalfStart;
  String secondHalfEnd;
  String secondHalfWorkingHours;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  ShiftlistDatum({
    required this.id,
    required this.shiftName,
    required this.shiftCode,
    required this.inTime,
    required this.outTime,
    required this.totalWorkingHours,
    required this.lateMarkMargin,
    required this.earlyGoMargin,
    required this.lateGoMargin,
    required this.otMinWorking,
    required this.otMaxWorking,
    required this.weekendType,
    required this.breakTime,
    required this.firstHalfStart,
    required this.firstHalfEnd,
    required this.firstHalfWorkingHours,
    required this.secondHalfStart,
    required this.secondHalfEnd,
    required this.secondHalfWorkingHours,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory ShiftlistDatum.fromJson(Map<String, dynamic> json) => ShiftlistDatum(
        id: json["id"] ?? "",
        shiftName: json["shift_name"] ?? "",
        shiftCode: json["shift_code"] ?? "",
        inTime: json["in_time"] ?? "",
        outTime: json["out_time"] ?? "",
        totalWorkingHours: json["total_working_hours"] ?? "",
        lateMarkMargin: json["late_mark_margin"] ?? "",
        earlyGoMargin: json["early_go_margin"] ?? "",
        lateGoMargin: json["late_go_margin"] ?? "",
        otMinWorking: json["ot_min_working"] ?? "",
        otMaxWorking: json["ot_max_working"] ?? "",
        weekendType: json["weekend_type"] ?? "",
        breakTime: json["break_time"] ?? "",
        firstHalfStart: json["first_half_start"] ?? "",
        firstHalfEnd: json["first_half_end"] ?? "",
        firstHalfWorkingHours: json["first_half_working_hours"] ?? "",
        secondHalfStart: json["second_half_start"] ?? "",
        secondHalfEnd: json["second_half_end"] ?? "",
        secondHalfWorkingHours: json["second_half_working_hours"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shift_name": shiftName,
        "shift_code": shiftCode,
        "in_time": inTime,
        "out_time": outTime,
        "total_working_hours": totalWorkingHours,
        "late_mark_margin": lateMarkMargin,
        "early_go_margin": earlyGoMargin,
        "late_go_margin": lateGoMargin,
        "ot_min_working": otMinWorking,
        "ot_max_working": otMaxWorking,
        "weekend_type": weekendType,
        "break_time": breakTime,
        "first_half_start": firstHalfStart,
        "first_half_end": firstHalfEnd,
        "first_half_working_hours": firstHalfWorkingHours,
        "second_half_start": secondHalfStart,
        "second_half_end": secondHalfEnd,
        "second_half_working_hours": secondHalfWorkingHours,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
