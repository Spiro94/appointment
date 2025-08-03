import 'package:equatable/equatable.dart';

// This would typically come from a shared models directory
class Appointment {
  const Appointment({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    this.description,
    this.location,
  });

  final String id;
  final String title;
  final DateTime date;
  final String time;
  final String? description;
  final String? location;
}

class Feed_State extends Equatable {
  const Feed_State({
    this.appointments = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Appointment> appointments;
  final bool isLoading;
  final String? error;

  Feed_State copyWith({
    List<Appointment>? appointments,
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
