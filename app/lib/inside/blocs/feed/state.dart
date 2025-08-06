import 'package:equatable/equatable.dart';

import '../../../shared/models/appointment.dart';

enum Feed_Status { initial, loading, success, error }

class Feed_State extends Equatable {
  const Feed_State({
    this.appointments = const [],
    this.status = Feed_Status.initial,
    this.error,
    this.showPastAppointments = false,
  });

  final List<Model_Appointment> appointments;
  final Feed_Status status;
  final String? error;
  final bool showPastAppointments;

  // Convenience getters for status checking
  bool get isInitial => status == Feed_Status.initial;
  bool get isLoading => status == Feed_Status.loading;
  bool get isSuccess => status == Feed_Status.success;
  bool get isError => status == Feed_Status.error;

  Feed_State copyWith({
    List<Model_Appointment>? appointments,
    Feed_Status? status,
    String? error,
    bool? showPastAppointments,
  }) {
    return Feed_State(
      appointments: appointments ?? this.appointments,
      status: status ?? this.status,
      error: error,
      showPastAppointments: showPastAppointments ?? this.showPastAppointments,
    );
  }

  @override
  List<Object?> get props => [
    appointments,
    status,
    error,
    showPastAppointments,
  ];
}
