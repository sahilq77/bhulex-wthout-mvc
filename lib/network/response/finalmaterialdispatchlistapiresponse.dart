// To parse this JSON data, do
//
//     final finalmaterialdispatchlistapiresponse = finalmaterialdispatchlistapiresponseFromJson(jsonString);

import 'dart:convert';

List<Finalmaterialdispatchlistapiresponse>
    finalmaterialdispatchlistapiresponseFromJson(String str) =>
        List<Finalmaterialdispatchlistapiresponse>.from(json
            .decode(str)
            .map((x) => Finalmaterialdispatchlistapiresponse.fromJson(x)));

String finalmaterialdispatchlistapiresponseToJson(
        List<Finalmaterialdispatchlistapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Finalmaterialdispatchlistapiresponse {
  String status;
  String message;
  List<FinalmaterialdispatchlistapiresponseDatum> data;

  Finalmaterialdispatchlistapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Finalmaterialdispatchlistapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Finalmaterialdispatchlistapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<FinalmaterialdispatchlistapiresponseDatum>.from(json["data"]
            .map((x) => FinalmaterialdispatchlistapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FinalmaterialdispatchlistapiresponseDatum {
  String id;
  String financialYear;
  String invoiceStatus;
  dynamic invoiceReferenceId;
  String clientName;
  String itemGroup;
  String branchName;
  dynamic product;
  String challanNumber;
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
  String dispatchPrint;
  String invoice_number;
  FinalmaterialdispatchlistapiresponseDatum(
      {required this.id,
      required this.financialYear,
      required this.invoiceStatus,
      required this.invoiceReferenceId,
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
      required this.dispatchPrint,
      required this.invoice_number});

  factory FinalmaterialdispatchlistapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      FinalmaterialdispatchlistapiresponseDatum(
        id: json["id"] ?? "",
        financialYear: json["financial_year"] ?? "",
        invoiceStatus: json["invoice_status"] ?? "",
        invoiceReferenceId: json["invoice_reference_id"] ?? "",
        clientName: json["client_name"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchName: json["branch_name"] ?? "",
        product: json["product"] ?? "",
        challanNumber: json["challan_number"] ?? "",
        challanDate: json["challan_date"] != ""
            ? DateTime.parse(json["challan_date"])
            : DateTime.now(),
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
        createdOn: json["created_on"] != ""
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"] != ""
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        client: json["client"] ?? "",
        branch: json["branch"] ?? "",
        natureOfProcessing: json["nature_of_processing"] ?? "",
        transports: json["transports"] ?? "",
        dispatchPrint: json["dispatch_print"] ?? "",
        invoice_number: json["invoice_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "financial_year": financialYear,
        "invoice_status": invoiceStatus,
        "invoice_reference_id": invoiceReferenceId,
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
        "dispatch_print": dispatchPrint,
        "invoice_number": invoice_number,
      };
}
