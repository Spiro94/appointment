import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar Cita',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AppointmentCapture_Bloc, AppointmentCapture_State>(
          builder: (context, state) {
            return AppointmentCapture_ContentWidget(state: state);
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
          ),
      child: this,
    );
  }
}
