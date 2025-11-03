// To parse this JSON data, do
//
//     final packageEnquiryFormApiResponse = packageEnquiryFormApiResponseFromJson(jsonString);

import 'dart:convert';

List<PackageEnquiryFormApiResponse> packageEnquiryFormApiResponseFromJson(
        String str) =>
    List<PackageEnquiryFormApiResponse>.from(
        json.decode(str).map((x) => PackageEnquiryFormApiResponse.fromJson(x)));

String packageEnquiryFormApiResponseToJson(
        List<PackageEnquiryFormApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageEnquiryFormApiResponse {
  String status;
  String message;
  PackageEnquiryFormApiResponseData data;

  PackageEnquiryFormApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PackageEnquiryFormApiResponse.fromJson(Map<String, dynamic> json) =>
      PackageEnquiryFormApiResponse(
        status: json["status"],
        message: json["message"],
        data: PackageEnquiryFormApiResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class PackageEnquiryFormApiResponseData {
  String packageId;
  String customerId;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String message;
  DateTime createdOn;

  PackageEnquiryFormApiResponseData({
    required this.packageId,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.message,
    required this.createdOn,
  });

  factory PackageEnquiryFormApiResponseData.fromJson(
          Map<String, dynamic> json) =>
      PackageEnquiryFormApiResponseData(
        packageId: json["package_id"] ?? "",
        customerId: json["customer_id"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        message: json["message"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "customer_id": customerId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "message": message,
        "created_on": createdOn.toIso8601String(),
      };
}
