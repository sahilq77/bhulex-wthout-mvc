import 'dart:convert';

List<GetAllPackageOrdersApiResponse> getAllPackageOrdersApiResponseFromJson(
  String str,
) => List<GetAllPackageOrdersApiResponse>.from(
  json.decode(str).map((x) => GetAllPackageOrdersApiResponse.fromJson(x)),
);

String getAllPackageOrdersApiResponseToJson(
  List<GetAllPackageOrdersApiResponse> data,
) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllPackageOrdersApiResponse {
  String status;
  String message;
  List<GetAllPackageOrdersApiResponseDatum> data;

  GetAllPackageOrdersApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllPackageOrdersApiResponse.fromJson(Map<String, dynamic> json) =>
      GetAllPackageOrdersApiResponse(
        status: json["status"] ?? "false",
        message: json["message"] ?? "",
        data: List<GetAllPackageOrdersApiResponseDatum>.from(
          json["data"]?.map(
                (x) => GetAllPackageOrdersApiResponseDatum.fromJson(x),
              ) ??
              [],
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetAllPackageOrdersApiResponseDatum {
  String id;
  String leadStatus;
  String leadid;
  String packageId;
  String createdOn;
  String packageName;
  String packageNameInLocalLanguage;
  String tblName;
  List<ServiceName> serviceNames;

  GetAllPackageOrdersApiResponseDatum({
    required this.id,
    required this.leadStatus,
    required this.leadid,
    required this.packageId,
    required this.createdOn,
    required this.packageName,
    required this.packageNameInLocalLanguage,
    required this.tblName,
    required this.serviceNames,
  });

  factory GetAllPackageOrdersApiResponseDatum.fromJson(
    Map<String, dynamic> json,
  ) => GetAllPackageOrdersApiResponseDatum(
    id: json["id"] ?? "",
    leadStatus: json["lead_status"] ?? "",
    leadid: json["lead_id"] ?? "",
    packageId: json["package_id"] ?? "",
    createdOn: json["created_on"] ?? "",
    packageName: json["package_name"] ?? "",
    packageNameInLocalLanguage: json["package_name_in_local_language"] ?? "",
    tblName: json["tbl_name"] ?? "",
    serviceNames: List<ServiceName>.from(
      json["service_names"]?.map((x) => ServiceName.fromJson(x)) ?? [],
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_status": leadStatus,
    "lead_id": leadid,
    "package_id": packageId,
    "created_on": createdOn,
    "package_name": packageName,
    "package_name_in_local_language": packageNameInLocalLanguage,
    "tbl_name": tblName,
    "service_names": List<dynamic>.from(serviceNames.map((x) => x.toJson())),
  };
}

class ServiceName {
  String serviceName;
  String serviceNameInLocalLanguage;
  final int formStatus;
  final String tbl_name;
  final String? leadId;

  ServiceName({
    required this.serviceName,
    required this.serviceNameInLocalLanguage,
    required this.formStatus,
    required this.tbl_name,
    this.leadId,
  });

  factory ServiceName.fromJson(Map<String, dynamic> json) => ServiceName(
    serviceName: json["service_name"] ?? "",
    tbl_name: json["tbl_name"] ?? "",

    serviceNameInLocalLanguage: json["service_name_in_local_language"] ?? "",
    formStatus: json['form_status'] ?? 0,
    leadId: json['lead_id']?.toString(), // Handle null case
  );

  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
    "service_name_in_local_language": serviceNameInLocalLanguage,
    "lead_id": leadId,
    "form_Status": formStatus,
    "tbl_name": tbl_name,
  };
}
