import 'dart:convert';

PaymentCall paymentCallFromJson(String str) =>
    PaymentCall.fromJson(json.decode(str));

String paymentCallToJson(PaymentCall data) => json.encode(data.toJson());

class PaymentCall {
  String loginId;
  String offset;
  String limit;

  PaymentCall({
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory PaymentCall.fromJson(Map<String, dynamic> json) => PaymentCall(
        loginId: json["login_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "offset": offset,
        "limit": limit,
      };
}
