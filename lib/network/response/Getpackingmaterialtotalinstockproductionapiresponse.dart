// To parse this JSON data, do
//
//     final getpackingmaterialtotalinstockproductionapiresponse = getpackingmaterialtotalinstockproductionapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getpackingmaterialtotalinstockproductionapiresponse>
    getpackingmaterialtotalinstockproductionapiresponseFromJson(String str) =>
        List<Getpackingmaterialtotalinstockproductionapiresponse>.from(json
            .decode(str)
            .map((x) =>
                Getpackingmaterialtotalinstockproductionapiresponse.fromJson(
                    x)));

String getpackingmaterialtotalinstockproductionapiresponseToJson(
        List<Getpackingmaterialtotalinstockproductionapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getpackingmaterialtotalinstockproductionapiresponse {
  String status;
  String message;
  List<GetpackingmaterialtotalinstockproductionapiresponseDatum> data;

  Getpackingmaterialtotalinstockproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getpackingmaterialtotalinstockproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getpackingmaterialtotalinstockproductionapiresponse(
        status: json["status"],
        message: json["message"],
        data:
            List<GetpackingmaterialtotalinstockproductionapiresponseDatum>.from(
                json["data"].map((x) =>
                    GetpackingmaterialtotalinstockproductionapiresponseDatum
                        .fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetpackingmaterialtotalinstockproductionapiresponseDatum {
  String id;
  String clientId;
  String tblMaterialInwardId;
  String tblPackingItemId;
  String branchName;
  String packingUnitId;
  String packingDescription;
  String packingRate;
  String packingQty;
  String packingOpeningBalance;
  String packingBalanceQty;
  String packingTotal;
  String packingChallanNumber;
  DateTime packingChallanDate;
  String packingMaterialRackId;
  String packingMaterialBinId;
  dynamic usedDispatches;
  dynamic packingInwardTransporterId;
  String stockEntry;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String addedById;
  String materialMovingId;
  dynamic usedQty;
  String totalPackingInwardMaterial;
  String itemName;
  String clientName;

  GetpackingmaterialtotalinstockproductionapiresponseDatum({
    required this.id,
    required this.clientId,
    required this.tblMaterialInwardId,
    required this.tblPackingItemId,
    required this.branchName,
    required this.packingUnitId,
    required this.packingDescription,
    required this.packingRate,
    required this.packingQty,
    required this.packingOpeningBalance,
    required this.packingBalanceQty,
    required this.packingTotal,
    required this.packingChallanNumber,
    required this.packingChallanDate,
    required this.packingMaterialRackId,
    required this.packingMaterialBinId,
    required this.usedDispatches,
    required this.packingInwardTransporterId,
    required this.stockEntry,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.addedById,
    required this.materialMovingId,
    required this.usedQty,
    required this.totalPackingInwardMaterial,
    required this.itemName,
    required this.clientName,
  });

  factory GetpackingmaterialtotalinstockproductionapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetpackingmaterialtotalinstockproductionapiresponseDatum(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        tblMaterialInwardId: json["tbl_material_inward_id"] ?? "",
        tblPackingItemId: json["tbl_packing_item_id"] ?? "",
        branchName: json["branch_name"] ?? "",
        packingUnitId: json["packing_unit_id"] ?? "",
        packingDescription: json["packing_description"] ?? "",
        packingRate: json["packing_rate"] ?? "",
        packingQty: json["packing_qty"] ?? "",
        packingOpeningBalance: json["packing_opening_balance"] ?? "",
        packingBalanceQty: json["packing_balance_qty"] ?? "",
        packingTotal: json["packing_total"] ?? "",
        packingChallanNumber: json["packing_challan_number"] ?? "",
        packingChallanDate: DateTime.parse(json["packing_challan_date"]),
        packingMaterialRackId: json["packing_material_rack_id"] ?? "",
        packingMaterialBinId: json["packing_material_bin_id"] ?? "",
        usedDispatches: json["used_dispatches"] ?? "",
        packingInwardTransporterId: json["packing_inward_transporter_id"] ?? "",
        stockEntry: json["stock_entry"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        addedById: json["added_by_id"] ?? "",
        materialMovingId: json["material_moving_id"] ?? "",
        usedQty: json["used_qty"] ?? "",
        totalPackingInwardMaterial: json["total_packing_inward_material"] ?? "",
        itemName: json["item_name"] ?? "",
        clientName: json["client_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "tbl_material_inward_id": tblMaterialInwardId,
        "tbl_packing_item_id": tblPackingItemId,
        "branch_name": branchName,
        "packing_unit_id": packingUnitId,
        "packing_description": packingDescription,
        "packing_rate": packingRate,
        "packing_qty": packingQty,
        "packing_opening_balance": packingOpeningBalance,
        "packing_balance_qty": packingBalanceQty,
        "packing_total": packingTotal,
        "packing_challan_number": packingChallanNumber,
        "packing_challan_date":
            "${packingChallanDate.year.toString().padLeft(4, '0')}-${packingChallanDate.month.toString().padLeft(2, '0')}-${packingChallanDate.day.toString().padLeft(2, '0')}",
        "packing_material_rack_id": packingMaterialRackId,
        "packing_material_bin_id": packingMaterialBinId,
        "used_dispatches": usedDispatches,
        "packing_inward_transporter_id": packingInwardTransporterId,
        "stock_entry": stockEntry,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "added_by_id": addedById,
        "material_moving_id": materialMovingId,
        "used_qty": usedQty,
        "total_packing_inward_material": totalPackingInwardMaterial,
        "item_name": itemName,
        "client_name": clientName,
      };
}
