part of 'property_details_bloc.dart';

class PropertyDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PropertyDetailsInitial extends PropertyDetailsState {}

class PropertyDetailsInitState extends PropertyDetailsState {}

class PropertyDetailsLoadingState extends PropertyDetailsState {}

class PropertyDetailsSuccessState extends PropertyDetailsState {
  final PropertyDetailsModel? propertyDetail;
  PropertyDetailsSuccessState(this.propertyDetail);
}

class PropertyDetailsErrorState extends PropertyDetailsState {
  final String message;
  PropertyDetailsErrorState({required this.message});
}
