import 'dart:convert';

// Response model
class FetchClientProductBatchResponse {
  final String status; // Changed from bool to String
  final String message;
  final Data data;

  FetchClientProductBatchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchClientProductBatchResponse.fromJson(Map<String, dynamic> json) {
    return FetchClientProductBatchResponse(
      status: json['status'] ?? "", // Keep as String
      message: json['message'] ?? "",
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final List<BatchResult> batchResult;
  final List<ProductResult> productResult;
  final List<CriticalDimensionResult> criticalDimensionResult;

  Data({
    required this.batchResult,
    required this.productResult,
    required this.criticalDimensionResult,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var batchResultList = json['batch_result'] as List;
    var productResultList = json['product_result'] as List;
    var criticalDimensionResultList = json['critical_dimension_result'] as List;

    return Data(
      batchResult:
          batchResultList.map((item) => BatchResult.fromJson(item)).toList(),
      productResult: productResultList
          .map((item) => ProductResult.fromJson(item))
          .toList(),
      criticalDimensionResult: criticalDimensionResultList
          .map((item) => CriticalDimensionResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batch_result': batchResult.map((e) => e.toJson()).toList(),
      'product_result': productResult.map((e) => e.toJson()).toList(),
      'critical_dimension_result':
          criticalDimensionResult.map((e) => e.toJson()).toList(),
    };
  }
}

class BatchResult {
  final String producedQuantity; // Keep as String
  final String product; // Keep as String
  final String batchNumber;
  final String machineId;
  final int id; // Changed to int

  BatchResult({
    required this.producedQuantity,
    required this.product,
    required this.batchNumber,
    required this.machineId,
    required this.id,
  });

  factory BatchResult.fromJson(Map<String, dynamic> json) {
    return BatchResult(
      producedQuantity: json['produced_quantity'].toString() ?? "",
      product: json['product'].toString() ?? "",
      batchNumber: json['batch_number'] ?? "",
      machineId: json['machine_id'] ?? "",
      id: int.tryParse(json['id'].toString()) ??
          0, // Handle conversion from String to int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'produced_quantity': producedQuantity,
      'product': product,
      'batch_number': batchNumber,
      'machine_id': machineId,
      'id': id,
    };
  }
}

class ProductResult {
  final String id; // Keep as String
  final String clientId; // Keep as String
  final String branchName;
  final String itemGroup;
  final String productName;
  final String netWtPerPc;
  final String productMachineName;
  final String branch;
  final String clientName;
  final String machineName;

  ProductResult({
    required this.id,
    required this.clientId,
    required this.branchName,
    required this.itemGroup,
    required this.productName,
    required this.netWtPerPc,
    required this.productMachineName,
    required this.branch,
    required this.clientName,
    required this.machineName,
  });

  factory ProductResult.fromJson(Map<String, dynamic> json) {
    return ProductResult(
      id: json['id'].toString(),
      clientId: json['client_id'].toString(),
      branchName: json['branch'].toString(),
      itemGroup: json['item_group'],
      productName: json['product_name'],
      netWtPerPc: json['net_wt_per_pc'].toString(),
      productMachineName: json['product_machine_name'].toString(),
      branch: json['branch_name'].toString(),
      clientName: json['client_name'],
      machineName: json['machine_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'branch_name': branchName,
      'item_group': itemGroup,
      'product_name': productName,
      'net_wt_per_pc': netWtPerPc,
      'product_machine_name': productMachineName,
      'branch': branch,
      'client_name': clientName,
      'machine_name': machineName,
    };
  }
}

class CriticalDimensionResult {
  final int id;
  final int productId;
  final int criticalDimensionId;
  final String? criticalDimensions;
  final String minValue;
  final String maxValue;
  final int isDeleted;
  final int status;
  final String createdOn;
  final String updatedOn;

  CriticalDimensionResult({
    required this.id,
    required this.productId,
    required this.criticalDimensionId,
    this.criticalDimensions,
    required this.minValue,
    required this.maxValue,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory CriticalDimensionResult.fromJson(Map<String, dynamic> json) {
    return CriticalDimensionResult(
      id: int.tryParse(json['id'].toString()) ?? 0, // Convert to int
      productId:
          int.tryParse(json['product_id'].toString()) ?? 0, // Convert to int
      criticalDimensionId:
          int.tryParse(json['critical_dimension_id'].toString()) ??
              0, // Convert to int
      criticalDimensions: json['critical_dimensions'],
      minValue: json['min_value'] ?? '',
      maxValue: json['max_value'] ?? '',
      isDeleted:
          int.tryParse(json['is_deleted'].toString()) ?? 0, // Convert to int
      status: int.tryParse(json['status'].toString()) ?? 0, // Convert to int
      createdOn: json['created_on'],
      updatedOn: json['updated_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'critical_dimension_id': criticalDimensionId,
      'critical_dimensions': criticalDimensions,
      'min_value': minValue,
      'max_value': maxValue,
      'is_deleted': isDeleted,
      'status': status,
      'created_on': createdOn,
      'updated_on': updatedOn,
    };
  }
}
