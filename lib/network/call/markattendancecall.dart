// To parse this JSON data, do
//
//     final markattendancecall = markattendancecallFromJson(jsonString);

import 'dart:convert';

Markattendancecall markattendancecallFromJson(String str) =>
    Markattendancecall.fromJson(json.decode(str));

String markattendancecallToJson(Markattendancecall data) =>
    json.encode(data.toJson());

class Markattendancecall {
  String date;
  String time;
  String userId;
  String shiftId;
  List<Attendance> attendance;
  String contractorId;
  Markattendancecall(
      {required this.date,
      required this.time,
      required this.userId,
      required this.shiftId,
      required this.attendance,
      required this.contractorId});

  factory Markattendancecall.fromJson(Map<String, dynamic> json) =>
      Markattendancecall(
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        userId: json["user_id"] ?? "",
        shiftId: json["shift_id"] ?? "",
        attendance: List<Attendance>.from(
          json["attendance"].map(
            (x) => Attendance.fromJson(x),
          ),
        ),
        contractorId: json["contractor_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "user_id": userId,
        "shift_id": shiftId,
        "attendance": List<dynamic>.from(
          attendance.map(
            (x) => x.toJson(),
          ),
        ),
        "contractor_id": contractorId,
      };
}

class Attendance {
  String attendanceFlag;
  String employeeId;

  Attendance({
    required this.attendanceFlag,
    required this.employeeId,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        attendanceFlag: json["attendance_flag"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_flag": attendanceFlag,
        "employee_id": employeeId,
      };
}
