part of 'search_property_listing_bloc.dart';

abstract class SearchPropertyListingState extends Equatable {
  const SearchPropertyListingState();

  @override
  List<Object?> get props => [];
}

class SearchPropertyListingInitial extends SearchPropertyListingState {}

class SearchPropertyListingLoading extends SearchPropertyListingState {}

class SearchPropertyListingLoaded extends SearchPropertyListingState {
  final List<SearchPropertyListingModel> propertyListing;

  const SearchPropertyListingLoaded(this.propertyListing);

  @override
  List<Object?> get props => [propertyListing];
}

class SearchPropertyListingError extends SearchPropertyListingState {
  final String errorMessage;

  const SearchPropertyListingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
