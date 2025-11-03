// To parse this JSON data, do
//
//     final generateorderupdateapiapiresponse = generateorderupdateapiapiresponseFromJson(jsonString);

import 'dart:convert';

Generateorderupdateapiapiresponse generateorderupdateapiapiresponseFromJson(
        String str) =>
    Generateorderupdateapiapiresponse.fromJson(json.decode(str));

String generateorderupdateapiapiresponseToJson(
        Generateorderupdateapiapiresponse data) =>
    json.encode(data.toJson());

class Generateorderupdateapiapiresponse {
  String status;
  String message;
  GenerateorderupdateapiapiresponseData data;

  Generateorderupdateapiapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Generateorderupdateapiapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Generateorderupdateapiapiresponse(
        status: json["status"],
        message: json["message"],
        data: GenerateorderupdateapiapiresponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class GenerateorderupdateapiapiresponseData {
  String id;
  String clientNameId;
  dynamic itemGroup;
  dynamic branchNameId;
  String orderId;
  String orderDate;
  String time;
  dynamic revisedId;
  String reworkStatus;
  dynamic qcId;
  dynamic addedById;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  GenerateorderupdateapiapiresponseData({
    required this.id,
    required this.clientNameId,
    required this.itemGroup,
    required this.branchNameId,
    required this.orderId,
    required this.orderDate,
    required this.time,
    required this.revisedId,
    required this.reworkStatus,
    required this.qcId,
    required this.addedById,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GenerateorderupdateapiapiresponseData.fromJson(
          Map<String, dynamic> json) =>
      GenerateorderupdateapiapiresponseData(
        id: json["id"] ?? "",
        clientNameId: json["client_name_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchNameId: json["branch_name_id"] ?? "",
        orderId: json["order_id"] ?? "",
        orderDate: json["order_date"] ?? "",
        time: json["time"] ?? "",
        revisedId: json["revised_id"] ?? "",
        reworkStatus: json["rework_status"] ?? "",
        qcId: json["qc_id"] ?? "",
        addedById: json["added_by_id"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_name_id": clientNameId,
        "item_group": itemGroup,
        "branch_name_id": branchNameId,
        "order_id": orderId,
        "order_date": orderDate,
        "time": time,
        "revised_id": revisedId,
        "rework_status": reworkStatus,
        "qc_id": qcId,
        "added_by_id": addedById,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
