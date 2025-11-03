// To parse this JSON data, do
//
//     final monthattendanceresponse = monthattendanceresponseFromJson(jsonString);

import 'dart:convert';

List<Monthattendanceresponse> monthattendanceresponseFromJson(String str) =>
    List<Monthattendanceresponse>.from(
        json.decode(str).map((x) => Monthattendanceresponse.fromJson(x)));

String monthattendanceresponseToJson(List<Monthattendanceresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Monthattendanceresponse {
  String status;
  String message;
  List<MonthattendanceDatum> data;

  Monthattendanceresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Monthattendanceresponse.fromJson(Map<String, dynamic> json) =>
      Monthattendanceresponse(
        status: json["status"],
        message: json["message"],
        data: List<MonthattendanceDatum>.from(
            json["data"].map((x) => MonthattendanceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MonthattendanceDatum {
  String id;
  dynamic siteId;
  String employeeId;
  DateTime attendanceDate;
  DateTime inDate;
  String inTime;
  dynamic outDate;
  dynamic outTime;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic outtimeAddress;
  dynamic shiftId;
  dynamic shiftName;
  dynamic shiftCode;
  dynamic shiftInTime;
  dynamic shiftOutTime;
  dynamic shiftTotalWorkingHours;
  dynamic lateMarkMargin;
  dynamic earlyGoMargin;
  dynamic lateGoMargin;
  dynamic otMinWorking;
  dynamic otMaxWorking;
  dynamic weekendType;
  dynamic breakTime;
  dynamic firstHalfStart;
  dynamic firstHalfEnd;
  dynamic firstHalfWorkingHours;
  dynamic secondHalfStart;
  dynamic secondHalfEnd;
  dynamic secondHalfWorkingHours;
  String addedBy;
  String otRequestStatus;
  String attendanceFlag;
  dynamic billingManpowerId;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String employeeType;
  String shiftType;
  String month;
  String year;

  MonthattendanceDatum({
    required this.id,
    required this.siteId,
    required this.employeeId,
    required this.attendanceDate,
    required this.inDate,
    required this.inTime,
    required this.outDate,
    required this.outTime,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.outtimeAddress,
    required this.shiftId,
    required this.shiftName,
    required this.shiftCode,
    required this.shiftInTime,
    required this.shiftOutTime,
    required this.shiftTotalWorkingHours,
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
    required this.addedBy,
    required this.otRequestStatus,
    required this.attendanceFlag,
    required this.billingManpowerId,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.employeeType,
    required this.shiftType,
    required this.month,
    required this.year,
  });

  factory MonthattendanceDatum.fromJson(Map<String, dynamic> json) =>
      MonthattendanceDatum(
        id: json["id"] ?? "",
        siteId: json["site_id"] ?? "",
        employeeId: json["employee_id"] ?? "",
        attendanceDate: DateTime.parse(json["attendance_date"]),
        inDate: DateTime.parse(json["in_date"]),
        inTime: json["in_time"],
        outDate: json["out_date"],
        outTime: json["out_time"],
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        address: json["address"] ?? "",
        outtimeAddress: json["outtime_address"] ?? "",
        shiftId: json["shift_id"] ?? "",
        shiftName: json["shift_name"] ?? "",
        shiftCode: json["shift_code"] ?? "",
        shiftInTime: json["shift_in_time"] ?? "",
        shiftOutTime: json["shift_out_time"] ?? "",
        shiftTotalWorkingHours: json["shift_total_working_hours"] ?? "",
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
        addedBy: json["added_by"] ?? "",
        otRequestStatus: json["ot_request_status"] ?? "",
        attendanceFlag: json["attendance_flag"] ?? "",
        billingManpowerId: json["billing_manpower_id"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        employeeType: json["employee_type"] ?? "",
        shiftType: json["shift_type"] ?? "",
        month: json["month"] ?? "",
        year: json["year"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_id": siteId,
        "employee_id": employeeId,
        "attendance_date":
            "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
        "in_date":
            "${inDate.year.toString().padLeft(4, '0')}-${inDate.month.toString().padLeft(2, '0')}-${inDate.day.toString().padLeft(2, '0')}",
        "in_time": inTime,
        "out_date": outDate,
        "out_time": outTime,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "outtime_address": outtimeAddress,
        "shift_id": shiftId,
        "shift_name": shiftName,
        "shift_code": shiftCode,
        "shift_in_time": shiftInTime,
        "shift_out_time": shiftOutTime,
        "shift_total_working_hours": shiftTotalWorkingHours,
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
        "added_by": addedBy,
        "ot_request_status": otRequestStatus,
        "attendance_flag": attendanceFlag,
        "billing_manpower_id": billingManpowerId,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "employee_type": employeeType,
        "shift_type": shiftType,
        "month": month,
        "year": year,
      };
}
