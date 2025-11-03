import 'dart:convert';

class OrderResponse {
  final bool status;
  final String message;
  final List<OrderData> data;

  OrderResponse(
      {required this.status, required this.message, required this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] == 'true',
      message: json['message'],
      data: List<OrderData>.from(
          json['data'].map((order) => OrderData.fromJson(order))),
    );
  }
}

class OrderData {
  final int orderId;
  final String order;

  OrderData({required this.orderId, required this.order});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: int.tryParse(json['order_id'].toString()) ??
          0, // Ensure conversion to int
      order: json['order'] ?? 'Unknown Order',
    );
  }
}
