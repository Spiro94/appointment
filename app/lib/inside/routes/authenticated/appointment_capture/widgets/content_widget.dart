import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';
import '../../../../blocs/appointment_capture/state.dart';
import 'capture_methods_widget.dart';
import 'processing_widget.dart';
import 'results_widget.dart';

/// Content widget that shows different content based on state
class AppointmentCapture_ContentWidget extends StatelessWidget {
  const AppointmentCapture_ContentWidget({super.key, required this.state});

  final AppointmentCapture_State state;

  @override
  Widget build(BuildContext context) {
    if (state.isProcessing) {
      return AppointmentCapture_ProcessingWidget(state: state);
    } else if (state.hasError) {
      return AppointmentCapture_ErrorWidget(state: state);
    } else if (state.isCaptured || state.isConfirmed) {
      return const AppointmentCapture_ResultsWidget();
    } else {
      return const AppointmentCapture_MethodsWidget();
    }
  }
}

/// Error widget for when capture fails
class AppointmentCapture_ErrorWidget extends StatelessWidget {
  const AppointmentCapture_ErrorWidget({required this.state, super.key});

  final AppointmentCapture_State state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al procesar',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              state.errorMessage ?? 'Ocurrió un error inesperado',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                FButton(
                  onPress: () {
                    context.read<AppointmentCapture_Bloc>().add(
                      const AppointmentCapture_Event_Retry(),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('Intentar de nuevo'),
                    ],
                  ),
                ),
                FButton(
                  style: FButtonStyle.outline(),
                  onPress: () {
                    context.read<AppointmentCapture_Bloc>().add(
                      const AppointmentCapture_Event_Reset(),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 8),
                      Text('Volver al inicio'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
