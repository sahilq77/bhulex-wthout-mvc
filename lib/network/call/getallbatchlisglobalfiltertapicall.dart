// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

getallbatchlisglobalfiltertapicall getallbatchlisglobalfiltertapicallFromJson(String str) =>
    getallbatchlisglobalfiltertapicall.fromJson(json.decode(str));

String getallbatchlisglobalfiltertapicallToJson(getallbatchlisglobalfiltertapicall data) =>
    json.encode(data.toJson());

class getallbatchlisglobalfiltertapicall {
  int offset;
  int limit;
  String machineId, productId, fromDate, toDate;
  getallbatchlisglobalfiltertapicall(
      {required this.offset,
      required this.limit,
      required this.machineId,
      required this.productId,
      required this.fromDate,
      required this.toDate,
   
    });

  factory getallbatchlisglobalfiltertapicall.fromJson(Map<String, dynamic> json) =>
      getallbatchlisglobalfiltertapicall(
        offset: json["offset"] ?? "0",
        limit: json["limit"] ?? "10",
        machineId: json["machine_id"] ?? "",
        productId: json["product_id"] ?? "",
        fromDate: json["fromDate"] ?? "",
        toDate: json["toDate"] ?? "",
    
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "machine_id": machineId,
        "product_id": productId,
        "fromDate": fromDate,
        "toDate": toDate,

      };
}
