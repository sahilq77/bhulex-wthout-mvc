class BatchStopRequest {
  String id;
  String endDate;
  String endTime;
  String batchQuantity;
  String producedQuantity;
  String balanceQuantity;
  String remark; // Unified "remark" field for stop_remark
  String productName, userId, previousQuantity;

  BatchStopRequest({
    required this.id,
    required this.endDate,
    required this.endTime,
    required this.batchQuantity,
    required this.producedQuantity,
    required this.balanceQuantity,
    required this.remark, // Use stop_remark here
    required this.productName,
    required this.userId,
    required this.previousQuantity,
  });

  factory BatchStopRequest.fromJson(Map<String, dynamic> json) =>
      BatchStopRequest(
        id: json["id"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        batchQuantity: json["batch_quantity"],
        producedQuantity: json["produced_quantity"],
        balanceQuantity: json["balance_quantity"],
        remark: json["stop_remark"], // Only use stop_remark for this class
        productName: json["product_name"],
        userId: json["user_id"],
        previousQuantity: json["previous_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "end_date": endDate,
        "end_time": endTime,
        "batch_quantity": batchQuantity,
        "produced_quantity": producedQuantity,
        "balance_quantity": balanceQuantity,
        "stop_remark": remark, // Only include stop_remark here
        "product_name": productName,
        "user_id": userId,
        "previous_quantity": previousQuantity,
      };
}
