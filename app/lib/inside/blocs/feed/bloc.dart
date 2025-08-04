import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/appointments/repository.dart';
import '../../../shared/mixins/logging.dart';
import 'event.dart';
import 'state.dart';

class Feed_Bloc extends Bloc<Feed_Event, Feed_State> with SharedMixin_Logging {
  Feed_Bloc({required this.appointmentsRepository})
    : super(const Feed_State()) {
    on<Feed_Event_LoadAppointments>(_onLoadAppointments);
    on<Feed_Event_RefreshAppointments>(_onRefreshAppointments);

    // Load appointments on initialization
    add(const Feed_Event_LoadAppointments());
  }

  final Appointments_Repository appointmentsRepository;

  Future<void> _onLoadAppointments(
    Feed_Event_LoadAppointments event,
    Emitter<Feed_State> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      log.info('Loading appointments from database');
      final appointments = await appointmentsRepository.getUserAppointments();

      emit(
        state.copyWith(
          appointments: appointments,
          isLoading: false,
          error: null,
        ),
      );
    } catch (error, stackTrace) {
      log.warning('Failed to load appointments', error, stackTrace);
      emit(
        state.copyWith(isLoading: false, error: 'Failed to load appointments'),
      );
    }
  }

  Future<void> _onRefreshAppointments(
    Feed_Event_RefreshAppointments event,
    Emitter<Feed_State> emit,
  ) async {
    try {
      log.info('Refreshing appointments from database');
      final appointments = await appointmentsRepository.getUserAppointments();

      emit(state.copyWith(appointments: appointments, error: null));
    } catch (error, stackTrace) {
      log.warning('Failed to refresh appointments', error, stackTrace);
      emit(state.copyWith(error: 'Failed to refresh appointments'));
    }
  }
}
