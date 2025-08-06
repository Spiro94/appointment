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
    on<Feed_Event_TogglePastAppointments>(_onTogglePastAppointments);

    // Load appointments on initialization
    add(const Feed_Event_LoadAppointments());
  }

  final Appointments_Repository appointmentsRepository;

  Future<void> _onLoadAppointments(
    Feed_Event_LoadAppointments event,
    Emitter<Feed_State> emit,
  ) async {
    try {
      emit(state.copyWith(status: Feed_Status.loading, error: null));

      log.info('Loading appointments from database');

      final appointments =
          state.showPastAppointments
              ? await appointmentsRepository.getPastAppointments()
              : await appointmentsRepository.getFutureAppointments();

      emit(
        state.copyWith(
          appointments: appointments,
          status: Feed_Status.success,
          error: null,
        ),
      );
    } catch (error, stackTrace) {
      log.warning('Failed to load appointments', error, stackTrace);
      emit(
        state.copyWith(
          status: Feed_Status.error,
          error: 'Failed to load appointments',
        ),
      );
    }
  }

  Future<void> _onRefreshAppointments(
    Feed_Event_RefreshAppointments event,
    Emitter<Feed_State> emit,
  ) async {
    try {
      log.info('Refreshing appointments from database');

      final appointments =
          state.showPastAppointments
              ? await appointmentsRepository.getPastAppointments()
              : await appointmentsRepository.getFutureAppointments();

      emit(
        state.copyWith(
          appointments: appointments,
          status: Feed_Status.success,
          error: null,
        ),
      );
    } catch (error, stackTrace) {
      log.warning('Failed to refresh appointments', error, stackTrace);
      emit(
        state.copyWith(
          status: Feed_Status.error,
          error: 'Failed to refresh appointments',
        ),
      );
    }
  }

  Future<void> _onTogglePastAppointments(
    Feed_Event_TogglePastAppointments event,
    Emitter<Feed_State> emit,
  ) async {
    try {
      final newShowPastState = !state.showPastAppointments;
      log.info('Toggling past appointments view to: $newShowPastState');

      // Update the toggle state and start loading
      emit(
        state.copyWith(
          showPastAppointments: newShowPastState,
          status: Feed_Status.loading,
          error: null,
        ),
      );

      // Load appropriate appointments based on the new state
      final appointments =
          newShowPastState
              ? await appointmentsRepository.getPastAppointments()
              : await appointmentsRepository.getFutureAppointments();

      emit(
        state.copyWith(
          appointments: appointments,
          status: Feed_Status.success,
          error: null,
        ),
      );
    } catch (error, stackTrace) {
      log.warning('Failed to toggle appointments view', error, stackTrace);
      emit(
        state.copyWith(
          status: Feed_Status.error,
          error: 'Failed to load appointments',
        ),
      );
    }
  }
}
