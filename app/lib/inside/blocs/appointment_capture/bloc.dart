import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/ai/repository.dart';
import '../../../outside/repositories/appointments/repository.dart';
import '../../../shared/mixins/logging.dart';
import 'events.dart';
import 'state.dart';

/// Bloc for handling appointment capture from different sources
class AppointmentCapture_Bloc
    extends Bloc<AppointmentCapture_Event, AppointmentCapture_State>
    with SharedMixin_Logging {
  AppointmentCapture_Bloc({
    required this.aiRepository,
    required this.appointmentsRepository,
  }) : super(const AppointmentCapture_State.initial()) {
    on<AppointmentCapture_Event_CaptureFromAudio>(_onCaptureFromAudio);
    on<AppointmentCapture_Event_CaptureFromImage>(_onCaptureFromImage);
    on<AppointmentCapture_Event_CaptureFromText>(_onCaptureFromText);
    on<AppointmentCapture_Event_RefineData>(_onRefineData);
    on<AppointmentCapture_Event_ConfirmData>(_onConfirmData);
    on<AppointmentCapture_Event_Reset>(_onReset);
    on<AppointmentCapture_Event_Retry>(_onRetry);
  }

  final AI_Repository aiRepository;
  final Appointments_Repository appointmentsRepository;

  /// Handle audio capture and processing
  Future<void> _onCaptureFromAudio(
    AppointmentCapture_Event_CaptureFromAudio event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    try {
      log.info('Starting audio capture processing');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.transcribingAudio,
          captureMethod: 'audio',
          processingStep: 'Transcribiendo audio...',
          errorMessage: null,
        ),
      );

      // Convert List<int> to Uint8List
      final audioBytes = Uint8List.fromList(event.audioBytes);

      // Process audio to appointment data
      final appointmentData = await aiRepository.processAudioToAppointment(
        audioBytes: audioBytes,
        language: event.language,
        existingData: event.existingData,
      );

      log.info('Audio processing completed successfully');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.captured,
          appointmentData: appointmentData,
          confidence: appointmentData.confidence,
          processingStep: null,
        ),
      );
    } catch (e) {
      log.severe('Error processing audio: $e');
      emit(
        state.copyWith(
          status: AppointmentCapture_Status.error,
          errorMessage: _getErrorMessage(e),
          processingStep: null,
        ),
      );
    }
  }

  /// Handle image capture and processing
  Future<void> _onCaptureFromImage(
    AppointmentCapture_Event_CaptureFromImage event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    try {
      log.info('Starting image capture processing');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.analyzingImage,
          captureMethod: 'image',
          processingStep: 'Analizando imagen...',
          errorMessage: null,
        ),
      );

      // Convert List<int> to Uint8List
      final imageBytes = Uint8List.fromList(event.imageBytes);

      // Process image to appointment data
      final appointmentData = await aiRepository.processImageToAppointment(
        imageBytes: imageBytes,
        existingData: event.existingData,
      );

      log.info('Image processing completed successfully');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.captured,
          appointmentData: appointmentData,
          confidence: appointmentData.confidence,
          processingStep: null,
        ),
      );
    } catch (e) {
      log.severe('Error processing image: $e');
      emit(
        state.copyWith(
          status: AppointmentCapture_Status.error,
          errorMessage: _getErrorMessage(e),
          processingStep: null,
        ),
      );
    }
  }

  /// Handle text input and processing
  Future<void> _onCaptureFromText(
    AppointmentCapture_Event_CaptureFromText event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    try {
      log.info('Starting text capture processing');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.parsingText,
          captureMethod: 'text',
          rawText: event.text,
          processingStep: 'Analizando texto...',
          errorMessage: null,
        ),
      );

      // Parse text to appointment data
      final parseResponse = await aiRepository.parseAppointmentData(
        rawText: event.text,
        context: 'text',
        existingData: event.existingData,
      );

      log.info('Text processing completed successfully');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.captured,
          appointmentData: parseResponse.appointmentData,
          confidence: parseResponse.appointmentData.confidence,
          processingStep: null,
        ),
      );
    } catch (e) {
      log.severe('Error processing text: $e');
      emit(
        state.copyWith(
          status: AppointmentCapture_Status.error,
          errorMessage: _getErrorMessage(e),
          processingStep: null,
        ),
      );
    }
  }

  /// Handle data refinement
  Future<void> _onRefineData(
    AppointmentCapture_Event_RefineData event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    try {
      log.info('Starting data refinement');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.parsingText,
          processingStep: 'Refinando datos...',
          errorMessage: null,
        ),
      );

      // Parse with existing data for refinement
      final parseResponse = await aiRepository.parseAppointmentData(
        rawText: event.rawText,
        context: state.captureMethod ?? 'text',
        existingData: event.existingData,
      );

      log.info('Data refinement completed successfully');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.captured,
          appointmentData: parseResponse.appointmentData,
          confidence: parseResponse.appointmentData.confidence,
          processingStep: null,
        ),
      );
    } catch (e) {
      log.severe('Error refining data: $e');
      emit(
        state.copyWith(
          status: AppointmentCapture_Status.error,
          errorMessage: _getErrorMessage(e),
          processingStep: null,
        ),
      );
    }
  }

  /// Handle data confirmation
  Future<void> _onConfirmData(
    AppointmentCapture_Event_ConfirmData event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    try {
      log.info('Appointment data confirmed, saving to database');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.processing,
          processingStep: 'Guardando cita...',
          errorMessage: null,
        ),
      );

      // Save appointment to database
      await appointmentsRepository.saveAppointment(
        appointmentData: event.appointmentData,
        captureMethod: state.captureMethod ?? 'manual',
        rawText: state.rawText,
      );

      log.info('Appointment saved successfully');

      emit(
        state.copyWith(
          status: AppointmentCapture_Status.saved,
          appointmentData: event.appointmentData,
          processingStep: null,
          errorMessage: null,
        ),
      );
    } catch (e) {
      log.severe('Error saving appointment: $e');
      emit(
        state.copyWith(
          status: AppointmentCapture_Status.error,
          errorMessage: 'Error al guardar la cita. Intente de nuevo.',
          processingStep: null,
        ),
      );
    }
  }

  /// Handle reset
  Future<void> _onReset(
    AppointmentCapture_Event_Reset event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    log.info('Resetting appointment capture');
    emit(const AppointmentCapture_State.initial());
  }

  /// Handle retry
  Future<void> _onRetry(
    AppointmentCapture_Event_Retry event,
    Emitter<AppointmentCapture_State> emit,
  ) async {
    log.info('Retrying appointment capture');
    emit(
      state.copyWith(
        status: AppointmentCapture_Status.initial,
        errorMessage: null,
        processingStep: null,
      ),
    );
  }

  /// Convert exception to user-friendly error message
  String _getErrorMessage(Object error) {
    final errorStr = error.toString();

    if (errorStr.contains('No response data')) {
      return 'Error de conexión. Verifique su conexión a internet.';
    } else if (errorStr.contains('OpenAI API key')) {
      return 'Error de configuración. Contacte al administrador.';
    } else if (errorStr.contains('Failed to transcribe')) {
      return 'No se pudo procesar el audio. Intente grabar de nuevo.';
    } else if (errorStr.contains('Failed to analyze image')) {
      return 'No se pudo analizar la imagen. Intente con otra foto más clara.';
    } else if (errorStr.contains('Failed to parse')) {
      return 'No se pudo interpretar la información. Verifique el texto ingresado.';
    } else {
      return 'Ocurrió un error inesperado. Intente de nuevo.';
    }
  }
}
