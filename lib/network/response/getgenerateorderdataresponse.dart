import 'dart:convert';

List<Getgenerateorderdataresponse> getgenerateorderdataresponseFromJson(
        String str) =>
    List<Getgenerateorderdataresponse>.from(
        json.decode(str).map((x) => Getgenerateorderdataresponse.fromJson(x)));

String getgenerateorderdataresponseToJson(
        List<Getgenerateorderdataresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getgenerateorderdataresponse {
  String status;
  String message;
  List<GetgenerateorderdataresponseDatum> data;

  Getgenerateorderdataresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getgenerateorderdataresponse.fromJson(Map<String, dynamic> json) =>
      Getgenerateorderdataresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetgenerateorderdataresponseDatum>.from(json["data"]
            .map((x) => GetgenerateorderdataresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetgenerateorderdataresponseDatum {
  String id;
  String tblGenerateOrderLastId;
  String clientNameId;
  String itemGroup;
  String? branchNameId;
  String orderId;
  String? qcId;
  String productName;
  String orderAmount;
  String updateOrderAmount;
  String reworkStatus;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String clientName;
  String branchName;
  String orderDate;
  String time;

  GetgenerateorderdataresponseDatum({
    required this.id,
    required this.tblGenerateOrderLastId,
    required this.clientNameId,
    required this.itemGroup,
    this.branchNameId,
    required this.orderId,
    this.qcId,
    required this.productName,
    required this.orderAmount,
    required this.updateOrderAmount,
    required this.reworkStatus,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.clientName,
    required this.branchName,
    required this.orderDate,
    required this.time,
  });

  factory GetgenerateorderdataresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetgenerateorderdataresponseDatum(
        id: json["id"] ?? "",
        tblGenerateOrderLastId: json["tbl_generate_order_last_id"] ?? "",
        clientNameId: json["client_name_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchNameId: json["branch_name_id"],
        orderId: json["order_id"] ?? "",
        qcId: json["qc_id"],
        productName: json["product_name"] ?? "",
        orderAmount: json["order_amount"] ?? "",
        updateOrderAmount: json["update_order_amount"] ?? "",
        reworkStatus: json["rework_status"] ?? "",
        isDeleted: json["is_deleted"] ?? "0",
        status: json["status"] ?? "0",
        createdOn: DateTime.parse(
            json["created_on"] ?? DateTime.now().toIso8601String()),
        updatedOn: DateTime.parse(
            json["updated_on"] ?? DateTime.now().toIso8601String()),
        clientName: json["client_name"] ?? "",
        branchName: json["branch_name"] ?? "",
        orderDate: json["order_date"] ?? "",
        time: json["time"] ?? "",
      );

  Map<String, dynamic> toJson() => {
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
        "client_name": clientName,
        "branch_name": branchName,
        "order_date": orderDate,
        "time": time,
      };
}
