import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';

/// Card widget for audio capture method
class AppointmentCapture_AudioCaptureCard extends StatefulWidget {
  const AppointmentCapture_AudioCaptureCard({super.key});

  @override
  State<AppointmentCapture_AudioCaptureCard> createState() =>
      _AppointmentCapture_AudioCaptureCardState();
}

class _AppointmentCapture_AudioCaptureCardState
    extends State<AppointmentCapture_AudioCaptureCard> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _audioPath;

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: FTappable(
        onPress:
            _isRecording
                ? () => _stopRecording(context)
                : () => _handleAudioCapture(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color:
                      _isRecording
                          ? Theme.of(context).colorScheme.errorContainer
                          : Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  size: 32,
                  color:
                      _isRecording
                          ? Theme.of(context).colorScheme.onErrorContainer
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isRecording ? 'Grabando...' : 'Grabar Audio',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isRecording
                          ? 'Toque para detener la grabación'
                          : 'Cuéntanos sobre su cita médica',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isRecording)
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                )
              else
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAudioCapture(BuildContext context) async {
    try {
      // Check microphone permission
      final permission = await Permission.microphone.status;
      if (permission.isDenied) {
        final result = await Permission.microphone.request();
        if (result.isDenied) {
          _showPermissionDeniedDialog(context, 'micrófono');
          return;
        }
      }

      // Check if recording is supported
      if (!(await _audioRecorder.hasPermission())) {
        _showPermissionDeniedDialog(context, 'micrófono');
        return;
      }

      // Start recording
      await _startRecording();
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error al acceder al micrófono: $e');
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      // Get temporary directory for storing the audio file
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'audio_recording_$timestamp.wav';
      final filePath = '${tempDir.path}/$fileName';

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          bitRate: 128000,
        ),
        path: filePath,
      );

      setState(() {
        _isRecording = true;
        _audioPath = filePath;
      });
    } catch (e) {
      if (mounted) {
        _showErrorSnackbar(context, 'Error al iniciar la grabación: $e');
      }
    }
  }

  Future<void> _stopRecording(BuildContext context) async {
    try {
      final path = await _audioRecorder.stop();

      setState(() {
        _isRecording = false;
      });

      // Use the stored path if the returned path is null
      final finalPath = path ?? _audioPath;

      if (finalPath != null && context.mounted) {
        // Read the audio file and convert to bytes
        final file = File(finalPath);
        if (file.existsSync()) {
          final audioBytes = await file.readAsBytes();

          // Send to bloc
          context.read<AppointmentCapture_Bloc>().add(
            AppointmentCapture_Event_CaptureFromAudio(
              audioBytes: audioBytes,
              language: 'es',
            ),
          );

          // Clean up the temporary file
          try {
            await file.delete();
          } catch (e) {
            // Ignore cleanup errors
          }
        } else {
          _showErrorSnackbar(
            context,
            'No se pudo encontrar el archivo de audio grabado',
          );
        }
      }
    } catch (e) {
      setState(() {
        _isRecording = false;
      });

      if (context.mounted) {
        _showErrorSnackbar(context, 'Error al detener la grabación: $e');
      }
    }
  }

  void _showPermissionDeniedDialog(BuildContext context, String permission) {
    showFDialog<void>(
      context: context,
      builder:
          (context, style, animation) => FDialog(
            title: const Text('Permiso necesario'),
            body: Text(
              'Necesitamos acceso al $permission para esta funcionalidad. '
              'Por favor, habilítelo en la configuración de la aplicación.',
            ),
            actions: [
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => Navigator.of(context).pop(),
                child: const Text('Entendido'),
              ),
              FButton(
                onPress: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                child: const Text('Abrir configuración'),
              ),
            ],
          ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FAlert(title: Text(message), style: FAlertStyle.destructive()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
