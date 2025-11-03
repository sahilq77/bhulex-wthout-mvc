// To parse this JSON data, do
//
//     final getallbatchlistapiresponse = getallbatchlistapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getallbatchlistapiresponse> getallbatchlistapiresponseFromJson(
        String str) =>
    List<Getallbatchlistapiresponse>.from(
        json.decode(str).map((x) => Getallbatchlistapiresponse.fromJson(x)));

String getallbatchlistapiresponseToJson(
        List<Getallbatchlistapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getallbatchlistapiresponse {
  String status;
  String message;
  List<GetallbatchlistapiresponseDatum> data;

  Getallbatchlistapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getallbatchlistapiresponse.fromJson(Map<String, dynamic> json) =>
      Getallbatchlistapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetallbatchlistapiresponseDatum>.from(json["data"]
            .map((x) => GetallbatchlistapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetallbatchlistapiresponseDatum {
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
  dynamic endDate;
  dynamic endTime;
  String producedQuantity;
  String productOrderId;
  String holdRemark;
  dynamic stopRemark;
  String jobcardCreateStatus;
  String batchType;
  dynamic batchBalanceQuantity;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String machine;
  String productName;
  String client;
  String previous_quantity;
  GetallbatchlistapiresponseDatum({
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
    required this.batchBalanceQuantity,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.machine,
    required this.productName,
    required this.client,
    required this.previous_quantity,
  });

  factory GetallbatchlistapiresponseDatum.fromJson(Map<String, dynamic> json) =>
      GetallbatchlistapiresponseDatum(
        id: json["id"] ?? "",
        tblBatchLastId: json["tbl_batch_last_id"] ?? "",
        product: json["product"] ?? "",
        orderQuantity: json["order_quantity"] ?? "",
        orderId: json["order_id"] ?? "",
        batchQuantity: json["batch_quantity"] ?? "",
        balanceQuantity: json["balance_quantity"] ?? "",
        batchNumber: json["batch_number"] ?? "",
        machineId: json["machine_id"] ?? "",
        generateOrderId: json["generate_order_id"] ?? "",
        clientId: json["client_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchId: json["branch_id"] ?? "",
        batchDate: DateTime.parse(json["batch_date"]),
        batchProcessingStatus: json["batch_processing_status"] ?? "",
        startDate: json["start_date"] ?? "",
        startTime: json["start_time"] ?? "",
        endDate: json["end_date"] ?? "",
        endTime: json["end_time"] ?? "",
        producedQuantity: json["produced_quantity"] ?? "",
        productOrderId: json["product_order_id"] ?? "",
        holdRemark: json["hold_remark"] ?? "",
        stopRemark: json["stop_remark"] ?? "",
        jobcardCreateStatus: json["jobcard_create_status"] ?? "",
        batchType: json["batch_type"] ?? "",
        batchBalanceQuantity: json["batch_balance_quantity"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        machine: json["machine"] ?? "",
        productName: json["product_name"] ?? "",
        client: json["client"] ?? "",
        previous_quantity: json["previous_quantity"] ?? "",
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
        "batch_balance_quantity": batchBalanceQuantity,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "machine": machine,
        "product_name": productName,
        "client": client,
        "previous_quantity": previous_quantity,
      };
}
