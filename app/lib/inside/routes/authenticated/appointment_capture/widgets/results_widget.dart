import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';
import '../../../../blocs/appointment_capture/state.dart';

/// Widget that displays an information row with icon, label, and value
class AppointmentCapture_InfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const AppointmentCapture_InfoRowWidget({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Appointment details
                FCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppointmentCapture_InfoRowWidget(
                        label: 'Doctor',
                        value: appointmentData.doctorName ?? 'No especificado',
                        icon: Icons.person,
                      ),
                      AppointmentCapture_InfoRowWidget(
                        label: 'Especialidad',
                        value: appointmentData.specialty ?? 'No especificado',
                        icon: Icons.local_hospital,
                      ),
                      AppointmentCapture_InfoRowWidget(
                        label: 'Fecha',
                        value: appointmentData.date ?? 'No especificado',
                        icon: Icons.calendar_today,
                      ),
                      AppointmentCapture_InfoRowWidget(
                        label: 'Hora',
                        value: appointmentData.time ?? 'No especificado',
                        icon: Icons.access_time,
                      ),
                      AppointmentCapture_InfoRowWidget(
                        label: 'Lugar',
                        value: appointmentData.location ?? 'No especificado',
                        icon: Icons.location_on,
                      ),
                      if (appointmentData.address != null)
                        AppointmentCapture_InfoRowWidget(
                          label: 'Dirección',
                          value: appointmentData.address!,
                          icon: Icons.place,
                        ),
                      if (appointmentData.phone != null)
                        AppointmentCapture_InfoRowWidget(
                          label: 'Teléfono',
                          value: appointmentData.phone!,
                          icon: Icons.phone,
                        ),
                      if (appointmentData.instructions != null)
                        AppointmentCapture_InfoRowWidget(
                          label: 'Instrucciones',
                          value: appointmentData.instructions!,
                          icon: Icons.info,
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Confidence indicator
                if (appointmentData.confidence != null)
                  FCard(
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
                                value: appointmentData.confidence! / 100,
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHigh,
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

                const SizedBox(height: 16),

                // Action buttons
                Column(
                  children: [
                    FButton(
                      onPress: () {
                        context.read<AppointmentCapture_Bloc>().add(
                          AppointmentCapture_Event_ConfirmData(
                            appointmentData: appointmentData,
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 8),
                          Text('Guardar cita'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
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
                          Icon(Icons.refresh),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Capturar de nuevo',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
