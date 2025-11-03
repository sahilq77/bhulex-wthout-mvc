// To parse this JSON data, do
//
//     final gettotalcompletedorderapiresponse = gettotalcompletedorderapiresponseFromJson(jsonString);

import 'dart:convert';

List<Gettotalcompletedorderapiresponse>
    gettotalcompletedorderapiresponseFromJson(String str) =>
        List<Gettotalcompletedorderapiresponse>.from(json
            .decode(str)
            .map((x) => Gettotalcompletedorderapiresponse.fromJson(x)));

String gettotalcompletedorderapiresponseToJson(
        List<Gettotalcompletedorderapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gettotalcompletedorderapiresponse {
  String status;
  String message;
  List<GettotalcompletedorderapiresponseDatum> data;

  Gettotalcompletedorderapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Gettotalcompletedorderapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Gettotalcompletedorderapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: List<GettotalcompletedorderapiresponseDatum>.from(json["data"]
            .map((x) => GettotalcompletedorderapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GettotalcompletedorderapiresponseDatum {
  String id;
  String clientNameId;
  String itemGroup;
  String branchNameId;
  String productNameId;
  String approvedQuantity;
  String avgQty;
  String package;
  String quantity;
  String rackId;
  String binId;
  String qcId;
  String status;
  String isDeleted;
  DateTime createdOn;
  DateTime updatedOn;
  String clientName;
  String branchName;
  String productName;

  GettotalcompletedorderapiresponseDatum({
    required this.id,
    required this.clientNameId,
    required this.itemGroup,
    required this.branchNameId,
    required this.productNameId,
    required this.approvedQuantity,
    required this.avgQty,
    required this.package,
    required this.quantity,
    required this.rackId,
    required this.binId,
    required this.qcId,
    required this.status,
    required this.isDeleted,
    required this.createdOn,
    required this.updatedOn,
    required this.clientName,
    required this.branchName,
    required this.productName,
  });

  factory GettotalcompletedorderapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GettotalcompletedorderapiresponseDatum(
        id: json["id"] ?? "",
        clientNameId: json["client_name_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchNameId: json["branch_name_id"] ?? "",
        productNameId: json["product_name_id"] ?? "",
        approvedQuantity: json["approved_quantity"] ?? "",
        avgQty: json["avg_qty"] ?? "",
        package: json["package"] ?? "",
        quantity: json["quantity"] ?? "",
        rackId: json["rack_id"] ?? "",
        binId: json["bin_id"] ?? "",
        qcId: json["qc_id"] ?? "",
        status: json["status"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        clientName: json["client_name"] ?? "",
        branchName: json["branch_name"] ?? "",
        productName: json["product_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_name_id": clientNameId,
        "item_group": itemGroup,
        "branch_name_id": branchNameId,
        "product_name_id": productNameId,
        "approved_quantity": approvedQuantity,
        "avg_qty": avgQty,
        "package": package,
        "quantity": quantity,
        "rack_id": rackId,
        "bin_id": binId,
        "qc_id": qcId,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "client_name": clientName,
        "branch_name": branchName,
        "product_name": productName,
      };
}
