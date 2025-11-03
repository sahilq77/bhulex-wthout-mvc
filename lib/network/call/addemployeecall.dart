// To parse this JSON data, do
//
//     final addemployeecall = addemployeecallFromJson(jsonString);

import 'dart:convert';

packageEnquiryFormCall addemployeecallFromJson(String str) =>
    packageEnquiryFormCall.fromJson(json.decode(str));

String addemployeecallToJson(packageEnquiryFormCall data) =>
    json.encode(data.toJson());

class packageEnquiryFormCall {
  String package_id;
  String customer_id;
  // String service_id;
  // String first_name;
  // String last_name;
  // String email;
  // String mobile_number;
  // String message;

  packageEnquiryFormCall({
    required this.package_id,
    required this.customer_id,
    // required this.service_id,
    // required this.first_name,
    // required this.last_name,
    // required this.email,
    // required this.mobile_number,
    // required this.message,
  });

  factory packageEnquiryFormCall.fromJson(Map<String, dynamic> json) =>
      packageEnquiryFormCall(
        package_id: json["package_id"],
        customer_id: json["customer_id"],
        // service_id: json["service_id"],
        // first_name: json["first_name"],
        // last_name: json["last_name"],
        // email: json["email"],
        // mobile_number: json["mobile_number"],
        // message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": package_id,
        "customer_id": customer_id,
        // "service_id": service_id,
        // "first_name": first_name,
        // "last_name": last_name,
        // "email": email,
        // "mobile_number": mobile_number,
        // "message": message,
      };
}
