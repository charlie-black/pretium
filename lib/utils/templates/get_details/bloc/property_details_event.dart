part of 'property_details_bloc.dart';

abstract class PropertyDetailsEvent extends Equatable {
  const PropertyDetailsEvent();
}

class FetchPropertyDetails extends PropertyDetailsEvent {
  final String propertyCode;
  const FetchPropertyDetails({required this.propertyCode});

  @override
  List<Object?> get props => [propertyCode];
}
