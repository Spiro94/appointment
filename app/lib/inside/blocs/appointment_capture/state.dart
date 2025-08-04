import 'package:equatable/equatable.dart';

import '../../../shared/models/ai_models.dart';

/// Status for AppointmentCapture Bloc
enum AppointmentCapture_Status {
  /// Initial state - ready to capture
  initial,

  /// Currently processing (transcribing, analyzing, parsing)
  processing,

  /// Audio is being transcribed
  transcribingAudio,

  /// Image is being analyzed
  analyzingImage,

  /// Text is being parsed
  parsingText,

  /// Successfully captured appointment data - ready for review/editing
  captured,

  /// Successfully confirmed - ready to save
  confirmed,

  /// Error occurred during processing
  error,
}

/// State for AppointmentCapture Bloc
class AppointmentCapture_State extends Equatable {
  const AppointmentCapture_State({
    required this.status,
    this.appointmentData,
    this.rawText,
    this.captureMethod,
    this.confidence,
    this.errorMessage,
    this.processingStep,
  });

  final AppointmentCapture_Status status;
  final Model_AI_AppointmentData? appointmentData;
  final String? rawText; // Original transcribed/extracted text
  final String? captureMethod; // 'audio', 'image', 'text'
  final int? confidence; // Overall confidence score 0-100
  final String? errorMessage;
  final String? processingStep; // Current step being processed

  /// Initial state
  const AppointmentCapture_State.initial()
    : status = AppointmentCapture_Status.initial,
      appointmentData = null,
      rawText = null,
      captureMethod = null,
      confidence = null,
      errorMessage = null,
      processingStep = null;

  /// Copy with new values
  AppointmentCapture_State copyWith({
    AppointmentCapture_Status? status,
    Model_AI_AppointmentData? appointmentData,
    String? rawText,
    String? captureMethod,
    int? confidence,
    String? errorMessage,
    String? processingStep,
  }) {
    return AppointmentCapture_State(
      status: status ?? this.status,
      appointmentData: appointmentData ?? this.appointmentData,
      rawText: rawText ?? this.rawText,
      captureMethod: captureMethod ?? this.captureMethod,
      confidence: confidence ?? this.confidence,
      errorMessage: errorMessage ?? this.errorMessage,
      processingStep: processingStep ?? this.processingStep,
    );
  }

  /// Helper getters for UI
  bool get isInitial => status == AppointmentCapture_Status.initial;
  bool get isProcessing => [
    AppointmentCapture_Status.processing,
    AppointmentCapture_Status.transcribingAudio,
    AppointmentCapture_Status.analyzingImage,
    AppointmentCapture_Status.parsingText,
  ].contains(status);
  bool get isCaptured => status == AppointmentCapture_Status.captured;
  bool get isConfirmed => status == AppointmentCapture_Status.confirmed;
  bool get hasError => status == AppointmentCapture_Status.error;
  bool get canEdit => isCaptured || isConfirmed;
  bool get hasData => appointmentData != null;

  @override
  List<Object?> get props => [
    status,
    appointmentData,
    rawText,
    captureMethod,
    confidence,
    errorMessage,
    processingStep,
  ];
}
