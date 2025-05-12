import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/entity_repository.dart';


part 'entity_event.dart';
part 'entity_state.dart';

class EntityBloc
    extends Bloc<EntityEvent, EntityState> {
  final EntityRepository api;

  EntityBloc({required this.api})
      : super(EntityInitial()) {
    on<EntityButtonPressed>(_onEntityButtonPressed);
  }

  Future<void> _onEntityButtonPressed(
      EntityButtonPressed event,
      Emitter<EntityState> emit) async {
    emit(EntityLoading());

    try {
      final statusCode = await api.entity(
        callingCode: event.callingCode,
        phoneNumber: event.phone,
      );

      if (statusCode == 200) {
        final responseData = await api.getEntityResponseData();

        if (responseData?['error'] == false) {
          emit(EntitySuccess(apiResponseData: responseData ?? {}));
        } else {
          emit(EntityFailure(
              error: responseData?['message'] ?? 'Entity failed'));
        }
      } else {
        emit(EntityFailure(
            error: "Entity failed with status: $statusCode"));
      }
    } on NoInternetException {
      emit(EntityFailure(error: "No internet connection"));
    } on TimeoutException {
      emit(EntityFailure(
          error: "Request timed out. Please try again later."));
    } catch (e) {
      emit(EntityFailure(
          error: e.toString()));
    }
  }
}
