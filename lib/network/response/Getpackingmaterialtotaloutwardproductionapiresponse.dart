// To parse this JSON data, do
//
//     final getpackingmaterialtotaloutwardproductionapiresponse = getpackingmaterialtotaloutwardproductionapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getpackingmaterialtotaloutwardproductionapiresponse>
    getpackingmaterialtotaloutwardproductionapiresponseFromJson(String str) =>
        List<Getpackingmaterialtotaloutwardproductionapiresponse>.from(json
            .decode(str)
            .map((x) =>
                Getpackingmaterialtotaloutwardproductionapiresponse.fromJson(
                    x)));

String getpackingmaterialtotaloutwardproductionapiresponseToJson(
        List<Getpackingmaterialtotaloutwardproductionapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getpackingmaterialtotaloutwardproductionapiresponse {
  String status;
  String message;
  List<GetpackingmaterialtotaloutwardproductionapiresponseDatum> data;

  Getpackingmaterialtotaloutwardproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getpackingmaterialtotaloutwardproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getpackingmaterialtotaloutwardproductionapiresponse(
        status: json["status"],
        message: json["message"],
        data:
            List<GetpackingmaterialtotaloutwardproductionapiresponseDatum>.from(
                json["data"].map((x) =>
                    GetpackingmaterialtotaloutwardproductionapiresponseDatum
                        .fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetpackingmaterialtotaloutwardproductionapiresponseDatum {
  String id;
  String tblMaterialDispatchLastId;
  String productId;
  String materialProductName;
  String itemName;
  String hiddenItemName;
  String pcs;
  String challanNo;
  DateTime date;
  String openingBalance;
  String materialPrLoss;
  String quantity;
  String closingBalance;
  String unit;
  dynamic dispatchHsnCode;
  String rate;
  String totalAmount;
  String inwardUsedQty;
  dynamic inwardQty;
  String inwardId;
  String rackId;
  String binId;
  String itemType;
  String currentItemPendingQty;
  String addedById;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String totalRawInwardMaterial;
  DateTime challanDate;
  String clientName;
  String branchName;

  GetpackingmaterialtotaloutwardproductionapiresponseDatum({
    required this.id,
    required this.tblMaterialDispatchLastId,
    required this.productId,
    required this.materialProductName,
    required this.itemName,
    required this.hiddenItemName,
    required this.pcs,
    required this.challanNo,
    required this.date,
    required this.openingBalance,
    required this.materialPrLoss,
    required this.quantity,
    required this.closingBalance,
    required this.unit,
    required this.dispatchHsnCode,
    required this.rate,
    required this.totalAmount,
    required this.inwardUsedQty,
    required this.inwardQty,
    required this.inwardId,
    required this.rackId,
    required this.binId,
    required this.itemType,
    required this.currentItemPendingQty,
    required this.addedById,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.totalRawInwardMaterial,
    required this.challanDate,
    required this.clientName,
    required this.branchName,
  });

  factory GetpackingmaterialtotaloutwardproductionapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetpackingmaterialtotaloutwardproductionapiresponseDatum(
        id: json["id"] ?? "",
        tblMaterialDispatchLastId: json["tbl_material_dispatch_last_id"] ?? "",
        productId: json["product_id"] ?? "",
        materialProductName: json["material_product_name"] ?? "",
        itemName: json["item_name"] ?? "",
        hiddenItemName: json["hidden_item_name"] ?? "",
        pcs: json["pcs"] ?? "",
        challanNo: json["challan_no"] ?? "",
        date: DateTime.parse(json["date"]),
        openingBalance: json["opening_balance"] ?? "",
        materialPrLoss: json["material_pr_loss"] ?? "",
        quantity: json["quantity"] ?? "",
        closingBalance: json["closing_balance"] ?? "",
        unit: json["unit"] ?? "",
        dispatchHsnCode: json["dispatch_hsn_code"] ?? "",
        rate: json["rate"] ?? "",
        totalAmount: json["total_amount"] ?? "",
        inwardUsedQty: json["inward_used_qty"] ?? "",
        inwardQty: json["inward_qty"] ?? "",
        inwardId: json["inward_id"] ?? "",
        rackId: json["rack_id"] ?? "",
        binId: json["bin_id"] ?? "",
        itemType: json["item_type"] ?? "",
        currentItemPendingQty: json["current_item_pending_qty"] ?? "",
        addedById: json["added_by_id"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: json["created_on"].isNotEmpty
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"].isNotEmpty
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        totalRawInwardMaterial: json["total_raw_inward_material"] ?? "",
        challanDate: DateTime.parse(json["challan_date"]),
        clientName: json["client_name"] ?? "",
        branchName: json["branch_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_material_dispatch_last_id": tblMaterialDispatchLastId,
        "product_id": productId,
        "material_product_name": materialProductName,
        "item_name": itemName,
        "hidden_item_name": hiddenItemName,
        "pcs": pcs,
        "challan_no": challanNo,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "opening_balance": openingBalance,
        "material_pr_loss": materialPrLoss,
        "quantity": quantity,
        "closing_balance": closingBalance,
        "unit": unit,
        "dispatch_hsn_code": dispatchHsnCode,
        "rate": rate,
        "total_amount": totalAmount,
        "inward_used_qty": inwardUsedQty,
        "inward_qty": inwardQty,
        "inward_id": inwardId,
        "rack_id": rackId,
        "bin_id": binId,
        "item_type": itemType,
        "current_item_pending_qty": currentItemPendingQty,
        "added_by_id": addedById,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "total_raw_inward_material": totalRawInwardMaterial,
        "challan_date":
            "${challanDate.year.toString().padLeft(4, '0')}-${challanDate.month.toString().padLeft(2, '0')}-${challanDate.day.toString().padLeft(2, '0')}",
        "client_name": clientName,
        "branch_name": branchName,
      };
}
