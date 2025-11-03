// To parse this JSON data, do
//
//     final getemployeeattendancelistresponse = getemployeeattendancelistresponseFromJson(jsonString);

import 'dart:convert';

List<Getemployeeattendancelistresponse>
    getemployeeattendancelistresponseFromJson(String str) =>
        List<Getemployeeattendancelistresponse>.from(json
            .decode(str)
            .map((x) => Getemployeeattendancelistresponse.fromJson(x)));

String getemployeeattendancelistresponseToJson(
        List<Getemployeeattendancelistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getemployeeattendancelistresponse {
  String status;
  String message;
  List<EmployeeattendancelistDatum> data;

  Getemployeeattendancelistresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getemployeeattendancelistresponse.fromJson(
          Map<String, dynamic> json) =>
      Getemployeeattendancelistresponse(
        status: json["status"],
        message: json["message"],
        data: List<EmployeeattendancelistDatum>.from(
            json["data"].map((x) => EmployeeattendancelistDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmployeeattendancelistDatum {
  dynamic inTime;
  dynamic outTime;
  dynamic employeeId;
  dynamic employeeType;
  dynamic shiftType;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;

  EmployeeattendancelistDatum({
    required this.inTime,
    required this.outTime,
    required this.employeeId,
    required this.employeeType,
    required this.shiftType,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });

  factory EmployeeattendancelistDatum.fromJson(Map<String, dynamic> json) =>
      EmployeeattendancelistDatum(
        inTime: json["in_time"] ?? "",
        outTime: json["out_time"] ?? "",
        employeeId: json["employee_id"] ?? "",
        employeeType: json["employee_type"] ?? "",
        shiftType: json["shift_type"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "in_time": inTime,
        "out_time": outTime,
        "employee_id": employeeId,
        "employee_type": employeeType,
        "shift_type": shiftType,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
      };
}
