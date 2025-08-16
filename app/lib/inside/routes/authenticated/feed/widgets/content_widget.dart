import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/models/appointment.dart';
import '../../../../../shared/utils/snackbar_utils.dart';
import '../../../../blocs/appointment_edit/bloc.dart';
import '../../../../blocs/appointment_edit/events.dart';
import '../../../../blocs/feed/bloc.dart';
import '../../../../blocs/feed/event.dart';
import '../../../../blocs/feed/state.dart';
import '../../../../i18n/translations.g.dart';
import '../../../../utils/appointment_conversion.dart';
import '../../appointment_edit/widgets/edit_dialog.dart';

class Feed_ContentWidget extends StatelessWidget {
  const Feed_ContentWidget({required this.state, super.key});

  final Feed_State state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: FProgress.circularIcon());
    }

    if (state.isError && state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.theme.colors.destructive,
            ),
            const SizedBox(height: 16),
            Text(
              state.error!,
              style: context.theme.typography.base,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FButton(
              onPress: () {
                context.read<Feed_Bloc>().add(
                  const Feed_Event_LoadAppointments(),
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              state.showPastAppointments
                  ? Icons.history_outlined
                  : Icons.calendar_today_outlined,
              size: 64,
              color: context.theme.colors.mutedForeground,
            ),
            const SizedBox(height: 16),
            Text(
              state.showPastAppointments
                  ? 'No tienes citas pasadas'
                  : context.t.home.feed.empty,
              style: context.theme.typography.lg,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              state.showPastAppointments
                  ? 'Cuando tengas citas completadas aparecerán aquí'
                  : context.t.home.feed.emptySubtitle,
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<Feed_Bloc>().add(const Feed_Event_RefreshAppointments());
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: state.appointments.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final appointment = state.appointments[index];

          return Padding(
            key: ValueKey(appointment.id ?? index),
            padding: EdgeInsets.only(
              bottom: index == state.appointments.length - 1 ? 16 : 0,
            ),
            child: _AppointmentCard(
              appointment: appointment,
              showPastAppointments: state.showPastAppointments,
            ),
          );
        },
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({
    required this.appointment,
    required this.showPastAppointments,
  });

  final Model_Appointment appointment;
  final bool showPastAppointments;

  @override
  Widget build(BuildContext context) {
    // Parse the date string to DateTime if available
    DateTime? appointmentDate;
    if (appointment.date != null) {
      try {
        appointmentDate = appointment.date;
      } catch (e) {
        // Handle invalid date format
      }
    }

    final currentLocale = LocaleSettings.currentLocale.flutterLocale.toString();
    final dateFormatter = DateFormat('dd MMM, yyyy', currentLocale);
    final dayOfWeek = DateFormat('EEEE', currentLocale);

    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      showPastAppointments
                          ? context.theme.colors.muted
                          : context.theme.colors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  showPastAppointments ? Icons.history : Icons.calendar_today,
                  color:
                      showPastAppointments
                          ? context.theme.colors.primary
                          : context.theme.colors.foreground,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (appointment.specialty != null) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              appointment.specialty!,
                              style: context.theme.typography.base.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (showPastAppointments) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: context.theme.colors.muted,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Completada',
                                style: context.theme.typography.sm.copyWith(
                                  color: context.theme.colors.mutedForeground,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (appointment.doctorName != null ||
                        appointment.appointmentType != null) ...[
                      Text(
                        appointment.doctorName ??
                            appointment.appointmentType?.name ??
                            'Appointment',
                        style: context.theme.typography.sm.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      '${appointmentDate != null ? dayOfWeek.format(appointmentDate) : ''}, ${appointmentDate != null ? dateFormatter.format(appointmentDate) : appointment.date ?? 'No date'} at ${appointment.time ?? 'No time'}',
                      style: context.theme.typography.base.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (appointment.notes != null) ...[
            const SizedBox(height: 12),
            Text(appointment.notes!, style: context.theme.typography.sm),
          ],
          if (appointment.location != null || appointment.address != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap:
                  () => _openLocationInMaps(
                    appointment.address ?? appointment.location!,
                  ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: context.theme.colors.primary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (appointment.location != null)
                          Text(
                            appointment.location!,
                            style: context.theme.typography.base.copyWith(
                              color: context.theme.colors.primary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (appointment.address != null &&
                            appointment.address != appointment.location) ...[
                          if (appointment.location != null)
                            const SizedBox(height: 2),
                          Text(
                            appointment.address!,
                            style: context.theme.typography.base.copyWith(
                              color: context.theme.colors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Add edit and delete buttons for upcoming appointments only
          if (!showPastAppointments && _isUpcomingAppointment(appointment)) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FButton(
                  style: FButtonStyle.outline(),
                  onPress: () => _showDeleteConfirmDialog(context, appointment),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete_outline, size: 16),
                      SizedBox(width: 4),
                      Text('Eliminar'),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                FButton(
                  style: FButtonStyle.outline(),
                  onPress: () => _showEditDialog(context, appointment),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 4),
                      Text('Editar'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  bool _isUpcomingAppointment(Model_Appointment appointment) {
    return AppointmentConversion.isUpcoming(appointment);
  }

  Future<void> _showEditDialog(
    BuildContext context,
    Model_Appointment appointment,
  ) async {
    if (appointment.id == null) {
      SnackbarUtils.showFAlertSnackbar(
        context,
        text: 'Error: ID de cita no encontrado',
        alertStyle: FAlertStyle.destructive(),
      );
      return;
    }

    final result = await showFSheet<bool?>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: 0.9,
      builder:
          (sheetContext) => BlocProvider(
            create:
                (context) =>
                    AppointmentEdit_Bloc(appointmentsRepository: context.read())
                      ..add(
                        AppointmentEdit_Event_StartEdit(
                          appointmentId: appointment.id!,
                          appointmentData: appointment,
                        ),
                      ),
            child: AppointmentEdit_Sheet(initialData: appointment),
          ),
    );

    // Refresh the feed if the appointment was successfully updated
    if (result == true && context.mounted) {
      context.read<Feed_Bloc>().add(const Feed_Event_RefreshAppointments());

      SnackbarUtils.showFAlertSnackbar(
        context,
        text: 'Cita actualizada exitosamente',
      );
    }
  }

  Future<void> _openLocationInMaps(String location) async {
    try {
      // Create Google Maps URL with the location
      final encodedLocation = Uri.encodeComponent(location);
      final googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$encodedLocation';

      final uri = Uri.parse(googleMapsUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to opening in browser if Maps app is not available
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      }
    } catch (e) {
      // Handle error silently or show a snackbar if needed
      debugPrint('Error opening location in maps: $e');
    }
  }

  Future<void> _showDeleteConfirmDialog(
    BuildContext context,
    Model_Appointment appointment,
  ) async {
    if (appointment.id == null) {
      SnackbarUtils.showFAlertSnackbar(
        context,
        text: 'Error: ID de cita no encontrado',
        alertStyle: FAlertStyle.destructive(),
      );
      return;
    }

    // Show confirmation dialog
    final result = await showFDialog<bool?>(
      context: context,
      builder:
          (dialogContext, style, animation) => FDialog(
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: context.theme.colors.destructive,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text('¿Eliminar cita?'),
              ],
            ),
            body: const Text(
              'Esta acción no se puede deshacer. La cita será eliminada permanentemente.',
              textAlign: TextAlign.center,
            ),
            actions: [
              FButton(
                style: FButtonStyle.destructive(),
                onPress: () => Navigator.of(dialogContext).pop(true),
                child: const Text('Eliminar'),
              ),
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );

    // If user confirmed deletion, proceed with delete
    if (result == true && context.mounted) {
      await _deleteAppointment(context, appointment);
    }
  }

  Future<void> _deleteAppointment(
    BuildContext context,
    Model_Appointment appointment,
  ) async {
    // Create a bloc instance for deletion
    final deleteBloc = AppointmentEdit_Bloc(
      appointmentsRepository: context.read(),
    );

    // Start the deletion process
    deleteBloc.add(
      AppointmentEdit_Event_StartEdit(
        appointmentId: appointment.id!,
        appointmentData: appointment,
      ),
    );
    deleteBloc.add(const AppointmentEdit_Event_Delete());

    // Listen for the result
    await deleteBloc.stream.firstWhere(
      (state) => state.isDeleted || state.hasError,
    );

    if (deleteBloc.state.isDeleted) {
      // Refresh the feed
      if (context.mounted) {
        context.read<Feed_Bloc>().add(const Feed_Event_RefreshAppointments());

        SnackbarUtils.showFAlertSnackbar(
          context,
          text: 'Cita eliminada exitosamente',
        );
      }
    } else if (deleteBloc.state.hasError) {
      // Show error message
      if (context.mounted) {
        SnackbarUtils.showFAlertSnackbar(
          context,
          text: deleteBloc.state.errorMessage ?? 'Error al eliminar la cita',
          alertStyle: FAlertStyle.destructive(),
        );
      }
    }

    // Close the bloc
    await deleteBloc.close();
  }
}
