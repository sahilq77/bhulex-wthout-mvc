// To parse this JSON data, do
//
//     final orderDetailsApiResponse = orderDetailsApiResponseFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsApiResponse> orderDetailsApiResponseFromJson(String str) =>
    List<OrderDetailsApiResponse>.from(
      json.decode(str).map((x) => OrderDetailsApiResponse.fromJson(x)),
    );

String orderDetailsApiResponseToJson(List<OrderDetailsApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsApiResponse {
  String status;
  String message;
  String filePath;

  List<OrderDetailsApiResponseDatum> data;

  OrderDetailsApiResponse({
    required this.status,
    required this.message,
    required this.filePath,
    required this.data,
  });

  factory OrderDetailsApiResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailsApiResponse(
        status: json["status"],
        message: json["message"],
        filePath: json["file_path"],
        data: List<OrderDetailsApiResponseDatum>.from(
          json["data"].map((x) => OrderDetailsApiResponseDatum.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "file_path": filePath,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderDetailsApiResponseDatum {
  String orderId;
  String serviceName;
  String customerName;
  String mobileNumber;
  String email;
  String documentId;
  String download_date;
  String fileName;
  String file;
  String tags;
  String tag_in_local_language;
  String isView;
  DateTime applicationDate;
  String leadStatus;
  String? serviceNameLocal,
      package_name,
      package_name_in_local_language; // Optional local language field
  OrderDetailsApiResponseDatum({
    required this.orderId,
    required this.serviceName,
    required this.customerName,
    required this.mobileNumber,
    required this.email,
    required this.documentId,
    required this.fileName,
    required this.file,
    required this.tags,
    required this.tag_in_local_language,
    required this.isView,
    required this.applicationDate,
    required this.leadStatus,
    required this.download_date,
    required this.package_name,
    required this.package_name_in_local_language,
    this.serviceNameLocal,
  });

  factory OrderDetailsApiResponseDatum.fromJson(Map<String, dynamic> json) =>
      OrderDetailsApiResponseDatum(
        orderId: json["order_id"] ?? "",
        serviceName: json["service_name"] ?? "",
        customerName: json["customer_name"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        documentId: json["document_id"] ?? "",
        fileName: json["file_name"] ?? "",
        file: json["file"] ?? "",
        tags: json["tags"] ?? "",
        tag_in_local_language: json["tag_in_local_language"] ?? "",
        isView: json["is_view"] ?? "",
        applicationDate:
            json["application_date"] != null
                ? DateTime.parse(json["application_date"])
                : DateTime.now(),
        serviceNameLocal: json["service_name_in_local_language"],
        leadStatus: json["lead_status"] ?? "",
        download_date: json["download_date"] ?? "",
        package_name: json["package_name"] ?? "",
        package_name_in_local_language:
            json["package_name_in_local_language"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "service_name": serviceName,
    "customer_name": customerName,
    "mobile_number": mobileNumber,
    "email": email,
    "document_id": documentId,
    "file_name": fileName,
    "download_date": download_date,
    "file": file,
    "tags": tags,
    "is_view": isView,
    "application_date": applicationDate.toIso8601String(),
    "lead_status": leadStatus,
    "service_name_in_local_language": serviceNameLocal,
  };
}
