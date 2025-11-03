// To parse this JSON data, do
//
//     final createaccountcall = createaccountcallFromJson(jsonString);

import 'dart:convert';

Createaccountcall createaccountcallFromJson(String str) =>
    Createaccountcall.fromJson(json.decode(str));

String createaccountcallToJson(Createaccountcall data) =>
    json.encode(data.toJson());

class Createaccountcall {
  String fullName;
  String gender;
  String mobileNumber;
  String email;
  String districtId;
  String stateId;
  String address;

  Createaccountcall({
    required this.fullName,
    required this.gender,
    required this.mobileNumber,
    required this.email,
    required this.districtId,
    required this.stateId,
    required this.address,
  });

  factory Createaccountcall.fromJson(Map<String, dynamic> json) =>
      Createaccountcall(
        fullName: json["full_name"],
        gender: json["gender"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        districtId: json["district_id"],
        stateId: json["state_id"],
        address: json["Address"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "gender": gender,
        "mobile_number": mobileNumber,
        "email": email,
        "district_id": districtId,
        "state_id": stateId,
        "Address": address,
      };
}
