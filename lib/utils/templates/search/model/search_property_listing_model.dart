

import 'dart:convert';

SearchPropertyListingModel allPropertyListingModelFromJson(String str) => SearchPropertyListingModel.fromJson(json.decode(str));

String allPropertyListingModelToJson(SearchPropertyListingModel data) => json.encode(data.toJson());

class SearchPropertyListingModel {
  String code;
  String currency;
  String description;
  GuestPlace guestPlace;
  HousingRules housingRules;
  int id;
  List<PropertyImage> images;
  Location location;
  int maxNights;
  int minNights;
  String name;
  int numberOfBathrooms;
  int numberOfBedrooms;
  int numberOfBeds;
  int numberOfGuests;
  int pricePerNight;
  PropertyType propertyType;

  SearchPropertyListingModel({
    required this.code,
    required this.currency,
    required this.description,
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
    required this.propertyType,
  });

  factory SearchPropertyListingModel.fromJson(Map<String, dynamic> json) => SearchPropertyListingModel(
    code: json["code"],
    currency: json["currency"],
    description: json["description"],
    guestPlace: GuestPlace.fromJson(json["guest_place"]),
    housingRules: HousingRules.fromJson(json["housing_rules"]),
    id: json["id"],
    images: List<PropertyImage>.from(json["images"].map((x) => PropertyImage.fromJson(x))),
    location: Location.fromJson(json["location"]),
    maxNights: json["max_nights"],
    minNights: json["min_nights"],
    name: json["name"],
    numberOfBathrooms: json["number_of_bathrooms"],
    numberOfBedrooms: json["number_of_bedrooms"],
    numberOfBeds: json["number_of_beds"],
    numberOfGuests: json["number_of_guests"],
    pricePerNight: json["price_per_night"],
    propertyType: PropertyType.fromJson(json["property_type"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "currency": currency,
    "description": description,
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
    "property_type": propertyType.toJson(),
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
  DateTime checkinTime;
  DateTime checkoutTime;
  bool eventsAllowed;
  bool petsAllowed;
  bool photographyVideographyAllowed;
  bool quietHours;
  bool smokingAllowed;

  HousingRules({
    required this.checkinTime,
    required this.checkoutTime,
    required this.eventsAllowed,
    required this.petsAllowed,
    required this.photographyVideographyAllowed,
    required this.quietHours,
    required this.smokingAllowed,
  });

  factory HousingRules.fromJson(Map<String, dynamic> json) => HousingRules(
    checkinTime: DateTime.parse(json["checkin_time"]),
    checkoutTime: DateTime.parse(json["checkout_time"]),
    eventsAllowed: json["events_allowed"],
    petsAllowed: json["pets_allowed"],
    photographyVideographyAllowed: json["photography_videography_allowed"],
    quietHours: json["quiet_hours"],
    smokingAllowed: json["smoking_allowed"],
  );

  Map<String, dynamic> toJson() => {
    "checkin_time": checkinTime.toIso8601String(),
    "checkout_time": checkoutTime.toIso8601String(),
    "events_allowed": eventsAllowed,
    "pets_allowed": petsAllowed,
    "photography_videography_allowed": photographyVideographyAllowed,
    "quiet_hours": quietHours,
    "smoking_allowed": smokingAllowed,
  };
}

class PropertyImage {
  int id;
  int propertyId;
  String image;
  DateTime createdAt;

  PropertyImage({
    required this.id,
    required this.propertyId,
    required this.image,
    required this.createdAt,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
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

class PropertyType {
  int id;
  String type;
  dynamic image;
  DateTime createdAt;
  String description;

  PropertyType({
    required this.id,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.description,
  });

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
    id: json["id"],
    type: json["type"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "description": description,
  };
}
