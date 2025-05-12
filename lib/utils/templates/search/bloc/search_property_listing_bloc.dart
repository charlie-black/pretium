import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/search_property_listing_model.dart';
import '../repository/search_property_listing_repository.dart';

part 'search_property_listing_event.dart';
part 'search_property_listing_state.dart';

class SearchPropertyListingBloc
    extends Bloc<SearchPropertyListingEvent, SearchPropertyListingState> {
  final SearchPropertyListingRepository api;

  SearchPropertyListingBloc(this.api) : super(SearchPropertyListingInitial()) {
    on<FetchSearchPropertyListing>((event, emit) async {
      emit(SearchPropertyListingLoading());

      try {
        final fetchedSearchPropertyListing = await api.getStays(
          latitude: event.latitude,
          longitude: event.longitude,
          propertyTypes: event.propertyTypes,
          amenitiesId: event.amenitiesId,
          numberOfGuests: event.numberOfGuests,
          numberOfBeds: event.numberOfBeds,
          numberOfBathrooms: event.numberOfBathrooms,
          searchType: event.searchType,
          numberOfBedrooms: event.numberOfBedrooms,
        );
        emit(SearchPropertyListingLoaded(fetchedSearchPropertyListing));
      } catch (e) {
        emit(SearchPropertyListingError(e.toString()));
      }
    });
  }
}
