// To parse this JSON data, do
//
//     final rawmaterialdispatchlistapiresponse = rawmaterialdispatchlistapiresponseFromJson(jsonString);

import 'dart:convert';

List<Rawmaterialdispatchlistapiresponse>
    rawmaterialdispatchlistapiresponseFromJson(String str) =>
        List<Rawmaterialdispatchlistapiresponse>.from(json
            .decode(str)
            .map((x) => Rawmaterialdispatchlistapiresponse.fromJson(x)));

String rawmaterialdispatchlistapiresponseToJson(
        List<Rawmaterialdispatchlistapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rawmaterialdispatchlistapiresponse {
  String status;
  String message;
  List<RawmaterialdispatchlistapiresponseDatum> data;

  Rawmaterialdispatchlistapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Rawmaterialdispatchlistapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Rawmaterialdispatchlistapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<RawmaterialdispatchlistapiresponseDatum>.from(json["data"]
            .map((x) => RawmaterialdispatchlistapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RawmaterialdispatchlistapiresponseDatum {
  String id;
  String tblMaterialDispatchLastId;
  String rawItemId;
  String description;
  String avgQty;
  String package;
  String packType;
  String quantity;
  String unit;
  String dispatchHsnCode;
  String rate;
  String amount;
  dynamic challanNo;
  DateTime challanDate;
  String rawOpeningBalance;
  String inputQuantity;
  String rawClosingBalance;
  String prLoss;
  String rawMaterialInwardId;
  String challanNumber;
  String addedById;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String itemName;
  String packagingName;
  String financialYear;
  String clientName;
  String itemGroup;
  String branchName;
  dynamic product;
  String poNumber;
  String poDate;
  String name;
  String vehicleNumber;
  String lrNumber;
  String remarks;
  String dispatchType;
  dynamic natureOfProcess;
  String approveStatus;
  String client;
  String branch;
  dynamic natureOfProcessing;

  RawmaterialdispatchlistapiresponseDatum({
    required this.id,
    required this.tblMaterialDispatchLastId,
    required this.rawItemId,
    required this.description,
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
    required this.rawOpeningBalance,
    required this.inputQuantity,
    required this.rawClosingBalance,
    required this.prLoss,
    required this.rawMaterialInwardId,
    required this.challanNumber,
    required this.addedById,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.itemName,
    required this.packagingName,
    required this.financialYear,
    required this.clientName,
    required this.itemGroup,
    required this.branchName,
    required this.product,
    required this.poNumber,
    required this.poDate,
    required this.name,
    required this.vehicleNumber,
    required this.lrNumber,
    required this.remarks,
    required this.dispatchType,
    required this.natureOfProcess,
    required this.approveStatus,
    required this.client,
    required this.branch,
    required this.natureOfProcessing,
  });

  factory RawmaterialdispatchlistapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      RawmaterialdispatchlistapiresponseDatum(
        id: json["id"] ?? "",
        tblMaterialDispatchLastId: json["tbl_material_dispatch_last_id"] ?? "",
        rawItemId: json["raw_item_id"] ?? "",
        description: json["description"] ?? "",
        avgQty: json["avg_qty"] ?? "",
        package: json["package"] ?? "",
        packType: json["pack_type"] ?? "",
        quantity: json["quantity"] ?? "",
        unit: json["unit"] ?? "",
        dispatchHsnCode: json["dispatch_hsn_code"] ?? "",
        rate: json["rate"] ?? "",
        amount: json["amount"] ?? "",
        challanNo: json["challan_no"] ?? "",
        challanDate: DateTime.parse(json["challan_date"] ?? ""),
        rawOpeningBalance: json["raw_opening_balance"] ?? "",
        inputQuantity: json["input_quantity"] ?? "",
        rawClosingBalance: json["raw_closing_balance"] ?? "",
        prLoss: json["pr_loss"] ?? "",
        rawMaterialInwardId: json["raw_material_inward_id"] ?? "",
        challanNumber: json["challan_number"] ?? "",
        addedById: json["added_by_id"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        itemName: json["item_name"] ?? "",
        packagingName: json["packaging_name"] ?? "",
        financialYear: json["financial_year"] ?? "",
        clientName: json["client_name"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchName: json["branch_name"] ?? "",
        product: json["product"] ?? "",
        poNumber: json["po_number"] ?? "",
        poDate: json["po_date"] ?? "",
        name: json["name"] ?? "",
        vehicleNumber: json["vehicle_number"] ?? "",
        lrNumber: json["lr_number"] ?? "",
        remarks: json["remarks"] ?? "",
        dispatchType: json["dispatch_type"] ?? "",
        natureOfProcess: json["nature_of_process"] ?? "",
        approveStatus: json["approve_status"] ?? "",
        client: json["client"] ?? "",
        branch: json["branch"] ?? "",
        natureOfProcessing: json["nature_of_processing"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_material_dispatch_last_id": tblMaterialDispatchLastId,
        "raw_item_id": rawItemId,
        "description": description,
        "avg_qty": avgQty,
        "package": package,
        "pack_type": packType,
        "quantity": quantity,
        "unit": unit,
        "dispatch_hsn_code": dispatchHsnCode,
        "rate": rate,
        "amount": amount,
        "challan_no": challanNo,
        "challan_date":
            "${challanDate.year.toString().padLeft(4, '0')}-${challanDate.month.toString().padLeft(2, '0')}-${challanDate.day.toString().padLeft(2, '0')}",
        "raw_opening_balance": rawOpeningBalance,
        "input_quantity": inputQuantity,
        "raw_closing_balance": rawClosingBalance,
        "pr_loss": prLoss,
        "raw_material_inward_id": rawMaterialInwardId,
        "challan_number": challanNumber,
        "added_by_id": addedById,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "item_name": itemName,
        "packaging_name": packagingName,
        "financial_year": financialYear,
        "client_name": clientName,
        "item_group": itemGroup,
        "branch_name": branchName,
        "product": product,
        "po_number": poNumber,
        "po_date": poDate,
        "name": name,
        "vehicle_number": vehicleNumber,
        "lr_number": lrNumber,
        "remarks": remarks,
        "dispatch_type": dispatchType,
        "nature_of_process": natureOfProcess,
        "approve_status": approveStatus,
        "client": client,
        "branch": branch,
        "nature_of_processing": natureOfProcessing,
      };
}
