import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../i18n/translations.g.dart';
import '../../../../util/breakpoints.dart';
import '../../../router.dart';
import '../../../widgets/scaffold.dart';
import '../../appointment_capture/page.dart';

class Home_BottomNavigation extends StatelessWidget {
  const Home_BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        children: [
          AutoTabsRouter(
            routes: const [Feed_Route(), Profile_Route()],
            builder: (context, child) {
              final tabsRouter = AutoTabsRouter.of(context);

              return Routes_Scaffold(
                breakpointType: InsideUtil_BreakpointType.constrained,
                scaffold: FScaffold(
                  footer: FBottomNavigationBar(
                    index:
                        tabsRouter.activeIndex == 0
                            ? 0
                            : 2, // Map actual index to navigation index
                    onChange: (index) {
                      // Skip the middle placeholder (index 1) and map to actual routes
                      if (index == 0) {
                        tabsRouter.setActiveIndex(0); // Feed
                      } else if (index == 2) {
                        tabsRouter.setActiveIndex(1); // Profile
                      }
                      // Index 1 is ignored as it's the placeholder
                    },
                    children: [
                      FBottomNavigationBarItem(
                        icon: const Icon(Icons.dynamic_feed),
                        label: Text(context.t.home.navigation.feed),
                      ),
                      // Invisible placeholder for the floating action button
                      const FBottomNavigationBarItem(
                        icon: SizedBox(
                          width: 24,
                          height: 24,
                        ), // Invisible placeholder
                        label: SizedBox.shrink(), // No label
                      ),
                      FBottomNavigationBarItem(
                        icon: const Icon(Icons.person),
                        label: Text(context.t.home.navigation.profile),
                      ),
                    ],
                  ),
                  child: child,
                ),
              );
            },
          ),
          // Floating action button for appointment capture
          Positioned(
            bottom: 24,
            right: MediaQuery.sizeOf(context).width / 2 - 28,
            left: MediaQuery.sizeOf(context).width / 2 - 28,
            child: FButton(
              onPress: () => _showAppointmentCaptureDialog(context),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _showAppointmentCaptureDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => Dialog.fullscreen(
            child: BlocProvider(
              create:
                  (context) =>
                      AppointmentCapture_Bloc(aiRepository: context.read()),
              child: const AppointmentCapture_Page(),
            ),
          ),
    );
  }
}
