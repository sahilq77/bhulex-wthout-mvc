import 'dart:convert';

qclistapicall qclistapicallFromJson(String str) =>
    qclistapicall.fromJson(json.decode(str));

String qclistapicallToJson(qclistapicall data) => json.encode(data.toJson());

class qclistapicall {
  String machineId, productId, itemGroup, branchId, orderId, batchId;
  int offset, limit;
  qclistapicall(
      {required this.machineId,
      required this.productId,
      required this.offset,
      required this.limit,
      required this.itemGroup,
      required this.branchId,
      required this.orderId,
      required this.batchId});

  factory qclistapicall.fromJson(Map<String, dynamic> json) => qclistapicall(
      machineId: json["client_id"] ?? "",
      productId: json["product_id"] ?? "",
      offset: json["offset"] ?? "",
      limit: json["limit"] ?? "",
      itemGroup: json["item_group"] ?? "",
      branchId: json["branch_id"] ?? "",
      orderId: json["order_id"] ?? "",
      batchId: json["batch_id"] ?? "");

  Map<String, dynamic> toJson() => {
        "client_id": machineId,
        "product_id": productId,
        "offset": offset,
        "limit": limit,
        "item_group": itemGroup,
        "branch_id": branchId,
        "order_id": orderId,
        "batch_id": batchId
      };
}
