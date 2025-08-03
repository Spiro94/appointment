import 'package:equatable/equatable.dart';

abstract class Feed_Event extends Equatable {
  const Feed_Event();

  @override
  List<Object?> get props => [];
}

class Feed_Event_LoadAppointments extends Feed_Event {
  const Feed_Event_LoadAppointments();
}

class Feed_Event_RefreshAppointments extends Feed_Event {
  const Feed_Event_RefreshAppointments();
}
