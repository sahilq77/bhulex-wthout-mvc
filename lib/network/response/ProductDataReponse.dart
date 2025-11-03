class ProductData {
  final String tempId;
  final String productId;
  final String boxPacking;
  final String row;
  final String column;
  final String createdOn;
  final String id;

  ProductData({
    required this.tempId,
    required this.productId,
    required this.boxPacking,
    required this.row,
    required this.column,
    required this.createdOn,
    required this.id,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      tempId: json['temp_id'] ?? "",
      productId: json['product_id'] ?? "",
      boxPacking: json['boxPacking'] ?? "",
      row: json['row'] ?? "",
      column: json['column'] ?? "",
      createdOn: json['created_on'] ?? "",
      id: json['id'] ?? "",
    );
  }
}

class ResponseData {
  final String status;
  final String message;
  final List<ProductData> data;

  ResponseData({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ProductData> dataList =
        list.map((item) => ProductData.fromJson(item)).toList();

    return ResponseData(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      data: dataList,
    );
  }
}
