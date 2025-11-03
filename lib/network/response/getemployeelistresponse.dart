// To parse this JSON data, do
//
//     final getemployeelistresponse = getemployeelistresponseFromJson(jsonString);

import 'dart:convert';

List<Getemployeelistresponse> getemployeelistresponseFromJson(String str) =>
    List<Getemployeelistresponse>.from(
        json.decode(str).map((x) => Getemployeelistresponse.fromJson(x)));

String getemployeelistresponseToJson(List<Getemployeelistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getemployeelistresponse {
  String status;
  String message;
  List<EmployeelistDatum> data;

  Getemployeelistresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getemployeelistresponse.fromJson(Map<String, dynamic> json) =>
      Getemployeelistresponse(
        status: json["status"],
        message: json["message"],
        data: List<EmployeelistDatum>.from(
            json["data"].map((x) => EmployeelistDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmployeelistDatum {
  dynamic employeeId;
  dynamic employeeName;
  dynamic employeePhoto;
  dynamic mobileNumber;
  dynamic attendanceFlag;
  dynamic attendanceDate;
  dynamic inTime;
  dynamic outTime;

  EmployeelistDatum({
    required this.employeeId,
    required this.employeeName,
    required this.employeePhoto,
    required this.mobileNumber,
    required this.attendanceFlag,
    required this.attendanceDate,
    required this.inTime,
    required this.outTime,
  });

  factory EmployeelistDatum.fromJson(Map<String, dynamic> json) =>
      EmployeelistDatum(
        employeeId: json["employee_id"] ?? "",
        employeeName: json["employee_name"] ?? "",
        employeePhoto: json["employee_photo"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        attendanceFlag: json["attendance_flag"] ?? "",
        attendanceDate: json["attendance_date"] ?? "",
        inTime: json["in_time"],
        outTime: json["out_time"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "employee_name": employeeName,
        "employee_photo": employeePhoto,
        "mobile_number": mobileNumber,
        "attendance_flag": attendanceFlag,
        "attendance_date": attendanceDate,
        "in_time": inTime,
        "out_time": outTime,
      };
}
