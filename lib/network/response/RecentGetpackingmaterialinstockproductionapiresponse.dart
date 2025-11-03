// To parse this JSON data, do
//
//     final recentGetpackingmaterialinstockproductionapiresponse = recentGetpackingmaterialinstockproductionapiresponseFromJson(jsonString);

import 'dart:convert';

List<RecentGetpackingmaterialinstockproductionapiresponse>
    getpackingmaterialinstockproductionapiresponseFromJson(String str) =>
        List<RecentGetpackingmaterialinstockproductionapiresponse>.from(json
            .decode(str)
            .map((x) =>
                RecentGetpackingmaterialinstockproductionapiresponse.fromJson(
                    x)));

String recentGetpackingmaterialinstockproductionapiresponseToJson(
        List<RecentGetpackingmaterialinstockproductionapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentGetpackingmaterialinstockproductionapiresponse {
  String status;
  String message;
  List<RecentGetpackingmaterialinstockproductionapiresponseData> data;

  RecentGetpackingmaterialinstockproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RecentGetpackingmaterialinstockproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      RecentGetpackingmaterialinstockproductionapiresponse(
        status: json["status"],
        message: json["message"],
        data:
            List<RecentGetpackingmaterialinstockproductionapiresponseData>.from(
                json["data"].map((x) =>
                    RecentGetpackingmaterialinstockproductionapiresponseData
                        .fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RecentGetpackingmaterialinstockproductionapiresponseData {
  String id;
  String clientId;
  String branchId;
  String itemGroup;
  String materialType;
  String materialId;
  String stockQty;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String clientName;
  String branchName;
  String itemName;

  RecentGetpackingmaterialinstockproductionapiresponseData({
    required this.id,
    required this.clientId,
    required this.branchId,
    required this.itemGroup,
    required this.materialType,
    required this.materialId,
    required this.stockQty,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.clientName,
    required this.branchName,
    required this.itemName,
  });

  factory RecentGetpackingmaterialinstockproductionapiresponseData.fromJson(
          Map<String, dynamic> json) =>
      RecentGetpackingmaterialinstockproductionapiresponseData(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        branchId: json["branch_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        materialType: json["material_type"] ?? "",
        materialId: json["material_id"] ?? "",
        stockQty: json["stock_qty"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"],
        createdOn: json["created_on"] != ""
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"] != ""
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        clientName: json["client_name"] ?? "",
        branchName: json["branch_name"] ?? "",
        itemName: json["item_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "branch_id": branchId,
        "item_group": itemGroup,
        "material_type": materialType,
        "material_id": materialId,
        "stock_qty": stockQty,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "client_name": clientName,
        "branch_name": branchName,
        "item_name": itemName,
      };
}
