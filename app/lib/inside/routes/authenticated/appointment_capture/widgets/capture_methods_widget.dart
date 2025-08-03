import 'package:flutter/material.dart';

import 'audio_capture_card.dart';
import 'photo_capture_card.dart';
import 'text_input_card.dart';

/// Widget that provides capture method options for appointment data
class AppointmentCapture_MethodsWidget extends StatelessWidget {
  const AppointmentCapture_MethodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '¿Cómo quieres capturar la información de tu cita?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Elige el método que te resulte más fácil',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const AppointmentCapture_AudioCaptureCard(),
          const SizedBox(height: 16),
          const AppointmentCapture_PhotoCaptureCard(),
          const SizedBox(height: 16),
          const AppointmentCapture_TextInputCard(),
        ],
      ),
    );
  }
}
