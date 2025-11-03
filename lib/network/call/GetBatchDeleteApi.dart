import 'dart:convert';

PackageDetailsApi getBatchDeleteApiFromJson(String str) =>
    PackageDetailsApi.fromJson(json.decode(str));

String getBatchDeleteApiToJson(PackageDetailsApi data) =>
    json.encode(data.toJson());

class PackageDetailsApi {
  String customer_id;
  String package_id;

  PackageDetailsApi({
    required this.customer_id,
    required this.package_id,
  });

  factory PackageDetailsApi.fromJson(Map<String, dynamic> json) =>
      PackageDetailsApi(
        customer_id: json["customer_id"],
        package_id: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customer_id,
        "package_id": package_id,
      };
}
