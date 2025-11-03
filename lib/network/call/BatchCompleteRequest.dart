class BatchCompleteRequest {
  String id;
  String endDate;
  String endTime;
  String batchQuantity;
  String producedQuantity;
  String balanceQuantity;
  String completeRemark; // Only for 'Complete' operation
  String productName, userId, previousQuantity;

  BatchCompleteRequest({
    required this.id,
    required this.endDate,
    required this.endTime,
    required this.batchQuantity,
    required this.producedQuantity,
    required this.balanceQuantity,
    required this.completeRemark,
    required this.productName,
    required this.userId,
    required this.previousQuantity,
  });

  factory BatchCompleteRequest.fromJson(Map<String, dynamic> json) =>
      BatchCompleteRequest(
        id: json["id"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        batchQuantity: json["batch_quantity"],
        producedQuantity: json["produced_quantity"],
        balanceQuantity: json["balance_quantity"],
        completeRemark: json["complete_remark"],
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
        "complete_remark": completeRemark, // Use complete_remark here
        "product_name": productName,
        "user_id": userId,
        "previous_quantity": previousQuantity,
      };
}
