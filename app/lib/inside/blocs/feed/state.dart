import 'package:equatable/equatable.dart';

import '../../../shared/models/appointment.dart';

class Feed_State extends Equatable {
  const Feed_State({
    this.appointments = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Model_Appointment> appointments;
  final bool isLoading;
  final String? error;

  Feed_State copyWith({
    List<Model_Appointment>? appointments,
    bool? isLoading,
    String? error,
  }) {
    return Feed_State(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [appointments, isLoading, error];
}
