part of 'entity_bloc.dart';


abstract class EntityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EntityButtonPressed extends EntityEvent {
  final String callingCode;
  final String phone;

  EntityButtonPressed({
    required this.callingCode,
    required this.phone,
  });

  @override
  List<Object?> get props => [callingCode, phone];
}
