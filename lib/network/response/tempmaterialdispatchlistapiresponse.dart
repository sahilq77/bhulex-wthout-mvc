// To parse this JSON data, do
//
//     final tempmaterialdispatchlistapiresponse = tempmaterialdispatchlistapiresponseFromJson(jsonString);

import 'dart:convert';

List<Tempmaterialdispatchlistapiresponse>
    tempmaterialdispatchlistapiresponseFromJson(String str) =>
        List<Tempmaterialdispatchlistapiresponse>.from(json
            .decode(str)
            .map((x) => Tempmaterialdispatchlistapiresponse.fromJson(x)));

String tempmaterialdispatchlistapiresponseToJson(
        List<Tempmaterialdispatchlistapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tempmaterialdispatchlistapiresponse {
  String status;
  String message;
  List<TempmaterialdispatchlistapiresponseDatum> data;

  Tempmaterialdispatchlistapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Tempmaterialdispatchlistapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Tempmaterialdispatchlistapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<TempmaterialdispatchlistapiresponseDatum>.from(json["data"]!
                .map((x) =>
                    TempmaterialdispatchlistapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TempmaterialdispatchlistapiresponseDatum {
  String id;
  String financialYear;
  String clientName;
  String itemGroup;
  String branchName;
  dynamic product;
  dynamic challanNumber;
  DateTime challanDate;
  String poNumber;
  String poDate;
  String name;
  String vehicleNumber;
  String lrNumber;
  String remarks;
  String dispatchType;
  dynamic natureOfProcess;
  String viewCount;
  String approveStatus;
  String addedById;
  dynamic employeeId;
  String alreadyOpen;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String client;
  String branch;
  dynamic natureOfProcessing;
  String transports;

  TempmaterialdispatchlistapiresponseDatum({
    required this.id,
    required this.financialYear,
    required this.clientName,
    required this.itemGroup,
    required this.branchName,
    required this.product,
    required this.challanNumber,
    required this.challanDate,
    required this.poNumber,
    required this.poDate,
    required this.name,
    required this.vehicleNumber,
    required this.lrNumber,
    required this.remarks,
    required this.dispatchType,
    required this.natureOfProcess,
    required this.viewCount,
    required this.approveStatus,
    required this.addedById,
    required this.employeeId,
    required this.alreadyOpen,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.client,
    required this.branch,
    required this.natureOfProcessing,
    required this.transports,
  });

  factory TempmaterialdispatchlistapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      TempmaterialdispatchlistapiresponseDatum(
        id: json["id"] ?? "",
        financialYear: json["financial_year"] ?? "",
        clientName: json["client_name"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchName: json["branch_name"] ?? "",
        product: json["product"] ?? "",
        challanNumber: json["challan_number"] ?? "",
        challanDate: DateTime.parse(json["challan_date"]),
        poNumber: json["po_number"] ?? "",
        poDate: json["po_date"] ?? "",
        name: json["name"] ?? "",
        vehicleNumber: json["vehicle_number"] ?? "",
        lrNumber: json["lr_number"] ?? "",
        remarks: json["remarks"] ?? "",
        dispatchType: json["dispatch_type"] ?? "",
        natureOfProcess: json["nature_of_process"] ?? "",
        viewCount: json["view_count"] ?? "",
        approveStatus: json["approve_status"] ?? "",
        addedById: json["added_by_id"] ?? "",
        employeeId: json["employee_id"] ?? "",
        alreadyOpen: json["already_open"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        client: json["client"] ?? "",
        branch: json["branch"] ?? "",
        natureOfProcessing: json["nature_of_processing"] ?? "",
        transports: json["transports"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "financial_year": financialYear,
        "client_name": clientName,
        "item_group": itemGroup,
        "branch_name": branchName,
        "product": product,
        "challan_number": challanNumber,
        "challan_date":
            "${challanDate.year.toString().padLeft(4, '0')}-${challanDate.month.toString().padLeft(2, '0')}-${challanDate.day.toString().padLeft(2, '0')}",
        "po_number": poNumber,
        "po_date": poDate,
        "name": name,
        "vehicle_number": vehicleNumber,
        "lr_number": lrNumber,
        "remarks": remarks,
        "dispatch_type": dispatchType,
        "nature_of_process": natureOfProcess,
        "view_count": viewCount,
        "approve_status": approveStatus,
        "added_by_id": addedById,
        "employee_id": employeeId,
        "already_open": alreadyOpen,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "client": client,
        "branch": branch,
        "nature_of_processing": natureOfProcessing,
        "transports": transports,
      };
}
