// To parse this JSON data, do
//
//     final getContractorListApiResponse = getContractorListApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetContractorListApiResponse> getContractorListApiResponseFromJson(
        String str) =>
    List<GetContractorListApiResponse>.from(
        json.decode(str).map((x) => GetContractorListApiResponse.fromJson(x)));

String getContractorListApiResponseToJson(
        List<GetContractorListApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetContractorListApiResponse {
  String status;
  String message;
  List<GetContractorListApiResponseDatum> data;

  GetContractorListApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetContractorListApiResponse.fromJson(Map<String, dynamic> json) =>
      GetContractorListApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetContractorListApiResponseDatum>.from(json["data"]
            .map((x) => GetContractorListApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetContractorListApiResponseDatum {
  String id;
  String companyName;
  String contactPersonName;
  String mobileNumber;
  String address;
  String gstNumber;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  GetContractorListApiResponseDatum({
    required this.id,
    required this.companyName,
    required this.contactPersonName,
    required this.mobileNumber,
    required this.address,
    required this.gstNumber,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GetContractorListApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetContractorListApiResponseDatum(
        id: json["id"] ?? "NA",
        companyName: json["company_name"] ?? "NA",
        contactPersonName: json["contact_person_name"] ?? "NA",
        mobileNumber: json["mobile_number"] ?? "NA",
        address: json["address"] ?? "NA",
        gstNumber: json["gst_number"] ?? "NA",
        isDeleted: json["is_deleted"] ?? "NA",
        status: json["status"] ?? "NA",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "contact_person_name": contactPersonName,
        "mobile_number": mobileNumber,
        "address": address,
        "gst_number": gstNumber,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
