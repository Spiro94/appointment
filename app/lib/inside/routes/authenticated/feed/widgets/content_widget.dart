import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/models/appointment.dart';
import '../../../../blocs/feed/bloc.dart';
import '../../../../blocs/feed/event.dart';
import '../../../../blocs/feed/state.dart';
import '../../../../i18n/translations.g.dart';

class Feed_ContentWidget extends StatelessWidget {
  const Feed_ContentWidget({required this.state, super.key});

  final Feed_State state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (state.isError && state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              state.error!,
              style: Theme.of(context).textTheme.titleMedium,
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
              Icons.calendar_today_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(height: 16),
            Text(
              context.t.home.feed.empty,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.t.home.feed.emptySubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final appointment = state.appointments[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == state.appointments.length - 1 ? 16 : 0,
            ),
            child: _AppointmentCard(appointment: appointment),
          );
        },
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({required this.appointment});

  final Model_Appointment appointment;

  @override
  Widget build(BuildContext context) {
    // Parse the date string to DateTime if available
    DateTime? appointmentDate;
    if (appointment.date != null) {
      try {
        appointmentDate = DateTime.parse(appointment.date!);
      } catch (e) {
        // Handle invalid date format
      }
    }

    final dateFormatter = DateFormat('dd MMM, yyyy');
    final dayOfWeek = DateFormat('EEEE');

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (appointment.specialty != null) ...[
                        Text(
                          appointment.specialty!,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                      ],
                      if (appointment.doctorName != null ||
                          appointment.appointmentType != null) ...[
                        Text(
                          appointment.doctorName ??
                              appointment.appointmentType ??
                              'Appointment',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        '${appointmentDate != null ? dayOfWeek.format(appointmentDate) : ''}, ${appointmentDate != null ? dateFormatter.format(appointmentDate) : appointment.date ?? 'No date'} at ${appointment.time ?? 'No time'}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (appointment.notes != null) ...[
              const SizedBox(height: 12),
              Text(
                appointment.notes!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (appointment.location != null ||
                appointment.address != null) ...[
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (appointment.location != null)
                            Text(
                              appointment.location!,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
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
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
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
          ],
        ),
      ),
    );
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
}
