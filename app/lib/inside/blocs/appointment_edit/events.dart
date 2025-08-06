import 'package:equatable/equatable.dart';

import '../../../shared/models/appointment.dart';

/// Events for AppointmentEdit Bloc
abstract class AppointmentEdit_Event extends Equatable {
  const AppointmentEdit_Event();

  @override
  List<Object?> get props => [];
}

/// User wants to start editing an appointment
class AppointmentEdit_Event_StartEdit extends AppointmentEdit_Event {
  const AppointmentEdit_Event_StartEdit({
    required this.appointmentId,
    required this.appointmentData,
  });

  final String appointmentId;
  final Model_Appointment appointmentData;

  @override
  List<Object> get props => [appointmentId, appointmentData];
}

/// User wants to update appointment data
class AppointmentEdit_Event_UpdateData extends AppointmentEdit_Event {
  const AppointmentEdit_Event_UpdateData({required this.appointmentData});

  final Model_Appointment appointmentData;

  @override
  List<Object> get props => [appointmentData];
}

/// User wants to save the updated appointment
class AppointmentEdit_Event_SaveChanges extends AppointmentEdit_Event {
  const AppointmentEdit_Event_SaveChanges();
}

/// User wants to cancel editing
class AppointmentEdit_Event_Cancel extends AppointmentEdit_Event {
  const AppointmentEdit_Event_Cancel();
}

/// User wants to reset the edit process
class AppointmentEdit_Event_Reset extends AppointmentEdit_Event {
  const AppointmentEdit_Event_Reset();
}
