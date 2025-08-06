import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/appointments/repository.dart';
import '../../../shared/mixins/logging.dart';
import 'events.dart';
import 'state.dart';

/// Bloc for handling appointment editing
class AppointmentEdit_Bloc
    extends Bloc<AppointmentEdit_Event, AppointmentEdit_State>
    with SharedMixin_Logging {
  AppointmentEdit_Bloc({required this.appointmentsRepository})
    : super(
        const AppointmentEdit_State(status: AppointmentEdit_Status.initial),
      ) {
    on<AppointmentEdit_Event_StartEdit>(_onStartEdit);
    on<AppointmentEdit_Event_UpdateData>(_onUpdateData);
    on<AppointmentEdit_Event_SaveChanges>(_onSaveChanges);
    on<AppointmentEdit_Event_Cancel>(_onCancel);
    on<AppointmentEdit_Event_Reset>(_onReset);
  }

  final Appointments_Repository appointmentsRepository;

  /// Handle starting edit mode
  void _onStartEdit(
    AppointmentEdit_Event_StartEdit event,
    Emitter<AppointmentEdit_State> emit,
  ) {
    log.info('Starting edit for appointment: ${event.appointmentId}');

    emit(
      state.copyWith(
        status: AppointmentEdit_Status.editing,
        appointmentId: event.appointmentId,
        originalData: event.appointmentData,
        currentData: event.appointmentData,
        errorMessage: null,
      ),
    );
  }

  /// Handle updating appointment data
  void _onUpdateData(
    AppointmentEdit_Event_UpdateData event,
    Emitter<AppointmentEdit_State> emit,
  ) {
    log.fine('Updating appointment data');

    emit(
      state.copyWith(currentData: event.appointmentData, errorMessage: null),
    );
  }

  /// Handle saving changes
  Future<void> _onSaveChanges(
    AppointmentEdit_Event_SaveChanges event,
    Emitter<AppointmentEdit_State> emit,
  ) async {
    if (state.appointmentId == null || state.currentData == null) {
      log.warning('Cannot save: missing appointment ID or data');
      emit(
        state.copyWith(
          status: AppointmentEdit_Status.error,
          errorMessage: 'Datos de cita inválidos',
        ),
      );
      return;
    }

    try {
      log.info('Saving appointment changes: ${state.appointmentId}');

      emit(
        state.copyWith(
          status: AppointmentEdit_Status.saving,
          errorMessage: null,
        ),
      );

      // Update appointment in database
      await appointmentsRepository.updateAppointment(
        appointmentId: state.appointmentId!,
        appointmentData: state.currentData!,
      );

      log.info('Appointment updated successfully');

      emit(
        state.copyWith(
          status: AppointmentEdit_Status.saved,
          originalData: state.currentData,
        ),
      );
    } catch (e) {
      log.severe('Error saving appointment changes: $e');
      emit(
        state.copyWith(
          status: AppointmentEdit_Status.error,
          errorMessage: 'Error al guardar los cambios. Intente de nuevo.',
        ),
      );
    }
  }

  /// Handle canceling edit
  void _onCancel(
    AppointmentEdit_Event_Cancel event,
    Emitter<AppointmentEdit_State> emit,
  ) {
    log.info('Canceling appointment edit');

    emit(
      state.copyWith(
        status: AppointmentEdit_Status.initial,
        currentData: state.originalData,
        errorMessage: null,
      ),
    );
  }

  /// Handle resetting the bloc
  void _onReset(
    AppointmentEdit_Event_Reset event,
    Emitter<AppointmentEdit_State> emit,
  ) {
    log.info('Resetting appointment edit bloc');

    emit(const AppointmentEdit_State(status: AppointmentEdit_Status.initial));
  }
}
