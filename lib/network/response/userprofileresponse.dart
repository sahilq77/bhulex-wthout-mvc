// To parse this JSON data, do
//
//     final userprofileresponse = userprofileresponseFromJson(jsonString);

import 'dart:convert';

List<Userprofileresponse> userprofileresponseFromJson(String str) =>
    List<Userprofileresponse>.from(
        json.decode(str).map((x) => Userprofileresponse.fromJson(x)));

String userprofileresponseToJson(List<Userprofileresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userprofileresponse {
  String status;
  String message;
  String userName;
  String aadhaarNo;
  String filePath;
  String fileName;
  String mobileNumber, contractorName;

  Userprofileresponse(
      {required this.status,
      required this.message,
      required this.userName,
      required this.aadhaarNo,
      required this.filePath,
      required this.fileName,
      required this.mobileNumber,
      required this.contractorName});

  factory Userprofileresponse.fromJson(Map<String, dynamic> json) =>
      Userprofileresponse(
        status: json["status"] ?? "NA",
        message: json["message"] ?? "NA",
        userName: json["user_name"] ?? "NA",
        aadhaarNo: json["aadhaar_no"] ?? "NA",
        filePath: json["file_path"] ?? "NA",
        fileName: json["file_name"] ?? "NA",
        mobileNumber: json["mobile_number"] ?? "NA",
        contractorName: json["contractor_name"] ?? "NA",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_name": userName,
        "aadhaar_no": aadhaarNo,
        "file_path": filePath,
        "file_name": fileName,
        "mobile_number": mobileNumber,
        "contractor_name": contractorName
      };
}
