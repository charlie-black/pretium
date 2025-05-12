import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/all_reservations_model.dart';
import '../repository/all_reservations_repository.dart';

part 'all_reservations_event.dart';
part 'all_reservations_state.dart';

class AllReservationsBloc extends Bloc<AllReservationsEvent, AllReservationsState> {
  final AllReservationsRepository api;

  AllReservationsBloc(this.api) : super(AllReservationsInitial()) {
    on<FetchAllReservations>((event, emit) async {
      emit(AllReservationsLoading());

      try {
        final fetchedAllReservations = await api.getReservations(
          showPayments: event.showPayments
            );
        emit(AllReservationsLoaded(fetchedAllReservations));
      } catch (e) {
        emit(AllReservationsError(e.toString()));
      }
    });
  }
}
