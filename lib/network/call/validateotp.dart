// To parse this JSON data, do
//
//     final validateotpcall = validateotpcallFromJson(jsonString);

import 'dart:convert';

Validateotpcall validateotpcallFromJson(String str) =>
    Validateotpcall.fromJson(json.decode(str));

String validateotpcallToJson(Validateotpcall data) =>
    json.encode(data.toJson());

class Validateotpcall {
  String mobileNumber;
  String otp;
  String pushToken;

  Validateotpcall({
    required this.mobileNumber,
    required this.otp,
    required this.pushToken,
  });

  factory Validateotpcall.fromJson(Map<String, dynamic> json) =>
      Validateotpcall(
        mobileNumber: json["mobile_number"],
        otp: json["otp"],
        pushToken: json["push_token"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_number": mobileNumber,
        "otp": otp,
        "push_token": pushToken,
      };
}
