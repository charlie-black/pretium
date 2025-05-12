part of 'all_reservations_bloc.dart';

abstract class AllReservationsEvent extends Equatable {
  const AllReservationsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllReservations extends AllReservationsEvent {
  final bool showPayments;


  const FetchAllReservations( {

    required this.showPayments,
   
  });

  @override
  List<Object?> get props => [
    
    showPayments,
  

  ];
}

