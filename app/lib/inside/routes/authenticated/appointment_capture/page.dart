import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../outside/repositories/ai/repository.dart';
import '../../../blocs/appointment_capture/bloc.dart';
import '../../../blocs/appointment_capture/state.dart';
import 'widgets/content_widget.dart';

/// Page for capturing appointment data from various sources
@RoutePage()
class AppointmentCapture_Page extends StatelessWidget
    implements AutoRouteWrapper {
  const AppointmentCapture_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: FScaffold(
        child: SafeArea(
          child: BlocBuilder<AppointmentCapture_Bloc, AppointmentCapture_State>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: AppointmentCapture_ContentWidget(state: state),
              );
            },
          ),
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
          ),
      child: this,
    );
  }
}
