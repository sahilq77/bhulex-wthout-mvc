class ProductResponse {
  final bool status;
  final String message;
  final List<Product> data;

  ProductResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'] == 'true',
      message: json['message'],
      data: List<Product>.from(
        json['data'].map((product) => Product.fromJson(product)),
      ),
    );
  }
}

class Product {
  // final int id;
  final String productId;
  final String productName;
  // final String? itemGroup; // Make itemGroup nullable
  // final String? branchNameId; // Make branchNameId nullable
  // final int orderAmount;
  // final int updateOrderAmount;
  // final String createdOn;

  Product({
    // required this.id,
    required this.productId,
    required this.productName,
    // this.itemGroup,
    // this.branchNameId,
    // required this.orderAmount,
    // required this.updateOrderAmount,
    // required this.createdOn,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      // pro: int.tryParse(json['product_name'].toString()) ?? 0,
      productId: json['product_name'] ?? 'Unknown Product',
      productName: json['product'] ?? 'Unknown Product',
      // itemGroup: json['item_group'], // Can be null
      // branchNameId: json['branch_name_id']?.toString(), // Can be null
      // orderAmount: int.tryParse(json['order_amount'].toString()) ?? 0,
      // updateOrderAmount:
      //     int.tryParse(json['update_order_amount'].toString()) ?? 0,
      // createdOn: json['created_on'] ?? '', // Handle null createdOn if needed
    );
  }
}
