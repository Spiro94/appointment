import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/appointments/repository.dart';
import '../../../outside/repositories/auth/repository.dart';
import '../../blocs/feed/bloc.dart';
import '../../blocs/profile/bloc.dart';
import '../widgets/listener_auth_status_change.dart';
import '../widgets/listener_supabase_auth_change.dart';

@RoutePage(name: 'Authenticated_Routes')
class Authenticated_Router extends StatelessWidget {
  const Authenticated_Router({super.key});

  @override
  Widget build(BuildContext context) {
    return Routes_Listener_SupabaseAuthChange(
      child: Routes_Listener_AuthStatusChange(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create:
                  (context) => Profile_Bloc(
                    authRepository: context.read<Auth_Repository>(),
                  ),
            ),
            BlocProvider(
              lazy: false,
              create:
                  (context) => Feed_Bloc(
                    appointmentsRepository:
                        context.read<Appointments_Repository>(),
                  ),
            ),
          ],
          child: const AutoRouter(),
        ),
      ),
    );
  }
}
