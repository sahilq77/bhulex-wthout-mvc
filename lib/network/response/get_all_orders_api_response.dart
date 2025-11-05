
import 'dart:convert';

List<GetAllOrdersApiResponse> getAllOrdersApiResponseFromJson(String str) =>
    List<GetAllOrdersApiResponse>.from(
      json.decode(str).map((x) => GetAllOrdersApiResponse.fromJson(x)),
    );

String getAllOrdersApiResponseToJson(List<GetAllOrdersApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllOrdersApiResponse {
  String status;
  String message;
  List<GetAllOrdersApiResponseDatum> data;

  GetAllOrdersApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllOrdersApiResponse.fromJson(Map<String, dynamic> json) =>
      GetAllOrdersApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetAllOrdersApiResponseDatum>.from(
          json["data"].map((x) => GetAllOrdersApiResponseDatum.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetAllOrdersApiResponseDatum {
  String id;
  String leadStatus;
  DateTime createdOn;
  String serviceName;
  String serviceid;
  String? serviceNameLocal; // Optional local language field
  String tblName;
  String package_name, package_name_in_local_language;
  GetAllOrdersApiResponseDatum({
    required this.id,
    required this.leadStatus,
    required this.createdOn,
    required this.serviceName,
    required this.serviceid,
    this.serviceNameLocal,
    required this.tblName,
    required this.package_name,
    required this.package_name_in_local_language,
  });

  factory GetAllOrdersApiResponseDatum.fromJson(Map<String, dynamic> json) =>
      GetAllOrdersApiResponseDatum(
        id: json["id"],
        leadStatus: json["lead_status"] ?? "",
        createdOn:
            json["created_on"] != null
                ? DateTime.parse(json["created_on"])
                : DateTime.now(),
        serviceName: json["service_name"] ?? "",
        serviceid: json["service_id"] ?? "",

        serviceNameLocal: json["service_name_in_local_language"] ?? "",
        tblName: json["tbl_name"] ?? "",
        package_name: json["package_name"] ?? "",
        package_name_in_local_language:
            json["package_name_in_local_language"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_status": leadStatus,
    "created_on": createdOn.toIso8601String(),
    "service_name": serviceName,
    "service_id": serviceid,
    "service_name_in_local_language": serviceNameLocal,
    "tbl_name": tblName,
    "package_name": package_name,
    "package_name_in_local_language": package_name_in_local_language,
  };
}
