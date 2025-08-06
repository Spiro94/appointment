import 'package:equatable/equatable.dart';

import '../../../shared/models/appointment.dart';

/// Status for AppointmentEdit Bloc
enum AppointmentEdit_Status {
  /// Initial state - not editing
  initial,

  /// Currently editing appointment data
  editing,

  /// Currently saving changes
  saving,

  /// Changes saved successfully
  saved,

  /// Error occurred during editing or saving
  error,
}

/// State for AppointmentEdit Bloc
class AppointmentEdit_State extends Equatable {
  const AppointmentEdit_State({
    required this.status,
    this.appointmentId,
    this.originalData,
    this.currentData,
    this.errorMessage,
  });

  final AppointmentEdit_Status status;
  final String? appointmentId;
  final Model_Appointment? originalData;
  final Model_Appointment? currentData;
  final String? errorMessage;

  /// Helper getters for UI
  bool get isInitial => status == AppointmentEdit_Status.initial;
  bool get isEditing => status == AppointmentEdit_Status.editing;
  bool get isSaving => status == AppointmentEdit_Status.saving;
  bool get isSaved => status == AppointmentEdit_Status.saved;
  bool get hasError => status == AppointmentEdit_Status.error;
  bool get hasChanges => originalData != currentData;

  AppointmentEdit_State copyWith({
    AppointmentEdit_Status? status,
    String? appointmentId,
    Model_Appointment? originalData,
    Model_Appointment? currentData,
    String? errorMessage,
  }) {
    return AppointmentEdit_State(
      status: status ?? this.status,
      appointmentId: appointmentId ?? this.appointmentId,
      originalData: originalData ?? this.originalData,
      currentData: currentData ?? this.currentData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    appointmentId,
    originalData,
    currentData,
    errorMessage,
  ];
}
