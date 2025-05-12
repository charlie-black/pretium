
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/property_details.dart';
import '../repository/property_details_api_repository.dart';

part 'property_details_event.dart';
part 'property_details_state.dart';

class PropertyDetailsBloc extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  final PropertyDetailsApiRepository apiRepository = PropertyDetailsApiRepository();
  PropertyDetailsBloc() : super(PropertyDetailsInitial()) {
    on<FetchPropertyDetails>((event, emit) async {
      emit(PropertyDetailsLoadingState());
      var response = await apiRepository.getPropertyDetails(event.propertyCode);

      if (response.errorMessage.isNotEmpty) {
        emit(PropertyDetailsErrorState(message: response.errorMessage));
      } else {
        emit(PropertyDetailsSuccessState(response.content));
      }
    });
  }
}
