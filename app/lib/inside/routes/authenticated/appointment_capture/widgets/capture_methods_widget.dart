import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'audio_capture_card.dart';
import 'photo_capture_card.dart';
import 'text_input_card.dart';

/// Widget that provides capture method options for appointment data
class AppointmentCapture_MethodsWidget extends StatelessWidget {
  const AppointmentCapture_MethodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '¿Cómo quieres capturar la información de tu cita?',
            style: context.theme.typography.xl.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colors.foreground,
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
