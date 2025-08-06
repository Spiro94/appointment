import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Header widget for appointment capture page
class AppointmentCapture_HeaderWidget extends StatelessWidget {
  const AppointmentCapture_HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.medical_information,
                  size: 32,
                  color: context.theme.colors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '¿Cómo quiere registrar su cita?',
                    style: context.theme.typography.lg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Puede grabar un audio, tomar una foto de la orden médica, '
              'o escribir la información directamente.',
              style: context.theme.typography.base.copyWith(
                color: context.theme.colors.mutedForeground,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
