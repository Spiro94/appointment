import 'package:flutter/material.dart';

import '../../../../blocs/appointment_capture/state.dart';

/// Widget shown while processing appointment capture
class AppointmentCapture_ProcessingWidget extends StatelessWidget {
  const AppointmentCapture_ProcessingWidget({super.key, required this.state});

  final AppointmentCapture_State state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _getTitle(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  _getDescription(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (state.processingStep != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      state.processingStep!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                // Accessibility: Add semantic label for screen readers
                Semantics(
                  label: _getAccessibilityLabel(),
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (state.status) {
      case AppointmentCapture_Status.transcribingAudio:
        return 'Transcribiendo audio...';
      case AppointmentCapture_Status.analyzingImage:
        return 'Analizando imagen...';
      case AppointmentCapture_Status.parsingText:
        return 'Procesando texto...';
      case AppointmentCapture_Status.initial:
      case AppointmentCapture_Status.processing:
      case AppointmentCapture_Status.captured:
      case AppointmentCapture_Status.confirmed:
      case AppointmentCapture_Status.error:
      case AppointmentCapture_Status.saved:
        return 'Procesando información de cita médica...';
    }
  }

  String _getDescription() {
    switch (state.status) {
      case AppointmentCapture_Status.transcribingAudio:
        return 'Convirtiendo el audio en texto para su análisis.';
      case AppointmentCapture_Status.analyzingImage:
        return 'Extrayendo información de la imagen capturada.';
      case AppointmentCapture_Status.parsingText:
        return 'Analizando el texto para extraer los datos de la cita médica.';
      case AppointmentCapture_Status.initial:
      case AppointmentCapture_Status.processing:
      case AppointmentCapture_Status.captured:
      case AppointmentCapture_Status.confirmed:
      case AppointmentCapture_Status.error:
      case AppointmentCapture_Status.saved:
        return 'Estamos analizando la información para extraer '
            'los datos de su cita médica. Esto puede tomar unos momentos.';
    }
  }

  String _getAccessibilityLabel() {
    switch (state.status) {
      case AppointmentCapture_Status.transcribingAudio:
        return 'Transcribiendo audio, por favor espere';
      case AppointmentCapture_Status.analyzingImage:
        return 'Analizando imagen, por favor espere';
      case AppointmentCapture_Status.parsingText:
        return 'Procesando texto de cita médica, por favor espere';
      case AppointmentCapture_Status.initial:
      case AppointmentCapture_Status.processing:
      case AppointmentCapture_Status.captured:
      case AppointmentCapture_Status.confirmed:
      case AppointmentCapture_Status.error:
      case AppointmentCapture_Status.saved:
        return 'Procesando información de cita médica, por favor espere';
    }
  }
}
