// To parse this JSON data, do
//
//     final setTempFinalDispatchApprovedApiResponse = setTempFinalDispatchApprovedApiResponseFromJson(jsonString);

import 'dart:convert';

List<SetTempFinalDispatchApprovedApiResponse>
    setTempFinalDispatchApprovedApiResponseFromJson(String str) =>
        List<SetTempFinalDispatchApprovedApiResponse>.from(json
            .decode(str)
            .map((x) => SetTempFinalDispatchApprovedApiResponse.fromJson(x)));

String setTempFinalDispatchApprovedApiResponseToJson(
        List<SetTempFinalDispatchApprovedApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SetTempFinalDispatchApprovedApiResponse {
  String status;
  String message;
  SetTempFinalDispatchApprovedApiResponseData data;

  SetTempFinalDispatchApprovedApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SetTempFinalDispatchApprovedApiResponse.fromJson(
          Map<String, dynamic> json) =>
      SetTempFinalDispatchApprovedApiResponse(
        status: json["status"],
        message: json["message"],
        data:
            SetTempFinalDispatchApprovedApiResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class SetTempFinalDispatchApprovedApiResponseData {
  String approveStatus;
  String challanNumber;

  SetTempFinalDispatchApprovedApiResponseData({
    required this.approveStatus,
    required this.challanNumber,
  });

  factory SetTempFinalDispatchApprovedApiResponseData.fromJson(
          Map<String, dynamic> json) =>
      SetTempFinalDispatchApprovedApiResponseData(
        approveStatus: json["approve_status"] ?? "",
        challanNumber: json["challan_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "approve_status": approveStatus,
        "challan_number": challanNumber,
      };
}
