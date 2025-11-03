import 'dart:convert';

// Function to parse the JSON response string into a list of Readystocklistresponse objects
List<Readystocklistresponse> readystocklistresponseFromJson(String str) =>
    List<Readystocklistresponse>.from(
        json.decode(str).map((x) => Readystocklistresponse.fromJson(x)));

// Function to convert the list of Readystocklistresponse objects back into a JSON string
String readystocklistresponseToJson(List<Readystocklistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Readystocklistresponse {
  String status;
  String message;
  List<ReadystocklistresponseDatum> data;

  Readystocklistresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor to create a Readystocklistresponse object from a JSON map
  factory Readystocklistresponse.fromJson(Map<String, dynamic> json) =>
      Readystocklistresponse(
        status: json["status"],
        message: json["message"],
        data: List<ReadystocklistresponseDatum>.from(
            json["data"].map((x) => ReadystocklistresponseDatum.fromJson(x))),
      );

  // Method to convert Readystocklistresponse object to a JSON map
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ReadystocklistresponseDatum {
  String id;
  String clientNameId;
  String itemGroup;
  String branchNameId;
  String productNameId;
  String productName;
  String approvedQuantity;
  String avgQty;
  String package;
  String quantity;
  String rackId;
  String binId;
  String qcId;
  String status;
  String isDeleted;
  DateTime createdOn;
  DateTime updatedOn;
  String branchName;
  String clientName;
  String rackName;
  String bincardName;

  ReadystocklistresponseDatum({
    required this.id,
    required this.clientNameId,
    required this.itemGroup,
    required this.branchNameId,
    required this.productNameId,
    required this.productName,
    required this.approvedQuantity,
    required this.avgQty,
    required this.package,
    required this.quantity,
    required this.rackId,
    required this.binId,
    required this.qcId,
    required this.status,
    required this.isDeleted,
    required this.createdOn,
    required this.updatedOn,
    required this.branchName,
    required this.clientName,
    required this.rackName,
    required this.bincardName,
  });

  // Factory constructor to create a ReadystocklistresponseDatum object from a JSON map
  factory ReadystocklistresponseDatum.fromJson(Map<String, dynamic> json) =>
      ReadystocklistresponseDatum(
        id: json["id"] ?? "",
        clientNameId: json["client_name_id"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchNameId: json["branch_name_id"] ?? "",
        productNameId: json["product_name_id"] ?? "",
        productName: json["product_name"] ?? "",
        approvedQuantity: json["approved_quantity"] ?? "0",
        avgQty: json["avg_qty"] ?? "0",
        package: json["package"] ?? "0",
        quantity: json["quantity"] ?? "0",
        rackId: json["rack_id"] ?? "",
        binId: json["bin_id"] ?? "",
        qcId: json["qc_id"] ?? "",
        status: json["status"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        createdOn: json["created_on"] != null
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"] != null
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        branchName: json["branch_name"] ?? "",
        clientName: json["client_name"] ?? "",
        rackName: json["rack_name"] ?? "",
        bincardName: json["bincard_name"] ?? "",
      );

  // Method to convert ReadystocklistresponseDatum object to a JSON map
  Map<String, dynamic> toJson() => {
        "id": id,
        "client_name_id": clientNameId,
        "item_group": itemGroup,
        "branch_name_id": branchNameId,
        "approved_quantity": approvedQuantity,
        "avg_qty": avgQty,
        "package": package,
        "quantity": quantity,
        "rack_id": rackId,
        "bin_id": binId,
        "qc_id": qcId,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "branch_name": branchName,
        "client_name": clientName,
        "rack_name": rackName,
        "bincard_name": bincardName,
      };
}
