// To parse this JSON data, do
//
//     final generateorderupdateentryapiresponse = generateorderupdateentryapiresponseFromJson(jsonString);

import 'dart:convert';

List<Generateorderupdateentryapiresponse>
    generateorderupdateentryapiresponseFromJson(String str) =>
        List<Generateorderupdateentryapiresponse>.from(json
            .decode(str)
            .map((x) => Generateorderupdateentryapiresponse.fromJson(x)));

String generateorderupdateentryapiresponseToJson(
        List<Generateorderupdateentryapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Generateorderupdateentryapiresponse {
  String status;
  String message;
  List<GenerateorderupdateentryapiresponseDatum> data;

  Generateorderupdateentryapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Generateorderupdateentryapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Generateorderupdateentryapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GenerateorderupdateentryapiresponseDatum>.from(json["data"]
            .map((x) => GenerateorderupdateentryapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GenerateorderupdateentryapiresponseDatum {
  BatchData batchData;
  String id;
  String tblGenerateOrderLastId;
  String clientNameId;
  String itemGroup;
  String branchNameId;
  String orderId;
  dynamic qcId;
  String productName;
  String orderAmount;
  String updateOrderAmount;
  String reworkStatus;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String branchName;
  String orderDate;
  String time;
  String client;
  String branch;
  String product;

  GenerateorderupdateentryapiresponseDatum({
    required this.batchData,
    required this.id,
    required this.tblGenerateOrderLastId,
    required this.clientNameId,
    required this.itemGroup,
    required this.branchNameId,
    required this.orderId,
    required this.qcId,
    required this.productName,
    required this.orderAmount,
    required this.updateOrderAmount,
    required this.reworkStatus,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.branchName,
    required this.orderDate,
    required this.time,
    required this.client,
    required this.branch,
    required this.product,
  });

  factory GenerateorderupdateentryapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GenerateorderupdateentryapiresponseDatum(
        batchData: BatchData.fromJson(json["batch_data"]),
        id: json["id"] ?? "",
        tblGenerateOrderLastId: json["tbl_generate_order_last_id"] ?? "",
        clientNameId: json["client_name_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchNameId: json["branch_name_id"] ?? "",
        orderId: json["order_id"] ?? "",
        qcId: json["qc_id"] ?? "",
        productName: json["product_name"] ?? "",
        orderAmount: json["order_amount"] ?? "",
        updateOrderAmount: json["update_order_amount"] ?? "",
        reworkStatus: json["rework_status"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        branchName: json["branch_name"] ?? "",
        orderDate: json["order_date"] ?? "",
        time: json["time"] ?? "",
        client: json["client"] ?? "",
        branch: json["branch"] ?? "",
        product: json["product"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "batch_data": batchData.toJson(),
        "id": id,
        "tbl_generate_order_last_id": tblGenerateOrderLastId,
        "client_name_id": clientNameId,
        "item_group": itemGroup,
        "branch_name_id": branchNameId,
        "order_id": orderId,
        "qc_id": qcId,
        "product_name": productName,
        "order_amount": orderAmount,
        "update_order_amount": updateOrderAmount,
        "rework_status": reworkStatus,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "branch_name": branchName,
        "order_date": orderDate,
        "time": time,
        "client": client,
        "branch": branch,
        "product": product,
      };
}

class BatchData {
  String id;
  String tblBatchLastId;
  String product;
  String orderQuantity;
  String orderId;
  String batchQuantity;
  String balanceQuantity;
  String batchNumber;
  String machineId;
  String generateOrderId;
  String clientId;
  String itemGroup;
  String branchId;
  DateTime batchDate;
  String batchProcessingStatus;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String producedQuantity;
  String productOrderId;
  dynamic holdRemark;
  String stopRemark;
  String jobcardCreateStatus;
  String batchType;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  BatchData({
    required this.id,
    required this.tblBatchLastId,
    required this.product,
    required this.orderQuantity,
    required this.orderId,
    required this.batchQuantity,
    required this.balanceQuantity,
    required this.batchNumber,
    required this.machineId,
    required this.generateOrderId,
    required this.clientId,
    required this.itemGroup,
    required this.branchId,
    required this.batchDate,
    required this.batchProcessingStatus,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.producedQuantity,
    required this.productOrderId,
    required this.holdRemark,
    required this.stopRemark,
    required this.jobcardCreateStatus,
    required this.batchType,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory BatchData.fromJson(Map<String, dynamic> json) => BatchData(
        id: json["id"],
        tblBatchLastId: json["tbl_batch_last_id"],
        product: json["product"],
        orderQuantity: json["order_quantity"],
        orderId: json["order_id"],
        batchQuantity: json["batch_quantity"],
        balanceQuantity: json["balance_quantity"],
        batchNumber: json["batch_number"],
        machineId: json["machine_id"],
        generateOrderId: json["generate_order_id"],
        clientId: json["client_id"],
        itemGroup: json["item_group"],
        branchId: json["branch_id"],
        batchDate: DateTime.parse(json["batch_date"]),
        batchProcessingStatus: json["batch_processing_status"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        producedQuantity: json["produced_quantity"],
        productOrderId: json["product_order_id"],
        holdRemark: json["hold_remark"],
        stopRemark: json["stop_remark"],
        jobcardCreateStatus: json["jobcard_create_status"],
        batchType: json["batch_type"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_batch_last_id": tblBatchLastId,
        "product": product,
        "order_quantity": orderQuantity,
        "order_id": orderId,
        "batch_quantity": batchQuantity,
        "balance_quantity": balanceQuantity,
        "batch_number": batchNumber,
        "machine_id": machineId,
        "generate_order_id": generateOrderId,
        "client_id": clientId,
        "item_group": itemGroup,
        "branch_id": branchId,
        "batch_date":
            "${batchDate.year.toString().padLeft(4, '0')}-${batchDate.month.toString().padLeft(2, '0')}-${batchDate.day.toString().padLeft(2, '0')}",
        "batch_processing_status": batchProcessingStatus,
        "start_date": startDate,
        "start_time": startTime,
        "end_date": endDate,
        "end_time": endTime,
        "produced_quantity": producedQuantity,
        "product_order_id": productOrderId,
        "hold_remark": holdRemark,
        "stop_remark": stopRemark,
        "jobcard_create_status": jobcardCreateStatus,
        "batch_type": batchType,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
