// To parse this JSON data, do
//
//     final getVehicleLoadingHistoryApiResponse = getVehicleLoadingHistoryApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetVehicleLoadingHistoryApiResponse>
    getVehicleLoadingHistoryApiResponseFromJson(String str) =>
        List<GetVehicleLoadingHistoryApiResponse>.from(json
            .decode(str)
            .map((x) => GetVehicleLoadingHistoryApiResponse.fromJson(x)));

String getVehicleLoadingHistoryApiResponseToJson(
        List<GetVehicleLoadingHistoryApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetVehicleLoadingHistoryApiResponse {
  String status;
  String message;
  List<GetVehicleLoadingHistoryApiResponseDatum> data;

  GetVehicleLoadingHistoryApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetVehicleLoadingHistoryApiResponse.fromJson(
          Map<String, dynamic> json) =>
      GetVehicleLoadingHistoryApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetVehicleLoadingHistoryApiResponseDatum>.from(json["data"]
            .map((x) => GetVehicleLoadingHistoryApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetVehicleLoadingHistoryApiResponseDatum {
  String id;
  String historyId;
  String tempId;
  String productId;
  String packType;
  String availableQuantity;
  String row;
  String quantity;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String productName;
  String packagingName;

  GetVehicleLoadingHistoryApiResponseDatum({
    required this.id,
    required this.historyId,
    required this.tempId,
    required this.productId,
    required this.packType,
    required this.availableQuantity,
    required this.row,
    required this.quantity,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.productName,
    required this.packagingName,
  });

  factory GetVehicleLoadingHistoryApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetVehicleLoadingHistoryApiResponseDatum(
        id: json["id"] ?? "",
        historyId: json["history_id"] ?? "",
        tempId: json["temp_id"] ?? "",
        productId: json["product_id"] ?? "",
        packType: json["pack_type"] ?? "",
        availableQuantity: json["available_quantity"] ?? "",
        row: json["row"] ?? "",
        quantity: json["quantity"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        productName: json["product_name"] ?? "",
        packagingName: json["packaging_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "history_id": historyId,
        "temp_id": tempId,
        "product_id": productId,
        "pack_type": packType,
        "available_quantity": availableQuantity,
        "row": row,
        "quantity": quantity,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "product_name": productName,
        "packaging_name": packagingName,
      };
}
