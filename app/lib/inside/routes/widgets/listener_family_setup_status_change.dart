import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/family_setup/bloc.dart';
import '../../blocs/family_setup/state.dart';
import '../router.dart';

class Routes_Listener_FamilySetupStatusChange extends StatelessWidget {
  const Routes_Listener_FamilySetupStatusChange({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FamilySetup_Bloc, FamilySetup_State>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final currentRouteName = context.router.current.name;

        // Only handle status changes after loading is complete
        switch (state.status) {
          case FamilySetup_Status.setupRequired:
            // User needs family setup and is not already on family setup page
            if (currentRouteName != 'FamilySetup_Route') {
              context.router.navigate(const FamilySetup_Route());
            }
          case FamilySetup_Status.setupCompleted:
            // User has completed setup, navigate to home if on family setup page
            if (currentRouteName == 'FamilySetup_Route') {
              context.router.navigate(const Home_Route());
            }
          case FamilySetup_Status.createFamilySuccess:
          case FamilySetup_Status.joinFamilySuccess:
            // Family setup just completed, navigate to home
            context.router.navigate(const Home_Route());
          case FamilySetup_Status.idle:
          case FamilySetup_Status.loading:
          case FamilySetup_Status.createFamilyInProgress:
          case FamilySetup_Status.createFamilyError:
          case FamilySetup_Status.joinFamilyInProgress:
          case FamilySetup_Status.joinFamilyError:
          case FamilySetup_Status.loadFamilyInProgress:
          case FamilySetup_Status.loadFamilySuccess:
          case FamilySetup_Status.loadFamilyError:
          case FamilySetup_Status.leaveFamilyInProgress:
          case FamilySetup_Status.leaveFamilySuccess:
          case FamilySetup_Status.leaveFamilyError:
          case FamilySetup_Status.updateDisplayNameInProgress:
          case FamilySetup_Status.updateDisplayNameSuccess:
          case FamilySetup_Status.updateDisplayNameError:
            // Do nothing for these statuses
            break;
        }
      },
      child: child,
    );
  }
}
