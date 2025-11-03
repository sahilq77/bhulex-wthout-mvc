// To parse this JSON data, do
//
//     final getClientBranchApiResponse = getClientBranchApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetClientBranchApiResponse> getClientBranchApiResponseFromJson(
        String str) =>
    List<GetClientBranchApiResponse>.from(
        json.decode(str).map((x) => GetClientBranchApiResponse.fromJson(x)));

String getClientBranchApiResponseToJson(
        List<GetClientBranchApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetClientBranchApiResponse {
  String status;
  String message;
  List<GetClientBranchApiResponseDatum> data;

  GetClientBranchApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetClientBranchApiResponse.fromJson(Map<String, dynamic> json) =>
      GetClientBranchApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetClientBranchApiResponseDatum>.from(json["data"]
            .map((x) => GetClientBranchApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetClientBranchApiResponseDatum {
  String id;
  String clientId;
  String itemGroup;
  String clientEmail;
  String clientContact;
  String country;
  String state;
  String city;
  String pincode;
  String clientStateCode;
  String address;
  String clientGstNo;
  String clientTanNo;
  String msmeRegNumber;
  String branchName;
  String adharNumber;
  String paymentTerms;
  String distance;
  String isDeleted;
  String status;
  DateTime updatedOn;
  DateTime createdOn;

  GetClientBranchApiResponseDatum({
    required this.id,
    required this.clientId,
    required this.itemGroup,
    required this.clientEmail,
    required this.clientContact,
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    required this.clientStateCode,
    required this.address,
    required this.clientGstNo,
    required this.clientTanNo,
    required this.msmeRegNumber,
    required this.branchName,
    required this.adharNumber,
    required this.paymentTerms,
    required this.distance,
    required this.isDeleted,
    required this.status,
    required this.updatedOn,
    required this.createdOn,
  });

  factory GetClientBranchApiResponseDatum.fromJson(Map<String, dynamic> json) =>
      GetClientBranchApiResponseDatum(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        clientEmail: json["client_email"] ?? "",
        clientContact: json["client_contact"] ?? "",
        country: json["country"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        pincode: json["pincode"] ?? "",
        clientStateCode: json["client_state_code"] ?? "",
        address: json["address"] ?? "",
        clientGstNo: json["client_gst_no"] ?? "",
        clientTanNo: json["client_tan_no"] ?? "",
        msmeRegNumber: json["msme_reg_number"] ?? "",
        branchName: json["branch_name"] ?? "",
        adharNumber: json["adhar_number"] ?? "",
        paymentTerms: json["payment_terms"] ?? "",
        distance: json["distance"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        updatedOn: DateTime.parse(json["updated_on"]),
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "item_group": itemGroup,
        "client_email": clientEmail,
        "client_contact": clientContact,
        "country": country,
        "state": state,
        "city": city,
        "pincode": pincode,
        "client_state_code": clientStateCode,
        "address": address,
        "client_gst_no": clientGstNo,
        "client_tan_no": clientTanNo,
        "msme_reg_number": msmeRegNumber,
        "branch_name": branchName,
        "adhar_number": adharNumber,
        "payment_terms": paymentTerms,
        "distance": distance,
        "is_deleted": isDeleted,
        "status": status,
        "updated_on": updatedOn.toIso8601String(),
        "created_on": createdOn.toIso8601String(),
      };
}
