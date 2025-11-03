import 'dart:convert';

BatchHoldRequest batchHoldRequestFromJson(String str) =>
    BatchHoldRequest.fromJson(json.decode(str));

String batchHoldRequestToJson(BatchHoldRequest data) =>
    json.encode(data.toJson());

class BatchHoldRequest {
  String id;
  String batchQuantity;
  String producedQuantity;
  String balanceQuantity;
  String holdRemark, userId, previousQuantity;

  BatchHoldRequest(
      {required this.id,
      required this.batchQuantity,
      required this.producedQuantity,
      required this.balanceQuantity,
      required this.holdRemark,
      required this.userId,
      required this.previousQuantity});

  factory BatchHoldRequest.fromJson(Map<String, dynamic> json) =>
      BatchHoldRequest(
          id: json["id"],
          batchQuantity: json["batch_quantity"],
          producedQuantity: json["produced_quantity"],
          balanceQuantity: json["balance_quantity"],
          holdRemark: json["hold_remark"],
          userId: json["user_id"],
          previousQuantity: json["previous_quantity"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "batch_quantity": batchQuantity,
        "produced_quantity": producedQuantity,
        "balance_quantity": balanceQuantity,
        "hold_remark": holdRemark,
        "user_id": userId,
        "previous_quantity": previousQuantity
      };
}
