// To parse this JSON data, do
//
//     final packageDetailsApiResponse = packageDetailsApiResponseFromJson(jsonString);

import 'dart:convert';

List<PackageDetailsApiResponse> packageDetailsApiResponseFromJson(String str) =>
    List<PackageDetailsApiResponse>.from(
      json.decode(str).map((x) => PackageDetailsApiResponse.fromJson(x)),
    );

String packageDetailsApiResponseToJson(List<PackageDetailsApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageDetailsApiResponse {
  String status;
  String message;
  String iconPath;
  String imagePath;
  PackageDetailsApiResponseDatum data;

  PackageDetailsApiResponse({
    required this.status,
    required this.message,
    required this.iconPath,
    required this.imagePath,
    required this.data,
  });

  factory PackageDetailsApiResponse.fromJson(Map<String, dynamic> json) =>
      PackageDetailsApiResponse(
        status: json["status"],
        message: json["message"],
        iconPath: json["icon_path"],
        imagePath: json["image_path"],
        data: PackageDetailsApiResponseDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "icon_path": iconPath,
    "image_path": imagePath,
    "data": data.toJson(),
  };
}

class PackageDetailsApiResponseDatum {
  PackageDetails packageDetails;
  StatusInfo statusInfo;

  PackageDetailsApiResponseDatum({
    required this.packageDetails,
    required this.statusInfo,
  });

  factory PackageDetailsApiResponseDatum.fromJson(Map<String, dynamic> json) =>
      PackageDetailsApiResponseDatum(
        packageDetails: PackageDetails.fromJson(json["package_details"]),
        statusInfo: StatusInfo.fromJson(json["status_info"]),
      );

  Map<String, dynamic> toJson() => {
    "package_details": packageDetails.toJson(),
    "status_info": statusInfo.toJson(),
  };
}

class PackageDetails {
  String id;
  String customerId;
  String serviceId;
  String packageName;
  String packageNameInLocalLanguage;
  String packageImage;
  String icon;
  String tags;
  String tagInLocalLanguage;
  String originalPrice;
  String discountPrice;
  String shortDescription;
  String shortDescriptionInLocalLanguage;
  DateTime createdOn;
  DateTime updatedOn;
  String status;
  String isDeleted;
  String serviceIds;
  String serviceNames;
  String serviceNamesLocal;

  PackageDetails({
    required this.id,
    required this.customerId,
    required this.serviceId,
    required this.packageName,
    required this.packageNameInLocalLanguage,
    required this.packageImage,
    required this.icon,
    required this.tags,
    required this.tagInLocalLanguage,
    required this.originalPrice,
    required this.discountPrice,
    required this.shortDescription,
    required this.shortDescriptionInLocalLanguage,
    required this.createdOn,
    required this.updatedOn,
    required this.status,
    required this.isDeleted,
    required this.serviceIds,
    required this.serviceNames,
    required this.serviceNamesLocal,
  });

  factory PackageDetails.fromJson(Map<String, dynamic> json) => PackageDetails(
    id: json["id"],
    customerId: json["customer_id"],
    serviceId: json["service_id"],
    packageName: json["package_name"],
    packageNameInLocalLanguage: json["package_name_in_local_language"],
    packageImage: json["package_image"],
    icon: json["icon"],
    tags: json["tags"],
    tagInLocalLanguage: json["tag_in_local_language"],
    originalPrice: json["original_price"],
    discountPrice: json["discount_price"],
    shortDescription: json["short_description"],
    shortDescriptionInLocalLanguage:
        json["short_description_in_local_language"],
    createdOn: DateTime.parse(json["created_on"]),
    updatedOn: DateTime.parse(json["updated_on"]),
    status: json["status"],
    isDeleted: json["is_deleted"],
    serviceIds: json["service_ids"],
    serviceNames: json["service_names"],
    serviceNamesLocal: json["service_names_local"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "service_id": serviceId,
    "package_name": packageName,
    "package_name_in_local_language": packageNameInLocalLanguage,
    "package_image": packageImage,
    "icon": icon,
    "tags": tags,
    "tag_in_local_language": tagInLocalLanguage,
    "original_price": originalPrice,
    "discount_price": discountPrice,
    "short_description": shortDescription,
    "short_description_in_local_language": shortDescriptionInLocalLanguage,
    "created_on": createdOn.toIso8601String(),
    "updated_on": updatedOn.toIso8601String(),
    "status": status,
    "is_deleted": isDeleted,
    "service_ids": serviceIds,
    "service_names": serviceNames,
    "service_names_local": serviceNamesLocal,
  };
}

class StatusInfo {
  String status;
  int totalServices;
  int completedServices;
  int pendingServices;
  List<PendingServiceName> pendingServiceNames;

  StatusInfo({
    required this.status,
    required this.totalServices,
    required this.completedServices,
    required this.pendingServices,
    required this.pendingServiceNames,
  });

  factory StatusInfo.fromJson(Map<String, dynamic> json) => StatusInfo(
    status: json["status"],
    totalServices: json["total_services"],
    completedServices: json["completed_services"],
    pendingServices: json["pending_services"],
    pendingServiceNames: List<PendingServiceName>.from(
      json["pending_service_names"].map((x) => PendingServiceName.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_services": totalServices,
    "completed_services": completedServices,
    "pending_services": pendingServices,
    "pending_service_names": List<dynamic>.from(
      pendingServiceNames.map((x) => x.toJson()),
    ),
  };
}

class PendingServiceName {
  String serviceName;
  String serviceNameInLocalLanguage;

  PendingServiceName({
    required this.serviceName,
    required this.serviceNameInLocalLanguage,
  });

  factory PendingServiceName.fromJson(Map<String, dynamic> json) =>
      PendingServiceName(
        serviceName: json["service_name"],
        serviceNameInLocalLanguage: json["service_name_in_local_language"],
      );

  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
    "service_name_in_local_language": serviceNameInLocalLanguage,
  };
}
