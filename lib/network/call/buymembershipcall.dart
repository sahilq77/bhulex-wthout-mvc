// To parse this JSON data, do
//
//     final buymembershipcall = buymembershipcallFromJson(jsonString);

import 'dart:convert';

Buymembershipcall buymembershipcallFromJson(String str) =>
    Buymembershipcall.fromJson(json.decode(str));

String buymembershipcallToJson(Buymembershipcall data) =>
    json.encode(data.toJson());

class Buymembershipcall {
  String loginId;
  String membershipId;
  String transactionId;
  String paymentStatus;
  String isCouponApplied;
  String appliedCouponId;
  String paymentAmount;

  Buymembershipcall({
    required this.loginId,
    required this.membershipId,
    required this.transactionId,
    required this.paymentStatus,
    required this.isCouponApplied,
    required this.appliedCouponId,
    required this.paymentAmount,
  });

  factory Buymembershipcall.fromJson(Map<String, dynamic> json) =>
      Buymembershipcall(
        loginId: json["login_id"],
        membershipId: json["membership_id"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        isCouponApplied: json["is_coupon_applied"],
        appliedCouponId: json["applied_coupon_id"],
        paymentAmount: json["payment_amount"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "membership_id": membershipId,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "is_coupon_applied": isCouponApplied,
        "applied_coupon_id": appliedCouponId,
        "payment_amount": paymentAmount,
      };
}
