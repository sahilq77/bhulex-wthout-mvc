import 'dart:convert';

TempMaterialDispatchPreviewApi tempMaterialDispatchPreviewApiFromJson(String str) =>
    TempMaterialDispatchPreviewApi.fromJson(json.decode(str));

String tempMaterialDispatchPreviewApiToJson(TempMaterialDispatchPreviewApi data) =>
    json.encode(data.toJson());

class TempMaterialDispatchPreviewApi {
  String id;

  TempMaterialDispatchPreviewApi({
    required this.id,
  });

  factory TempMaterialDispatchPreviewApi.fromJson(Map<String, dynamic> json) =>
      TempMaterialDispatchPreviewApi(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
