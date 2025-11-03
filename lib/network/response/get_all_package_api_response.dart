// // To parse this JSON data, do
// //
// //     final getAllPackageApiResponse = getAllPackageApiResponseFromJson(jsonString);

// import 'dart:convert';

// List<GetAllPackageApiResponse> getAllPackageApiResponseFromJson(String str) =>
//     List<GetAllPackageApiResponse>.from(
//       json.decode(str).map((x) => GetAllPackageApiResponse.fromJson(x)),
//     );

// String getAllPackageApiResponseToJson(List<GetAllPackageApiResponse> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class GetAllPackageApiResponse {
//   String status;
//   String message;
//   String iconPath;
//   String imagePath;
//   GetAllPackageApiResponseDatum data;

//   GetAllPackageApiResponse({
//     required this.status,
//     required this.message,
//     required this.iconPath,
//     required this.imagePath,
//     required this.data,
//   });

//   factory GetAllPackageApiResponse.fromJson(Map<String, dynamic> json) =>
//       GetAllPackageApiResponse(
//         status: json["status"],
//         message: json["message"],
//         iconPath: json["icon_path"],
//         imagePath: json["image_path"],
//         data: GetAllPackageApiResponseDatum.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "icon_path": iconPath,
//     "image_path": imagePath,
//     "data": data.toJson(),
//   };
// }

// class GetAllPackageApiResponseDatum {
//   List<Package> packages;

//   GetAllPackageApiResponseDatum({required this.packages});

//   factory GetAllPackageApiResponseDatum.fromJson(Map<String, dynamic> json) =>
//       GetAllPackageApiResponseDatum(
//         packages: List<Package>.from(
//           json["packages"].map((x) => Package.fromJson(x)),
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//     "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
//   };
// }

// class Package {
//   String id;

//   String customerId;
//   String packageServiceId;
//   String packageName;
//   String packageNameInLocalLanguage;
//   String packageImage;
//   String icon;
//   String tags;
//   String tagInLocalLanguage;
//   String originalPrice;
//   String discountPrice;
//   String shortDescription;
//   String shortDescriptionInLocalLanguage;
//   DateTime createdOn;
//   DateTime updatedOn;
//   String status;
//   String isDeleted;
//   String packageId;
//   String serviceId;
//   String serviceNames;
//   String serviceNamesLocal;
//   StatusInfo statusInfo;

//   Package({
//     required this.id,
//     required this.customerId,
//     required this.packageServiceId,
//     required this.packageName,
//     required this.packageNameInLocalLanguage,
//     required this.packageImage,
//     required this.icon,
//     required this.tags,
//     required this.tagInLocalLanguage,
//     required this.originalPrice,
//     required this.discountPrice,
//     required this.shortDescription,
//     required this.shortDescriptionInLocalLanguage,
//     required this.createdOn,
//     required this.updatedOn,
//     required this.status,
//     required this.isDeleted,
//     required this.packageId,
//     required this.serviceId,
//     required this.serviceNames,
//     required this.serviceNamesLocal,
//     required this.statusInfo,
//   });

//   factory Package.fromJson(Map<String, dynamic> json) => Package(
//     id: json["id"],
//     customerId: json["customer_id"] ?? "",
//     packageServiceId: json["service_id"] ?? "",
//     packageName: json["package_name"] ?? "",
//     packageNameInLocalLanguage: json["package_name_in_local_language"] ?? "",
//     packageImage: json["package_image"] ?? "",
//     icon: json["icon"] ?? "",
//     tags: json["tags"] ?? "",
//     tagInLocalLanguage: json["tag_in_local_language"] ?? "",
//     originalPrice: json["original_price"] ?? "",
//     discountPrice: json["discount_price"] ?? "",
//     shortDescription: json["short_description"] ?? "",
//     shortDescriptionInLocalLanguage:
//         json["short_description_in_local_language"] ?? "",
//     createdOn: DateTime.parse(json["created_on"]),
//     updatedOn: DateTime.parse(json["updated_on"]),
//     status: json["status"] ?? "",
//     isDeleted: json["is_deleted"] ?? "",
//     packageId: json["packageId"] ?? "",
//     serviceId: json["serviceId"] ?? "",
//     serviceNames: json["service_names"]?? "",
//     serviceNamesLocal: json["service_names_local"] ?? "",
//     statusInfo: StatusInfo.fromJson(json["status_info"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "customer_id": customerId,
//     "service_id": packageServiceId,
//     "package_name": packageName,
//     "package_name_in_local_language": packageNameInLocalLanguage,
//     "package_image": packageImage,
//     "icon": icon,
//     "tags": tags,
//     "tag_in_local_language": tagInLocalLanguage,
//     "original_price": originalPrice,
//     "discount_price": discountPrice,
//     "short_description": shortDescription,
//     "short_description_in_local_language": shortDescriptionInLocalLanguage,
//     "created_on": createdOn.toIso8601String(),
//     "updated_on": updatedOn.toIso8601String(),
//     "status": status,
//     "is_deleted": isDeleted,
//     "packageId": packageId,
//     "serviceId": serviceId,
//     "service_names": serviceNames,
//     "service_names_local": serviceNamesLocal,
//     "status_info": statusInfo.toJson(),
//   };
// }

// class StatusInfo {
//   String status;
//   int totalServices;
//   int completedServices;
//   int pendingServices;
//   List<PendingServiceName> pendingServiceNames;

//   StatusInfo({
//     required this.status,
//     required this.totalServices,
//     required this.completedServices,
//     required this.pendingServices,
//     required this.pendingServiceNames,
//   });

