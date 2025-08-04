import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/mixins/logging.dart';
import '../../../shared/models/appointment.dart';
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

  List<Model_Appointment> _generateMockAppointments() {
    final now = DateTime.now();
    return [
      Model_Appointment(
        doctorName: 'Dr. Smith',
        specialty: 'General Medicine',
        date:
            '${now.add(const Duration(days: 1)).year}-${now.add(const Duration(days: 1)).month.toString().padLeft(2, '0')}-${now.add(const Duration(days: 1)).day.toString().padLeft(2, '0')}',
        time: '09:00',
        location: 'Medical Center',
        appointmentType: 'Annual checkup',
        notes: 'Annual checkup with Dr. Smith',
      ),
      Model_Appointment(
        doctorName: 'Dr. Johnson',
        specialty: 'Dentistry',
        date:
            '${now.add(const Duration(days: 3)).year}-${now.add(const Duration(days: 3)).month.toString().padLeft(2, '0')}-${now.add(const Duration(days: 3)).day.toString().padLeft(2, '0')}',
        time: '14:30',
        location: 'Dental Clinic',
        appointmentType: 'Cleaning',
        notes: 'Regular dental cleaning',
      ),
      Model_Appointment(
        doctorName: 'Stylist Maria',
        specialty: 'Hair Styling',
        date:
            '${now.add(const Duration(days: 7)).year}-${now.add(const Duration(days: 7)).month.toString().padLeft(2, '0')}-${now.add(const Duration(days: 7)).day.toString().padLeft(2, '0')}',
        time: '11:00',
        location: 'Beauty Salon',
        appointmentType: 'Hair cut and styling',
        notes: 'Hair cut and styling',
      ),
    ];
  }
}
