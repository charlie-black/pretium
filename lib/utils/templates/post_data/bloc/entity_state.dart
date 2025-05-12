part of 'entity_bloc.dart';

abstract class EntityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EntityInitial extends EntityState {}

class EntityLoading extends EntityState {}

class EntitySuccess extends EntityState {
  final Map<String, dynamic> apiResponseData;

  EntitySuccess({required this.apiResponseData});

  @override
  List<Object?> get props => [apiResponseData];
}

class EntityFailure extends EntityState {
  final String error;

  EntityFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
