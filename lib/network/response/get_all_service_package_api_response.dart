// To parse this JSON data, do
//
//     final getAllServicePackageApiResponse = getAllServicePackageApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetAllServicePackageApiResponse> getAllServicePackageApiResponseFromJson(
  String str,
) => List<GetAllServicePackageApiResponse>.from(
  json.decode(str).map((x) => GetAllServicePackageApiResponse.fromJson(x)),
);

String getAllServicePackageApiResponseToJson(
  List<GetAllServicePackageApiResponse> data,
) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllServicePackageApiResponse {
  String status;
  String message;
  List<GetAllServicePackageApiResponseDatum> data;

  GetAllServicePackageApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllServicePackageApiResponse.fromJson(Map<String, dynamic> json) =>
      GetAllServicePackageApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetAllServicePackageApiResponseDatum>.from(
          json["data"].map(
            (x) => GetAllServicePackageApiResponseDatum.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetAllServicePackageApiResponseDatum {
  String id;
  String? serviceName;
  String? serviceNameInLocalLanguage;
  // String? packageName;
  // String? packageNameInLocalLanguage;

  GetAllServicePackageApiResponseDatum({
    required this.id,
    this.serviceName,
    this.serviceNameInLocalLanguage,
    // this.packageName,
    // this.packageNameInLocalLanguage,
  });

  factory GetAllServicePackageApiResponseDatum.fromJson(
    Map<String, dynamic> json,
  ) => GetAllServicePackageApiResponseDatum(
    id: json["id"] ?? "",
    serviceName: json["service_name"] ?? "",
    serviceNameInLocalLanguage: json["service_name_in_local_language"] ?? "",
    // packageName: json["package_name"] ?? "",
    // packageNameInLocalLanguage: json["package_name_in_local_language"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_name": serviceName,
    "service_name_in_local_language": serviceNameInLocalLanguage,
    // "package_name": packageName,
    // "package_name_in_local_language": packageNameInLocalLanguage,
  };
}
