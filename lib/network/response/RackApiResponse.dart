// lib/Network/response/rack_api_response.dart

class RackApiResponse {
  final String status;
  final String message;
  final List<RackData> data;

  RackApiResponse(
      {required this.status, required this.message, required this.data});

  factory RackApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<RackData> racksList = list.map((i) => RackData.fromJson(i)).toList();

    return RackApiResponse(
      status: json['status'],
      message: json['message'],
      data: racksList,
    );
  }
}

class RackData {
  final String id;
  final String rackId;
  final String bincardName;
  final String rackName;

  RackData({
    required this.id,
    required this.rackId,
    required this.bincardName,
    required this.rackName,
  });

  factory RackData.fromJson(Map<String, dynamic> json) {
    return RackData(
      id: json['id'] ?? "",
      rackId: json['rack_id'] ?? "",
      bincardName: json['bincard_name'] ?? "",
      rackName: json['rack_name'] ?? "",
    );
  }
}
