part of 'all_reservations_bloc.dart';

abstract class AllReservationsState extends Equatable {
  const AllReservationsState();

  @override
  List<Object?> get props => [];
}

class AllReservationsInitial extends AllReservationsState {}

class AllReservationsLoading extends AllReservationsState {}

class AllReservationsLoaded extends AllReservationsState {
  final List<AllReservationsModel> reservations;

  const AllReservationsLoaded(this.reservations);

  @override
  List<Object?> get props => [reservations];
}

class AllReservationsError extends AllReservationsState {
  final String errorMessage;

  const AllReservationsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

