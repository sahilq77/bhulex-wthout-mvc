// lib/models/category_model.dart
import 'package:get/get.dart';

class CategoryResponse {
  final bool status;
  final String message;
  final String iconPath;
  final List<Category> data;

  CategoryResponse({
    required this.status,
    required this.message,
    required this.iconPath,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'] == 'true',
      message: json['message'] ?? '',
      iconPath: json['icon_path'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((item) => Category.fromJson(item))
          .toList(),
    );
  }

  @override
  String toString() => 'CategoryResponse(status: $status, categories: ${data.length})';
}

class Category {
  final String id;
  final String categoryName;
  final String categoryNameInLocal;
  final String description;
  final List<Service> services;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryNameInLocal,
    required this.description,
    required this.services,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var servicesList = json['service'] as List<dynamic>? ?? [];

    return Category(
      id: json['id'].toString(),
      categoryName: json['category_name'] ?? '',
      categoryNameInLocal: json['category_name_in_local_language'] ?? '',
      description: json['description'] ?? '',
      services: servicesList.map((s) => Service.fromJson(s)).toList(),
    );
  }

  String getDisplayName(bool isMarathi) =>
      isMarathi ? categoryNameInLocal : categoryName;

  @override
  String toString() => 'Category($categoryName, services: ${services.length})';
}

class Service {
  final String id;
  final String categoryId;
  final String stateId;
  final String icon;
  final String serviceName;
  final String serviceNameInLocal;
  final String serviceImage;
  final String discountPrice;
  final String originalPrice;
  final String tblName;

  Service({
    required this.id,
    required this.categoryId,
    required this.stateId,
    required this.icon,
    required this.serviceName,
    required this.serviceNameInLocal,
    required this.serviceImage,
    required this.discountPrice,
    required this.originalPrice,
    required this.tblName,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'].toString(),
      categoryId: json['category_id'].toString(),
      stateId: json['state_id'].toString(),
      icon: json['icon'] ?? '',
      serviceName: json['service_name'] ?? '',
      serviceNameInLocal: json['service_name_in_local_language'] ?? '',
      serviceImage: json['service_image'] ?? '',
      discountPrice: json['discount_price']?.toString() ?? '0',
      originalPrice: json['original_price']?.toString() ?? '0',
      tblName: json['tbl_name'] ?? '',
    );
  }

  String get iconUrl => icon.isNotEmpty ? iconPath + icon : '';

  // Helper to get correct name based on language
  String getDisplayName(bool isMarathi) =>
      isMarathi && serviceNameInLocal.isNotEmpty
          ? serviceNameInLocal
          : serviceName;

  bool get hasValidIcon => icon.isNotEmpty;

  @override
  String toString() => 'Service($serviceName, tbl: $tblName)';
}

// Global variable to access icon path easily in UI
String iconPath = '';