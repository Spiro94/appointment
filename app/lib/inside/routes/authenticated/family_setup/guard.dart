import 'package:auto_route/auto_route.dart';

import '../../../../shared/mixins/logging.dart';
import '../../../blocs/family_setup/bloc.dart';
import '../../router.dart';

class FamilySetup_Guard extends AutoRouteGuard with SharedMixin_Logging {
  FamilySetup_Guard({required this.familySetupBloc});

  final FamilySetup_Bloc familySetupBloc;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = familySetupBloc.state;

    // If user needs family setup, redirect to family setup
    if (state.needsSetup) {
      log.info('User needs family setup, redirecting');
      router.root.replaceAll([FamilySetup_Route()]);
      return;
    }

    // If user has completed setup, allow navigation
    resolver.next();
  }
}
