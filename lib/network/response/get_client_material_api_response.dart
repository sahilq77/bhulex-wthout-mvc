// To parse this JSON data, do
//
//     final getClientMaterialApiResponse = getClientMaterialApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetClientMaterialApiResponse> getClientMaterialApiResponseFromJson(
        String str) =>
    List<GetClientMaterialApiResponse>.from(
        json.decode(str).map((x) => GetClientMaterialApiResponse.fromJson(x)));

String getClientMaterialApiResponseToJson(
        List<GetClientMaterialApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetClientMaterialApiResponse {
  String status;
  String message;
  List<GetClientMaterialApiResponseDatum> data;

  GetClientMaterialApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetClientMaterialApiResponse.fromJson(Map<String, dynamic> json) =>
      GetClientMaterialApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetClientMaterialApiResponseDatum>.from(json["data"]
            .map((x) => GetClientMaterialApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetClientMaterialApiResponseDatum {
  String id;
  String clientId;
  String itemName;
  String branchName;
  String itemGroup;
  String itemType;
  String openingBalance;
  DateTime date;
  String units;
  dynamic quantity;
  String hsnCode;
  dynamic rate;
  dynamic subChallan;
  dynamic showInInvoice;
  dynamic companyId;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  GetClientMaterialApiResponseDatum({
    required this.id,
    required this.clientId,
    required this.itemName,
    required this.branchName,
    required this.itemGroup,
    required this.itemType,
    required this.openingBalance,
    required this.date,
    required this.units,
    required this.quantity,
    required this.hsnCode,
    required this.rate,
    required this.subChallan,
    required this.showInInvoice,
    required this.companyId,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GetClientMaterialApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetClientMaterialApiResponseDatum(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        itemName: json["item_name"] ?? "",
        branchName: json["branch_name"] ?? "",
        itemGroup: json["item_group"] ?? "",
        itemType: json["item_type"] ?? "",
        openingBalance: json["opening_balance"] ?? "",
        date: DateTime.parse(json["date"]),
        units: json["units"] ?? "",
        quantity: json["quantity"] ?? "",
        hsnCode: json["hsn_code"] ?? "",
        rate: json["rate"] ?? "",
        subChallan: json["sub_challan"] ?? "",
        showInInvoice: json["show_in_invoice"] ?? "",
        companyId: json["company_id"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "item_name": itemName,
        "branch_name": branchName,
        "item_group": itemGroup,
        "item_type": itemType,
        "opening_balance": openingBalance,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "units": units,
        "quantity": quantity,
        "hsn_code": hsnCode,
        "rate": rate,
        "sub_challan": subChallan,
        "show_in_invoice": showInInvoice,
        "company_id": companyId,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
