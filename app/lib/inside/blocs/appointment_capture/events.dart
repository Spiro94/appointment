import 'package:equatable/equatable.dart';

import '../../../shared/models/ai_models.dart';

/// Events for AppointmentCapture Bloc
abstract class AppointmentCapture_Event extends Equatable {
  const AppointmentCapture_Event();

  @override
  List<Object?> get props => [];
}

/// User wants to capture appointment from audio
class AppointmentCapture_Event_CaptureFromAudio
    extends AppointmentCapture_Event {
  const AppointmentCapture_Event_CaptureFromAudio({
    required this.audioBytes,
    this.language = 'es',
    this.existingData,
  });

  final List<int> audioBytes;
  final String language;
  final Model_AI_AppointmentData? existingData;

  @override
  List<Object?> get props => [audioBytes, language, existingData];
}

/// User wants to capture appointment from image/photo
class AppointmentCapture_Event_CaptureFromImage
    extends AppointmentCapture_Event {
  const AppointmentCapture_Event_CaptureFromImage({
    required this.imageBytes,
    this.existingData,
  });

  final List<int> imageBytes;
  final Model_AI_AppointmentData? existingData;

  @override
  List<Object?> get props => [imageBytes, existingData];
}

/// User wants to capture appointment from text input
class AppointmentCapture_Event_CaptureFromText
    extends AppointmentCapture_Event {
  const AppointmentCapture_Event_CaptureFromText({
    required this.text,
    this.existingData,
  });

  final String text;
  final Model_AI_AppointmentData? existingData;

  @override
  List<Object?> get props => [text, existingData];
}

/// User wants to refine/edit captured appointment data
class AppointmentCapture_Event_RefineData extends AppointmentCapture_Event {
  const AppointmentCapture_Event_RefineData({
    required this.rawText,
    required this.existingData,
  });

  final String rawText;
  final Model_AI_AppointmentData existingData;

  @override
  List<Object> get props => [rawText, existingData];
}

/// User confirms the captured appointment data
class AppointmentCapture_Event_ConfirmData extends AppointmentCapture_Event {
  const AppointmentCapture_Event_ConfirmData({required this.appointmentData});

  final Model_AI_AppointmentData appointmentData;

  @override
  List<Object> get props => [appointmentData];
}

/// User wants to clear/reset the capture process
class AppointmentCapture_Event_Reset extends AppointmentCapture_Event {
  const AppointmentCapture_Event_Reset();
}

/// User wants to retry after an error
class AppointmentCapture_Event_Retry extends AppointmentCapture_Event {
  const AppointmentCapture_Event_Retry();
}
