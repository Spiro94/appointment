import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';
import '../../../../blocs/appointment_capture/state.dart';

/// Widget that shows captured appointment results
class AppointmentCapture_ResultsWidget extends StatelessWidget {
  const AppointmentCapture_ResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCapture_Bloc, AppointmentCapture_State>(
      builder: (context, state) {
        final appointmentData = state.appointmentData;

        if (appointmentData == null) {
          return const Center(child: Text('No hay datos capturados'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 32,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Información capturada',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Appointment details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        context,
                        'Doctor',
                        appointmentData.doctorName ?? 'No especificado',
                        Icons.person,
                      ),
                      _buildInfoRow(
                        context,
                        'Especialidad',
                        appointmentData.specialty ?? 'No especificado',
                        Icons.local_hospital,
                      ),
                      _buildInfoRow(
                        context,
                        'Fecha',
                        appointmentData.date ?? 'No especificado',
                        Icons.calendar_today,
                      ),
                      _buildInfoRow(
                        context,
                        'Hora',
                        appointmentData.time ?? 'No especificado',
                        Icons.access_time,
                      ),
                      _buildInfoRow(
                        context,
                        'Lugar',
                        appointmentData.location ?? 'No especificado',
                        Icons.location_on,
                      ),
                      if (appointmentData.address != null)
                        _buildInfoRow(
                          context,
                          'Dirección',
                          appointmentData.address!,
                          Icons.place,
                        ),
                      if (appointmentData.phone != null)
                        _buildInfoRow(
                          context,
                          'Teléfono',
                          appointmentData.phone!,
                          Icons.phone,
                        ),
                      if (appointmentData.instructions != null)
                        _buildInfoRow(
                          context,
                          'Instrucciones',
                          appointmentData.instructions!,
                          Icons.info,
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Confidence indicator
              if (appointmentData.confidence != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Confianza de la información',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: (appointmentData.confidence! / 100),
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceVariant,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${appointmentData.confidence}%',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<AppointmentCapture_Bloc>().add(
                          const AppointmentCapture_Event_Reset(),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Capturar otra vez'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<AppointmentCapture_Bloc>().add(
                          AppointmentCapture_Event_ConfirmData(
                            appointmentData: appointmentData,
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar cita'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
