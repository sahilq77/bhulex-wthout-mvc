// To parse this JSON data, do
//
//     final getmoldmaterialtotaloutwardproductionapiresponse = getmoldmaterialtotaloutwardproductionapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getmoldmaterialtotaloutwardproductionapiresponse>
    getmoldmaterialtotaloutwardproductionapiresponseFromJson(String str) =>
        List<Getmoldmaterialtotaloutwardproductionapiresponse>.from(json
            .decode(str)
            .map((x) =>
                Getmoldmaterialtotaloutwardproductionapiresponse.fromJson(x)));

String getmoldmaterialtotaloutwardproductionapiresponseToJson(
        List<Getmoldmaterialtotaloutwardproductionapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getmoldmaterialtotaloutwardproductionapiresponse {
  String status;
  String message;
  List<GetmoldmaterialtotaloutwardproductionapiresponseDatum> data;

  Getmoldmaterialtotaloutwardproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getmoldmaterialtotaloutwardproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getmoldmaterialtotaloutwardproductionapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetmoldmaterialtotaloutwardproductionapiresponseDatum>.from(
            json["data"].map((x) =>
                GetmoldmaterialtotaloutwardproductionapiresponseDatum.fromJson(
                    x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetmoldmaterialtotaloutwardproductionapiresponseDatum {
  dynamic id;
  dynamic tblMaterialDispatchLastId;
  dynamic moldItemId;
  dynamic description;
  dynamic moldCode;
  dynamic avgQty;
  dynamic package;
  dynamic packType;
  dynamic quantity;
  dynamic unit;
  dynamic dispatchHsnCode;
  dynamic rate;
  dynamic amount;
  dynamic challanNo;
  dynamic challanDate;
  dynamic moldOpeningBalance;
  dynamic inputQuantity;
  dynamic moldClosingBalance;
  dynamic prLoss;
  dynamic moldMaterialInwardId;
  dynamic challanNumber;
  dynamic addedById;
  dynamic isDeleted;
  dynamic status;
  dynamic createdOn;
  dynamic updatedOn;
  dynamic totalMoldInwardMaterial;
  dynamic itemName;
  dynamic clientName;
  dynamic branchName;

  GetmoldmaterialtotaloutwardproductionapiresponseDatum({
    required this.id,
    required this.tblMaterialDispatchLastId,
    required this.moldItemId,
    required this.description,
    required this.moldCode,
    required this.avgQty,
    required this.package,
    required this.packType,
    required this.quantity,
    required this.unit,
    required this.dispatchHsnCode,
    required this.rate,
    required this.amount,
    required this.challanNo,
    required this.challanDate,
    required this.moldOpeningBalance,
    required this.inputQuantity,
    required this.moldClosingBalance,
    required this.prLoss,
    required this.moldMaterialInwardId,
    required this.challanNumber,
    required this.addedById,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.totalMoldInwardMaterial,
    required this.itemName,
    required this.clientName,
    required this.branchName,
  });

  factory GetmoldmaterialtotaloutwardproductionapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetmoldmaterialtotaloutwardproductionapiresponseDatum(
        id: json["id"] ?? "",
        tblMaterialDispatchLastId: json["tbl_material_dispatch_last_id"] ?? "",
        moldItemId: json["mold_item_id"] ?? "",
        description: json["description"] ?? "",
        moldCode: json["mold_code"] ?? "",
        avgQty: json["avg_qty"] ?? "",
        package: json["package"] ?? "",
        packType: json["pack_type"] ?? "",
        quantity: json["quantity"] ?? "",
        unit: json["unit"] ?? "",
        dispatchHsnCode: json["dispatch_hsn_code"] ?? "",
        rate: json["rate"] ?? "",
        amount: json["amount"] ?? "",
        challanNo: json["challan_no"] ?? "",
        challanDate: json["challan_date"] ?? "",
        moldOpeningBalance: json["mold_opening_balance"] ?? "",
        inputQuantity: json["input_quantity"] ?? "",
        moldClosingBalance: json["mold_closing_balance"] ?? "",
        prLoss: json["pr_loss"] ?? "",
        moldMaterialInwardId: json["mold_material_inward_id"] ?? "",
        challanNumber: json["challan_number"] ?? "",
        addedById: json["added_by_id"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: json["created_on"].isNotEmpty
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"].isNotEmpty
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        totalMoldInwardMaterial: json["total_mold_inward_material"] ?? "",
        itemName: json["item_name"] ?? "",
        clientName: json["client_name"] ?? "",
        branchName: json["branch_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_material_dispatch_last_id": tblMaterialDispatchLastId,
        "mold_item_id": moldItemId,
        "description": description,
        "mold_code": moldCode,
        "avg_qty": avgQty,
        "package": package,
        "pack_type": packType,
        "quantity": quantity,
        "unit": unit,
        "dispatch_hsn_code": dispatchHsnCode,
        "rate": rate,
        "amount": amount,
        "challan_no": challanNo,
        "challan_date": challanDate,
        "mold_opening_balance": moldOpeningBalance,
        "input_quantity": inputQuantity,
        "mold_closing_balance": moldClosingBalance,
        "pr_loss": prLoss,
        "mold_material_inward_id": moldMaterialInwardId,
        "challan_number": challanNumber,
        "added_by_id": addedById,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn,
        "updated_on": updatedOn,
        "total_mold_inward_material": totalMoldInwardMaterial,
        "item_name": itemName,
        "client_name": clientName,
        "branch_name": branchName,
      };
}
