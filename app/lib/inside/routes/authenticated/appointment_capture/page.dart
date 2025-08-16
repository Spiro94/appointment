import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../outside/repositories/ai/repository.dart';
import '../../../../outside/repositories/appointments/repository.dart';
import '../../../../shared/utils/snackbar_utils.dart';
import '../../../blocs/appointment_capture/bloc.dart';
import '../../../blocs/appointment_capture/state.dart';
import '../../../blocs/feed/bloc.dart';
import '../../../blocs/feed/event.dart';
import 'widgets/content_widget.dart';

/// Page for capturing appointment data from various sources
@RoutePage()
class AppointmentCapture_Page extends StatelessWidget
    implements AutoRouteWrapper {
  const AppointmentCapture_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: SafeArea(
        child: BlocConsumer<AppointmentCapture_Bloc, AppointmentCapture_State>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: AppointmentCapture_ContentWidget(state: state),
            );
          },
          listener: (context, state) {
            if (state.status == AppointmentCapture_Status.saved) {
              context.maybePop();
              context.read<Feed_Bloc>().add(
                const Feed_Event_RefreshAppointments(),
              );
              SnackbarUtils.showFAlertSnackbar(
                context,
                text: 'Cita médica guardada exitosamente',
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AppointmentCapture_Bloc(
            aiRepository: context.read<AI_Repository>(),
            appointmentsRepository: context.read<Appointments_Repository>(),
          ),
      child: this,
    );
  }
}
