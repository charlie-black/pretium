part of 'search_property_listing_bloc.dart';

abstract class SearchPropertyListingEvent extends Equatable {
  const SearchPropertyListingEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchPropertyListing extends SearchPropertyListingEvent {
  final double latitude;
  final double longitude;
  final List propertyTypes;
  final List amenitiesId;
  final int numberOfGuests;
  final int numberOfBeds;
  final int numberOfBathrooms;
  final int numberOfBedrooms;
  final String searchType;

  const FetchSearchPropertyListing({
    required this.latitude,
    required this.longitude,
    required this.propertyTypes,
    required this.amenitiesId,
    required this.numberOfBedrooms,
    required this.numberOfGuests,
    required this.numberOfBathrooms,
    required this.numberOfBeds,
    required this.searchType,
  });

  @override
  List<Object?> get props => [
    longitude,
    latitude,
    propertyTypes,
    amenitiesId,
    numberOfBedrooms,
    numberOfGuests,
    numberOfBathrooms,
    numberOfBeds,
    searchType,
  ];
}
