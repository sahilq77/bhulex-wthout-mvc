// To parse this JSON data, do
//
//     final getMoldMaterialTotalInStockProductionApiresponse = getMoldMaterialTotalInStockProductionApiresponseFromJson(jsonString);

import 'dart:convert';

List<GetMoldMaterialTotalInStockProductionApiresponse>
    getMoldMaterialTotalInStockProductionApiresponseFromJson(String str) =>
        List<GetMoldMaterialTotalInStockProductionApiresponse>.from(json
            .decode(str)
            .map((x) =>
                GetMoldMaterialTotalInStockProductionApiresponse.fromJson(x)));

String getMoldMaterialTotalInStockProductionApiresponseToJson(
        List<GetMoldMaterialTotalInStockProductionApiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMoldMaterialTotalInStockProductionApiresponse {
  String status;
  String message;
  List<GetMoldMaterialTotalInStockProductionApiresponseDatum> data;

  GetMoldMaterialTotalInStockProductionApiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMoldMaterialTotalInStockProductionApiresponse.fromJson(
          Map<String, dynamic> json) =>
      GetMoldMaterialTotalInStockProductionApiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetMoldMaterialTotalInStockProductionApiresponseDatum>.from(
            json["data"].map((x) =>
                GetMoldMaterialTotalInStockProductionApiresponseDatum.fromJson(
                    x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetMoldMaterialTotalInStockProductionApiresponseDatum {
  String id;
  String clientId;
  String tblMaterialInwardId;
  String tblMoldItemId;
  String branchName;
  String moldUnitId;
  String moldDescription;
  String moldRate;
  String moldQty;
  String moldOpeningBalance;
  String moldBalanceQty;
  String moldTotal;
  String moldMaterialRackId;
  String moldMaterialBinId;
  String materialChallanNumber;
  DateTime materialChallanDate;
  dynamic moldInwardTransporterId;
  String stockEntry;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String addedById;
  String materialMovingId;
  dynamic usedQty;
  String totalMoldInwardMaterial;
  String itemName;
  String clientName;

  GetMoldMaterialTotalInStockProductionApiresponseDatum({
    required this.id,
    required this.clientId,
    required this.tblMaterialInwardId,
    required this.tblMoldItemId,
    required this.branchName,
    required this.moldUnitId,
    required this.moldDescription,
    required this.moldRate,
    required this.moldQty,
    required this.moldOpeningBalance,
    required this.moldBalanceQty,
    required this.moldTotal,
    required this.moldMaterialRackId,
    required this.moldMaterialBinId,
    required this.materialChallanNumber,
    required this.materialChallanDate,
    required this.moldInwardTransporterId,
    required this.stockEntry,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.addedById,
    required this.materialMovingId,
    required this.usedQty,
    required this.totalMoldInwardMaterial,
    required this.itemName,
    required this.clientName,
  });

  factory GetMoldMaterialTotalInStockProductionApiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetMoldMaterialTotalInStockProductionApiresponseDatum(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        tblMaterialInwardId: json["tbl_material_inward_id"] ?? "",
        tblMoldItemId: json["tbl_mold_item_id"] ?? "",
        branchName: json["branch_name"] ?? "",
        moldUnitId: json["mold_unit_id"] ?? "",
        moldDescription: json["mold_description"] ?? "",
        moldRate: json["mold_rate"] ?? "",
        moldQty: json["mold_qty"] ?? "",
        moldOpeningBalance: json["mold_opening_balance"] ?? "",
        moldBalanceQty: json["mold_balance_qty"] ?? "",
        moldTotal: json["mold_total"] ?? "",
        moldMaterialRackId: json["mold_material_rack_id"] ?? "",
        moldMaterialBinId: json["mold_material_bin_id"] ?? "",
        materialChallanNumber: json["material_challan_number"] ?? "",
        materialChallanDate: DateTime.parse(json["material_challan_date"]),
        moldInwardTransporterId: json["mold_inward_transporter_id"] ?? "",
        stockEntry: json["stock_entry"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        addedById: json["added_by_id"] ?? "",
        materialMovingId: json["material_moving_id"] ?? "",
        usedQty: json["used_qty"] ?? "",
        totalMoldInwardMaterial: json["total_mold_inward_material"] ?? "",
        itemName: json["item_name"] ?? "",
        clientName: json["client_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "tbl_material_inward_id": tblMaterialInwardId,
        "tbl_mold_item_id": tblMoldItemId,
        "branch_name": branchName,
        "mold_unit_id": moldUnitId,
        "mold_description": moldDescription,
        "mold_rate": moldRate,
        "mold_qty": moldQty,
        "mold_opening_balance": moldOpeningBalance,
        "mold_balance_qty": moldBalanceQty,
        "mold_total": moldTotal,
        "mold_material_rack_id": moldMaterialRackId,
        "mold_material_bin_id": moldMaterialBinId,
        "material_challan_number": materialChallanNumber,
        "material_challan_date":
            "${materialChallanDate.year.toString().padLeft(4, '0')}-${materialChallanDate.month.toString().padLeft(2, '0')}-${materialChallanDate.day.toString().padLeft(2, '0')}",
        "mold_inward_transporter_id": moldInwardTransporterId,
        "stock_entry": stockEntry,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "added_by_id": addedById,
        "material_moving_id": materialMovingId,
        "used_qty": usedQty,
        "total_mold_inward_material": totalMoldInwardMaterial,
        "item_name": itemName,
        "client_name": clientName,
      };
}
