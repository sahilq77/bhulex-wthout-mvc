import 'dart:convert';

DeleteQcApi deleteQcApiFromJson(String str) =>
    DeleteQcApi.fromJson(json.decode(str));

String deleteQcApiToJson(DeleteQcApi data) => json.encode(data.toJson());

class DeleteQcApi {
  String id;

  DeleteQcApi({
    required this.id,
  });

  factory DeleteQcApi.fromJson(Map<String, dynamic> json) => DeleteQcApi(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
