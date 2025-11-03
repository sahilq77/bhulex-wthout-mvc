// To parse this JSON data, do
//
//     final getrawmaterialtotalinstockproductionapiresponse = getrawmaterialtotalinstockproductionapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getrawmaterialtotalinstockproductionapiresponse>
    getrawmaterialtotalinstockproductionapiresponseFromJson(String str) =>
        List<Getrawmaterialtotalinstockproductionapiresponse>.from(json
            .decode(str)
            .map((x) =>
                Getrawmaterialtotalinstockproductionapiresponse.fromJson(x)));

String getrawmaterialtotalinstockproductionapiresponseToJson(
        List<Getrawmaterialtotalinstockproductionapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getrawmaterialtotalinstockproductionapiresponse {
  String status;
  String message;
  List<GetrawmaterialtotalinstockproductionapiresponseDatum> data;

  Getrawmaterialtotalinstockproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getrawmaterialtotalinstockproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getrawmaterialtotalinstockproductionapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: List<GetrawmaterialtotalinstockproductionapiresponseDatum>.from(
            json["data"].map((x) =>
                GetrawmaterialtotalinstockproductionapiresponseDatum.fromJson(
                    x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetrawmaterialtotalinstockproductionapiresponseDatum {
  String id;
  String clientId;
  dynamic tblBranchId;
  String tblMaterialInwardId;
  String tblItemId;
  String branchName;
  String unitId;
  String materialChallanNumber;
  DateTime materialChallanDate;
  String description;
  String rate;
  String qty;
  String openingBalance;
  String balanceQty;
  dynamic productName;
  String total;
  String materialRackId;
  String materialBinId;
  dynamic usedDispatches;
  String inwardTransporterId;
  String stockEntry;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String addedById;
  String materialMovingId;
  dynamic usedQty;
  String totalRawInwardMaterial;
  String itemName;
  String clientName;

  GetrawmaterialtotalinstockproductionapiresponseDatum({
    required this.id,
    required this.clientId,
    required this.tblBranchId,
    required this.tblMaterialInwardId,
    required this.tblItemId,
    required this.branchName,
    required this.unitId,
    required this.materialChallanNumber,
    required this.materialChallanDate,
    required this.description,
    required this.rate,
    required this.qty,
    required this.openingBalance,
    required this.balanceQty,
    required this.productName,
    required this.total,
    required this.materialRackId,
    required this.materialBinId,
    required this.usedDispatches,
    required this.inwardTransporterId,
    required this.stockEntry,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.addedById,
    required this.materialMovingId,
    required this.usedQty,
    required this.totalRawInwardMaterial,
    required this.itemName,
    required this.clientName,
  });

  factory GetrawmaterialtotalinstockproductionapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetrawmaterialtotalinstockproductionapiresponseDatum(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        tblBranchId: json["tbl_branch_id"] ?? "",
        tblMaterialInwardId: json["tbl_material_inward_id"] ?? "",
        tblItemId: json["tbl_item_id"] ?? "",
        branchName: json["branch_name"] ?? "",
        unitId: json["unit_id"] ?? "",
        materialChallanNumber: json["material_challan_number"] ?? "",
        materialChallanDate: DateTime.parse(json["material_challan_date"]),
        description: json["description"] ?? "",
        rate: json["rate"] ?? "",
        qty: json["qty"] ?? "",
        openingBalance: json["opening_balance"] ?? "",
        balanceQty: json["balance_qty"] ?? "",
        productName: json["product_name"] ?? "",
        total: json["total"] ?? "",
        materialRackId: json["material_rack_id"] ?? "",
        materialBinId: json["material_bin_id"] ?? "",
        usedDispatches: json["used_dispatches"] ?? "",
        inwardTransporterId: json["inward_transporter_id"] ?? "",
        stockEntry: json["stock_entry"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        addedById: json["added_by_id"] ?? "",
        materialMovingId: json["material_moving_id"] ?? "",
        usedQty: json["used_qty"] ?? "",
        totalRawInwardMaterial: json["total_raw_inward_material"] ?? "",
        itemName: json["item_name"] ?? "",
        clientName: json["client_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "tbl_branch_id": tblBranchId,
        "tbl_material_inward_id": tblMaterialInwardId,
        "tbl_item_id": tblItemId,
        "branch_name": branchName,
        "unit_id": unitId,
        "material_challan_number": materialChallanNumber,
        "material_challan_date":
            "${materialChallanDate.year.toString().padLeft(4, '0')}-${materialChallanDate.month.toString().padLeft(2, '0')}-${materialChallanDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "rate": rate,
        "qty": qty,
        "opening_balance": openingBalance,
        "balance_qty": balanceQty,
        "product_name": productName,
        "total": total,
        "material_rack_id": materialRackId,
        "material_bin_id": materialBinId,
        "used_dispatches": usedDispatches,
        "inward_transporter_id": inwardTransporterId,
        "stock_entry": stockEntry,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "added_by_id": addedById,
        "material_moving_id": materialMovingId,
        "used_qty": usedQty,
        "total_raw_inward_material": totalRawInwardMaterial,
        "item_name": itemName,
        "client_name": clientName,
      };
}
