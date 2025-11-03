// To parse this JSON data, do
//
//     final buytestseriescall = buytestseriescallFromJson(jsonString);

import 'dart:convert';

Buytestseriescall buytestseriescallFromJson(String str) =>
    Buytestseriescall.fromJson(json.decode(str));

String buytestseriescallToJson(Buytestseriescall data) =>
    json.encode(data.toJson());

class Buytestseriescall {
  String loginId;
  String testId;
  String transactionId;
  String paymentStatus;
  String isCouponApplied;
  String appliedCouponId;
  String paymentAmount;

  Buytestseriescall({
    required this.loginId,
    required this.testId,
    required this.transactionId,
    required this.paymentStatus,
    required this.isCouponApplied,
    required this.appliedCouponId,
    required this.paymentAmount,
  });

  factory Buytestseriescall.fromJson(Map<String, dynamic> json) =>
      Buytestseriescall(
        loginId: json["login_id"],
        testId: json["test_id"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        isCouponApplied: json["is_coupon_applied"],
        appliedCouponId: json["applied_coupon_id"],
        paymentAmount: json["payment_amount"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "test_id": testId,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "is_coupon_applied": isCouponApplied,
        "applied_coupon_id": appliedCouponId,
        "payment_amount": paymentAmount,
      };
}
