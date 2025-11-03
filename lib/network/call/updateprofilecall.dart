// To parse this JSON data, do
//
//     final updateprofilecall = updateprofilecallFromJson(jsonString);

import 'dart:convert';

Updateprofilecall updateprofilecallFromJson(String str) =>
    Updateprofilecall.fromJson(json.decode(str));

String updateprofilecallToJson(Updateprofilecall data) =>
    json.encode(data.toJson());

class Updateprofilecall {
  String loginId;
  String address;
  String districtId;
  String stateId;
  String mobileNumber;
  String profileImage;
  String email;
  String fullName;
  String gender;

  Updateprofilecall({
    required this.loginId,
    required this.address,
    required this.districtId,
    required this.stateId,
    required this.mobileNumber,
    required this.profileImage,
    required this.email,
    required this.fullName,
    required this.gender,
  });

  factory Updateprofilecall.fromJson(Map<String, dynamic> json) =>
      Updateprofilecall(
        loginId: json["login_id"],
        address: json["Address"],
        districtId: json["district_id"],
        stateId: json["state_id"],
        mobileNumber: json["mobile_number"],
        profileImage: json["profile_image"],
        email: json["email"],
        fullName: json["full_name"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "Address": address,
        "district_id": districtId,
        "state_id": stateId,
        "mobile_number": mobileNumber,
        "profile_image": profileImage,
        "email": email,
        "full_name": fullName,
        "gender": gender,
      };
}
