
import 'dart:convert';

PropertyDetailsModel propertyDetailsModelFromJson(String str) => PropertyDetailsModel.fromJson(json.decode(str));

String propertyDetailsModelToJson(PropertyDetailsModel data) => json.encode(data.toJson());

class PropertyDetailsModel {
  List<PropertyType> amenities;
  CancellationRule cancellationRule;
  String code;
  String currency;
  String description;
  List<PropertyType> guestFavourites;
  GuestPlace guestPlace;
  HousingRules housingRules;
  int id;
  List<Image> images;
  Location location;
  int maxNights;
  int minNights;
  String name;
  int numberOfBathrooms;
  int numberOfBedrooms;
  int numberOfBeds;
  int numberOfGuests;
  int pricePerNight;
  dynamic pricePerNightAdjustments;
  PropertyType propertyType;
  List<RestrictedCheck> restrictedCheckins;
  List<RestrictedCheck> restrictedCheckouts;
  List<dynamic> safetyItems;

  PropertyDetailsModel({
    required this.amenities,
    required this.cancellationRule,
    required this.code,
    required this.currency,
    required this.description,
    required this.guestFavourites,
    required this.guestPlace,
    required this.housingRules,
    required this.id,
    required this.images,
    required this.location,
    required this.maxNights,
    required this.minNights,
    required this.name,
    required this.numberOfBathrooms,
    required this.numberOfBedrooms,
    required this.numberOfBeds,
    required this.numberOfGuests,
    required this.pricePerNight,
    required this.pricePerNightAdjustments,
    required this.propertyType,
    required this.restrictedCheckins,
    required this.restrictedCheckouts,
    required this.safetyItems,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) => PropertyDetailsModel(
    amenities: List<PropertyType>.from(json["amenities"].map((x) => PropertyType.fromJson(x))),
    cancellationRule: CancellationRule.fromJson(json["cancellation_rule"]),
    code: json["code"],
    currency: json["currency"],
    description: json["description"],
    guestFavourites: List<PropertyType>.from(json["guest_favourites"].map((x) => PropertyType.fromJson(x))),
    guestPlace: GuestPlace.fromJson(json["guest_place"]),
    housingRules: HousingRules.fromJson(json["housing_rules"]),
    id: json["id"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    location: Location.fromJson(json["location"]),
    maxNights: json["max_nights"],
    minNights: json["min_nights"],
    name: json["name"],
    numberOfBathrooms: json["number_of_bathrooms"],
    numberOfBedrooms: json["number_of_bedrooms"],
    numberOfBeds: json["number_of_beds"],
    numberOfGuests: json["number_of_guests"],
    pricePerNight: json["price_per_night"],
    pricePerNightAdjustments: json["price_per_night_adjustments"],
    propertyType: PropertyType.fromJson(json["property_type"]),
    restrictedCheckins: List<RestrictedCheck>.from(json["restricted_checkins"].map((x) => RestrictedCheck.fromJson(x))),
    restrictedCheckouts: List<RestrictedCheck>.from(json["restricted_checkouts"].map((x) => RestrictedCheck.fromJson(x))),
    safetyItems: List<dynamic>.from(json["safety_items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
    "cancellation_rule": cancellationRule.toJson(),
    "code": code,
    "currency": currency,
    "description": description,
    "guest_favourites": List<dynamic>.from(guestFavourites.map((x) => x.toJson())),
    "guest_place": guestPlace.toJson(),
    "housing_rules": housingRules.toJson(),
    "id": id,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "location": location.toJson(),
    "max_nights": maxNights,
    "min_nights": minNights,
    "name": name,
    "number_of_bathrooms": numberOfBathrooms,
    "number_of_bedrooms": numberOfBedrooms,
    "number_of_beds": numberOfBeds,
    "number_of_guests": numberOfGuests,
    "price_per_night": pricePerNight,
    "price_per_night_adjustments": pricePerNightAdjustments,
    "property_type": propertyType.toJson(),
    "restricted_checkins": List<dynamic>.from(restrictedCheckins.map((x) => x.toJson())),
    "restricted_checkouts": List<dynamic>.from(restrictedCheckouts.map((x) => x.toJson())),
    "safety_items": List<dynamic>.from(safetyItems.map((x) => x)),
  };
}

class PropertyType {
  int id;
  String? name;
  String description;
  String? image;
  DateTime createdAt;
  String? type;

  PropertyType({
    required this.id,
    this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    this.type,
  });

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "type": type,
  };
}

class CancellationRule {
  int id;
  int daysBeforeCheckin;
  String chargeType;
  String cancellationCharge;
  DateTime createdAt;

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
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "days_before_checkin": daysBeforeCheckin,
    "charge_type": chargeType,
    "cancellation_charge": cancellationCharge,
    "created_at": createdAt.toIso8601String(),
  };
}

class GuestPlace {
  int id;
  String place;
  String description;
  DateTime createdAt;

  GuestPlace({
    required this.id,
    required this.place,
    required this.description,
    required this.createdAt,
  });

  factory GuestPlace.fromJson(Map<String, dynamic> json) => GuestPlace(
    id: json["id"],
    place: json["place"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "place": place,
    "description": description,
    "created_at": createdAt.toIso8601String(),
  };
}

class HousingRules {
  String additionalRules;
  DateTime checkinTime;
  DateTime checkoutTime;
  bool eventsAllowed;
  bool petsAllowed;
  bool photographyVideographyAllowed;
  bool quietHours;
  bool smokingAllowed;

  HousingRules({
    required this.additionalRules,
    required this.checkinTime,
    required this.checkoutTime,
    required this.eventsAllowed,
    required this.petsAllowed,
    required this.photographyVideographyAllowed,
    required this.quietHours,
    required this.smokingAllowed,
  });

  factory HousingRules.fromJson(Map<String, dynamic> json) => HousingRules(
    additionalRules: json["additional_rules"],
    checkinTime: DateTime.parse(json["checkin_time"]),
    checkoutTime: DateTime.parse(json["checkout_time"]),
    eventsAllowed: json["events_allowed"],
    petsAllowed: json["pets_allowed"],
    photographyVideographyAllowed: json["photography_videography_allowed"],
    quietHours: json["quiet_hours"],
    smokingAllowed: json["smoking_allowed"],
  );

  Map<String, dynamic> toJson() => {
    "additional_rules": additionalRules,
    "checkin_time": checkinTime.toIso8601String(),
    "checkout_time": checkoutTime.toIso8601String(),
    "events_allowed": eventsAllowed,
    "pets_allowed": petsAllowed,
    "photography_videography_allowed": photographyVideographyAllowed,
    "quiet_hours": quietHours,
    "smoking_allowed": smokingAllowed,
  };
}

class Image {
  int id;
  int propertyId;
  String image;
  DateTime createdAt;

  Image({
    required this.id,
    required this.propertyId,
    required this.image,
    required this.createdAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    propertyId: json["property_id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "property_id": propertyId,
    "image": image,
    "created_at": createdAt.toIso8601String(),
  };
}

class Location {
  String building;
  String city;
  String country;
  String floor;
  String formattedAddress;
  double lat;
  double lng;
  String location;
  String streetAddress;
  String unit;

  Location({
    required this.building,
    required this.city,
    required this.country,
    required this.floor,
    required this.formattedAddress,
    required this.lat,
    required this.lng,
    required this.location,
    required this.streetAddress,
    required this.unit,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    building: json["building"],
    city: json["city"],
    country: json["country"],
    floor: json["floor"],
    formattedAddress: json["formatted_address"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    location: json["location"],
    streetAddress: json["street_address"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "building": building,
    "city": city,
    "country": country,
    "floor": floor,
    "formatted_address": formattedAddress,
    "lat": lat,
    "lng": lng,
    "location": location,
    "street_address": streetAddress,
    "unit": unit,
  };
}

class RestrictedCheck {
  int id;
  int propertyId;
  String dayOfWeek;

  RestrictedCheck({
    required this.id,
    required this.propertyId,
    required this.dayOfWeek,
  });

  factory RestrictedCheck.fromJson(Map<String, dynamic> json) => RestrictedCheck(
    id: json["id"],
    propertyId: json["property_id"],
    dayOfWeek: json["day_of_week"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "property_id": propertyId,
    "day_of_week": dayOfWeek,
  };
}