//   factory StatusInfo.fromJson(Map<String, dynamic> json) => StatusInfo(
//     status: json["status"],
//     totalServices: json["total_services"],
//     completedServices: json["completed_services"],
//     pendingServices: json["pending_services"],
//     pendingServiceNames: List<PendingServiceName>.from(
//       json["pending_service_names"].map((x) => PendingServiceName.fromJson(x)),
//     ),
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "total_services": totalServices,
//     "completed_services": completedServices,
//     "pending_services": pendingServices,
//     "pending_service_names": List<dynamic>.from(
//       pendingServiceNames.map((x) => x.toJson()),
//     ),
//   };
// }

// class PendingServiceName {
//   String serviceName;
//   String serviceNameInLocalLanguage;

//   PendingServiceName({
//     required this.serviceName,
//     required this.serviceNameInLocalLanguage,
//   });

//   factory PendingServiceName.fromJson(Map<String, dynamic> json) =>
//       PendingServiceName(
//         serviceName: json["service_name"],
//         serviceNameInLocalLanguage: json["service_name_in_local_language"],
//       );

//   Map<String, dynamic> toJson() => {
//     "service_name": serviceName,
//     "service_name_in_local_language": serviceNameInLocalLanguage,
//   };
// }
import 'dart:convert';

List<GetAllPackageApiResponse> getAllPackageApiResponseFromJson(String str) =>
    List<GetAllPackageApiResponse>.from(
      json.decode(str)?.map((x) => GetAllPackageApiResponse.fromJson(x)) ?? [],
    );
String getAllPackageApiResponseToJson(List<GetAllPackageApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllPackageApiResponse {
  String status;
  String message;
  String iconPath;
  String imagePath;
  GetAllPackageApiResponseDatum data;
  GetAllPackageApiResponse({
    required this.status,
    required this.message,
    required this.iconPath,
    required this.imagePath,
    required this.data,
  });
  factory GetAllPackageApiResponse.fromJson(Map<String, dynamic> json) =>
      GetAllPackageApiResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        iconPath: json["icon_path"] ?? "",
        imagePath: json["image_path"] ?? "",
        data: GetAllPackageApiResponseDatum.fromJson(json["data"] ?? {}),
      );
  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "icon_path": iconPath,
    "image_path": imagePath,
    "data": data.toJson(),
  };
}

class GetAllPackageApiResponseDatum {
  List<Package> packages;
  GetAllPackageApiResponseDatum({required this.packages});
  factory GetAllPackageApiResponseDatum.fromJson(Map<String, dynamic> json) =>
      GetAllPackageApiResponseDatum(
        packages:
            json["packages"] != null
                ? List<Package>.from(
                  json["packages"].map((x) => Package.fromJson(x)),
                )
                : [],
      );
  Map<String, dynamic> toJson() => {
    "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
  };
}

class Package {
  String id;
  String customerId;
  String packageServiceId;
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
  String packageId;
  String serviceId;
  String serviceNames;
  String serviceNamesLocal;
  StatusInfo statusInfo;
  Package({
    required this.id,
    required this.customerId,
    required this.packageServiceId,
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
    required this.packageId,
    required this.serviceId,
    required this.serviceNames,
    required this.serviceNamesLocal,
    required this.statusInfo,
  });
  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"] ?? "",
    customerId: json["customer_id"] ?? "",
    packageServiceId: json["service_id"] ?? "",
    packageName: json["package_name"] ?? "",
    packageNameInLocalLanguage: json["package_name_in_local_language"] ?? "",
    packageImage: json["package_image"] ?? "",
    icon: json["icon"] ?? "",
    tags: json["tags"] ?? "",
    tagInLocalLanguage: json["tag_in_local_language"] ?? "",
    originalPrice: json["original_price"] ?? "",
    discountPrice: json["discount_price"] ?? "",
    shortDescription: json["short_description"] ?? "",
    shortDescriptionInLocalLanguage:
        json["short_description_in_local_language"] ?? "",
    createdOn:
        json["created_on"] != null
            ? DateTime.tryParse(json["created_on"]) ?? DateTime.now()
            : DateTime.now(),
    updatedOn:
        json["updated_on"] != null
            ? DateTime.tryParse(json["updated_on"]) ?? DateTime.now()
            : DateTime.now(),
    status: json["status"] ?? "",
    isDeleted: json["is_deleted"] ?? "",
    packageId: json["packageId"] ?? "",
    serviceId: json["serviceId"] ?? "",
    serviceNames: json["service_names"] ?? "",
    serviceNamesLocal: json["service_names_local"] ?? "",
    statusInfo: StatusInfo.fromJson(json["status_info"] ?? {}),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "service_id": packageServiceId,
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
    "packageId": packageId,
    "serviceId": serviceId,
    "service_names": serviceNames,
    "service_names_local": serviceNamesLocal,
    "status_info": statusInfo.toJson(),
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
    status: json["status"] ?? "",
    totalServices: json["total_services"] ?? 0,
    completedServices: json["completed_services"] ?? 0,
    pendingServices: json["pending_services"] ?? 0,
    pendingServiceNames:
        json["pending_service_names"] != null
            ? List<PendingServiceName>.from(
              json["pending_service_names"].map(
                (x) => PendingServiceName.fromJson(x),
              ),
            )
            : [],
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
        serviceName: json["service_name"] ?? "",
        serviceNameInLocalLanguage:
            json["service_name_in_local_language"] ?? "",
      );
  Map<String, dynamic> toJson() => {
    "service_name": serviceName,
    "service_name_in_local_language": serviceNameInLocalLanguage,
  };
}
