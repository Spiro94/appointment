import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/mixins/logging.dart';
import 'event.dart';
import 'state.dart';

class Feed_Bloc extends Bloc<Feed_Event, Feed_State> with SharedMixin_Logging {
  Feed_Bloc() : super(const Feed_State()) {
    on<Feed_Event_LoadAppointments>(_onLoadAppointments);
    on<Feed_Event_RefreshAppointments>(_onRefreshAppointments);

    // Load appointments on initialization
    add(const Feed_Event_LoadAppointments());
  }

  Future<void> _onLoadAppointments(
    Feed_Event_LoadAppointments event,
    Emitter<Feed_State> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      // TODO: Replace with actual repository call
      // For now, we'll simulate loading with some mock data
      await Future<void>.delayed(const Duration(seconds: 1));

      final mockAppointments = _generateMockAppointments();

      emit(
        state.copyWith(
          appointments: mockAppointments,
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
    // For refresh, we don't show loading state
    try {
      // TODO: Replace with actual repository call
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final mockAppointments = _generateMockAppointments();

      emit(state.copyWith(appointments: mockAppointments, error: null));
    } catch (error, stackTrace) {
      log.warning('Failed to refresh appointments', error, stackTrace);
      emit(state.copyWith(error: 'Failed to refresh appointments'));
    }
  }

  List<Appointment> _generateMockAppointments() {
    final now = DateTime.now();
    return [
      Appointment(
        id: '1',
        title: 'Doctor Appointment',
        date: now.add(const Duration(days: 1)),
        time: '09:00 AM',
        description: 'Annual checkup with Dr. Smith',
        location: 'Medical Center',
      ),
      Appointment(
        id: '2',
        title: 'Dentist Cleaning',
        date: now.add(const Duration(days: 3)),
        time: '02:30 PM',
        description: 'Regular dental cleaning',
        location: 'Dental Clinic',
      ),
      Appointment(
        id: '3',
        title: 'Hair Appointment',
        date: now.add(const Duration(days: 7)),
        time: '11:00 AM',
        description: 'Hair cut and styling',
        location: 'Beauty Salon',
      ),
    ];
  }
}
