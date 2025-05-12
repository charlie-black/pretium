import 'dart:convert';

AllReservationsModel propertyDetailsModelFromJson(String str) => AllReservationsModel.fromJson(json.decode(str));

String propertyDetailsModelToJson(AllReservationsModel data) => json.encode(data.toJson());

class AllReservationsModel {
  dynamic payments;
  dynamic property;
  dynamic reservation;

  AllReservationsModel({
    required this.payments,
    required this.property,
    required this.reservation,
  });

  factory AllReservationsModel.fromJson(Map<String, dynamic> json) => AllReservationsModel(
    payments: json["payments"],
    property: Property.fromJson(json["property"]),
    reservation: Reservation.fromJson(json["reservation"]),
  );

  Map<String, dynamic> toJson() => {
    "payments": payments,
    "property": property.toJson(),
    "reservation": reservation.toJson(),
  };
}

class Property {
  dynamic code;
  dynamic id;
  dynamic images;
  dynamic name;

  Property({
    required this.code,
    required this.id,
    required this.images,
    required this.name,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    code: json["code"],
    id: json["id"],
    images: json["images"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "id": id,
    "images": images,
    "name": name,
  };
}

class Reservation {
  dynamic id;
  dynamic userId;
  dynamic ref;
  dynamic bookingDate;
  dynamic totalAmount;
  dynamic createdAt;
  dynamic bookingRef;
  dynamic checkinDate;
  dynamic checkoutDate;
  dynamic bookingDetails;
  dynamic canRefund;
  dynamic cancelDate;
  dynamic refundPaid;
  dynamic numberOfAdults;
  dynamic numberOfChildren;
  dynamic numberOfInfants;
  dynamic providerId;
  dynamic currency;
  dynamic cancelledBy;
  dynamic cancelledAt;
  dynamic status;
  dynamic isInstantBooking;
  dynamic statusText;
  dynamic propertyId;

  Reservation({
    required this.id,
    required this.userId,
    required this.ref,
    required this.bookingDate,
    required this.totalAmount,
    required this.createdAt,
    required this.bookingRef,
    required this.checkinDate,
    required this.checkoutDate,
    required this.bookingDetails,
    required this.canRefund,
    required this.cancelDate,
    required this.refundPaid,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.numberOfInfants,
    required this.providerId,
    required this.currency,
    required this.cancelledBy,
    required this.cancelledAt,
    required this.status,
    required this.isInstantBooking,
    required this.statusText,
    required this.propertyId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    id: json["id"],
    userId: json["user_id"],
    ref: json["ref"],
    bookingDate: json["booking_date"],
    totalAmount: json["total_amount"],
    createdAt: json["created_at"],
    bookingRef: json["booking_ref"],
    checkinDate: json["checkin_date"],
    checkoutDate: json["checkout_date"],
    bookingDetails: BookingDetails.fromJson(json["booking_details"]),
    canRefund: json["can_refund"],
    cancelDate: json["cancel_date"],
    refundPaid: json["refund_paid"],
    numberOfAdults: json["number_of_adults"],
    numberOfChildren: json["number_of_children"],
    numberOfInfants: json["number_of_infants"],
    providerId: json["provider_id"],
    currency: json["currency"],
    cancelledBy: json["cancelled_by"],
    cancelledAt: json["cancelled_at"],
    status: json["status"],
    isInstantBooking: json["is_instant_booking"],
    statusText: json["status_text"],
    propertyId: json["property_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "ref": ref,
    "booking_date": bookingDate,
    "total_amount": totalAmount,
    "created_at": createdAt,
    "booking_ref": bookingRef,
    "checkin_date": checkinDate,
    "checkout_date": checkoutDate,
    "booking_details": bookingDetails.toJson(),
    "can_refund": canRefund,
    "cancel_date": cancelDate,
    "refund_paid": refundPaid,
    "number_of_adults": numberOfAdults,
    "number_of_children": numberOfChildren,
    "number_of_infants": numberOfInfants,
    "provider_id": providerId,
    "currency": currency,
    "cancelled_by": cancelledBy,
    "cancelled_at": cancelledAt,
    "status": status,
    "is_instant_booking": isInstantBooking,
    "status_text": statusText,
    "property_id": propertyId,
  };
}

class BookingDetails {
  dynamic cancellationRule;
  dynamic priceBreakdown;

  BookingDetails({
    required this.cancellationRule,
    required this.priceBreakdown,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
    cancellationRule: CancellationRule.fromJson(json["cancellation_rule"]),
    priceBreakdown: json["price_breakdown"],
  );

  Map<String, dynamic> toJson() => {
    "cancellation_rule": cancellationRule.toJson(),
    "price_breakdown": priceBreakdown,
  };
}

class CancellationRule {
  dynamic id;
  dynamic daysBeforeCheckin;
  dynamic chargeType;
  dynamic cancellationCharge;
  dynamic createdAt;

  CancellationRule({
    required this.id,
    required this.daysBeforeCheckin,
    required this.chargeType,
    required this.cancellationCharge,
    required this.createdAt,
  });

  factory CancellationRule.fromJson(Map<String, dynamic> json) => CancellationRule(
    id: json["id"],
    daysBeforeCheckin: json["days_before_checkin"],
    chargeType: json["charge_type"],
    cancellationCharge: json["cancellation_charge"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "days_before_checkin": daysBeforeCheckin,
    "charge_type": chargeType,
    "cancellation_charge": cancellationCharge,
    "created_at": createdAt,
  };
}

class PriceBreakdown {
  dynamic cancellationRule;
  dynamic cost;
  dynamic date;
  dynamic tax;

  PriceBreakdown({
    required this.cancellationRule,
    required this.cost,
    required this.date,
    required this.tax,
  });

  factory PriceBreakdown.fromJson(Map<String, dynamic> json) => PriceBreakdown(
    cancellationRule: CancellationRule.fromJson(json["cancellation_rule"]),
    cost: json["cost"],
    date: json["date"],
    tax: json["tax"],
  );

  Map<String, dynamic> toJson() => {
    "cancellation_rule": cancellationRule.toJson(),
    "cost": cost,
    "date": date,
    "tax": tax,
  };
}