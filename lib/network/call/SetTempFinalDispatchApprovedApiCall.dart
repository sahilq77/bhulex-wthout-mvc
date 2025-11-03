import 'dart:convert';

SetTempFinalDispatchApprovedApi setTempFinalDispatchApprovedApiFromJson(
        String str) =>
    SetTempFinalDispatchApprovedApi.fromJson(json.decode(str));

String setTempFinalDispatchApprovedApiToJson(
        SetTempFinalDispatchApprovedApi data) =>
    json.encode(data.toJson());

class SetTempFinalDispatchApprovedApi {
  String dispatchType;
  String id;

  SetTempFinalDispatchApprovedApi({
    required this.dispatchType,
    required this.id,
  });

  factory SetTempFinalDispatchApprovedApi.fromJson(Map<String, dynamic> json) =>
      SetTempFinalDispatchApprovedApi(
        dispatchType: json["dispatch_type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dispatch_type": dispatchType,
        "id": id,
      };
}
