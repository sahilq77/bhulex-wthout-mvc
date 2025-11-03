class QCCheckPointResponse {
  final bool status;
  final String message;
  final List<CheckPointData> data;

  QCCheckPointResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QCCheckPointResponse.fromJson(Map<String, dynamic> json) {
    return QCCheckPointResponse(
      status: json['status'] == 'true', // Assuming 'status' is a string value
      message: json['message'],
      data: (json['data'] as List)
          .map((checkPointJson) => CheckPointData.fromJson(checkPointJson))
          .toList(),
    );
  }
}

class CheckPointData {
  final String id;
  final String productId;
  final String checkPointProductId;
  final bool isDeleted;
  final String status;
  final String createdOn;
  final String updatedOn;
  final String checkPointsData;
  final List<StageData> stagesResult;

  CheckPointData({
    required this.id,
    required this.productId,
    required this.checkPointProductId,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.checkPointsData,
    required this.stagesResult,
  });

  factory CheckPointData.fromJson(Map<String, dynamic> json) {
    return CheckPointData(
      id: json['id'] ?? "",
      productId: json['product_id'] ?? "",
      checkPointProductId: json['check_point_product_id'] ?? "",
      isDeleted: json['is_deleted'] == '0',
      status: json['status'] ?? "",
      createdOn: json['created_on'],
      updatedOn: json['updated_on'],
      checkPointsData: json['check_points_data'] ?? "",
      stagesResult: (json['stages_result'] as List)
          .map((stageJson) => StageData.fromJson(stageJson))
          .toList(),
    );
  }
}

class StageData {
  final String id;
  final String productId;
  final String checkPointProductStageId;
  final String checkPointProductLastId;
  final String mainCheckPointProductId;
  final bool isDeleted;
  final String status;
  final String createdOn;
  final String updatedOn;
  final String multipleStageName;
  final String checkPointsData;

  StageData({
    required this.id,
    required this.productId,
    required this.checkPointProductStageId,
    required this.checkPointProductLastId,
    required this.mainCheckPointProductId,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.multipleStageName,
    required this.checkPointsData,
  });

  factory StageData.fromJson(Map<String, dynamic> json) {
    return StageData(
      id: json['id'],
      productId: json['product_id'],
      checkPointProductStageId: json['check_point_product_stage_id'],
      checkPointProductLastId: json['check_point_product_last_id'],
      mainCheckPointProductId: json['main_check_point_product_id'],
      isDeleted: json['is_deleted'] == '0',
      status: json['status'],
      createdOn: json['created_on'],
      updatedOn: json['updated_on'],
      multipleStageName: json['multiple_stage_name'],
      checkPointsData: json['check_points_data'],
    );
  }
}
