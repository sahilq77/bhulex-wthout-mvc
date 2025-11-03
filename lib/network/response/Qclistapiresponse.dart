// To parse this JSON data, do
//
//     final qclistapiresponse = qclistapiresponseFromJson(jsonString);

import 'dart:convert';

List<Qclistapiresponse> qclistapiresponseFromJson(String str) =>
    List<Qclistapiresponse>.from(
        json.decode(str).map((x) => Qclistapiresponse.fromJson(x)));

String qclistapiresponseToJson(List<Qclistapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Qclistapiresponse {
  String status;
  String message;
  List<QclistapiresponseDatum> data;

  Qclistapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Qclistapiresponse.fromJson(Map<String, dynamic> json) =>
      Qclistapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<QclistapiresponseDatum>.from(
            json["data"].map((x) => QclistapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class QclistapiresponseDatum {
  String id;
  String productNameId;
  String orderId;
  String batchNumberId;
  DateTime productFlowDate;
  String producedQuantity;
  String clientId;
  String itemGroup;
  String branchId;
  String netWeight;
  String machineId;
  String approved;
  String approvedQuantity;
  String rejectedQuantity;
  String checkPointsExplained;
  String checkPointsUnderstood;
  DateTime date;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String cliName;
  String branch;
  String product;
  String machine;
  String order;
  dynamic batch;
  dynamic revised;

  QclistapiresponseDatum({
    required this.id,
    required this.productNameId,
    required this.orderId,
    required this.batchNumberId,
    required this.productFlowDate,
    required this.producedQuantity,
    required this.clientId,
    required this.itemGroup,
    required this.branchId,
    required this.netWeight,
    required this.machineId,
    required this.approved,
    required this.approvedQuantity,
    required this.rejectedQuantity,
    required this.checkPointsExplained,
    required this.checkPointsUnderstood,
    required this.date,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.cliName,
    required this.branch,
    required this.product,
    required this.machine,
    required this.order,
    required this.batch,
    required this.revised,
  });

  factory QclistapiresponseDatum.fromJson(Map<String, dynamic> json) =>
      QclistapiresponseDatum(
        id: json["id"] ?? "",
        productNameId: json["product_name_id"] ?? "",
        orderId: json["order_id"] ?? "",
        batchNumberId: json["batch_number_id"] ?? "",
        productFlowDate: json["product_flow_date"] != null
            ? DateTime.parse(json["product_flow_date"])
            : DateTime.now(),
        producedQuantity: json["produced_quantity"] ?? "0",
        clientId: json["client_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchId: json["branch_id"] ?? "",
        netWeight: json["net_weight"] ?? "0",
        machineId: json["machine_id"] ?? "",
        approved: json["approved"] ?? "",
        approvedQuantity: json["approved_quantity"] ?? "0",
        rejectedQuantity: json["rejected_quantity"] ?? "0",
        checkPointsExplained: json["check_points_explained"] ?? "",
        checkPointsUnderstood: json["check_points_understood"] ?? "",
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: json["created_on"] != null
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"] != null
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        cliName: json["cli_name"] ?? "",
        branch: json["branch"] ?? "",
        product: json["product"] ?? "",
        machine: json["machine"] ?? "",
        order: json["order"] ?? "",
        batch: json["batch"] ?? "",
        revised: json["revised"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name_id": productNameId,
        "order_id": orderId,
        "batch_number_id": batchNumberId,
        "product_flow_date":
            "${productFlowDate.year.toString().padLeft(4, '0')}-${productFlowDate.month.toString().padLeft(2, '0')}-${productFlowDate.day.toString().padLeft(2, '0')}",
        "produced_quantity": producedQuantity,
        "client_id": clientId,
        "item_group": itemGroup,
        "branch_id": branchId,
        "net_weight": netWeight,
        "machine_id": machineId,
        "approved": approved,
        "approved_quantity": approvedQuantity,
        "rejected_quantity": rejectedQuantity,
        "check_points_explained": checkPointsExplained,
        "check_points_understood": checkPointsUnderstood,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "cli_name": cliName,
        "branch": branch,
        "product": product,
        "machine": machine,
        "order": order,
        "batch": batch,
        "revised": revised,
      };
}
