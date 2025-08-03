import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';

/// Card widget for audio capture method
class AppointmentCapture_AudioCaptureCard extends StatelessWidget {
  const AppointmentCapture_AudioCaptureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _handleAudioCapture(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.mic,
                  size: 32,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Grabar Audio',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cuéntanos sobre su cita médica',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
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

      // For now, simulate audio capture
      // TODO: Implement actual audio recording functionality
      if (context.mounted) {
        // Simulating audio bytes for testing
        final simulatedAudioBytes = <int>[]; // Empty for now
        context.read<AppointmentCapture_Bloc>().add(
          AppointmentCapture_Event_CaptureFromAudio(
            audioBytes: simulatedAudioBytes,
            language: 'es',
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error al acceder al micrófono: $e');
      }
    }
  }

  void _showPermissionDeniedDialog(BuildContext context, String permission) {
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Permiso necesario'),
            content: Text(
              'Necesitamos acceso al $permission para esta funcionalidad. '
              'Por favor, habilítelo en la configuración de la aplicación.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Entendido'),
              ),
              ElevatedButton(
                onPressed: () {
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
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
