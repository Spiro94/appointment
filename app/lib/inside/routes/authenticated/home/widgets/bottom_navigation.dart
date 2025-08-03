import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../i18n/translations.g.dart';
import '../../../router.dart';
import '../../appointment_capture/page.dart';

class Home_BottomNavigation extends StatelessWidget {
  const Home_BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [Feed_Route(), Profile_Route()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAppointmentCaptureDialog(context),
            tooltip: context.t.home.navigation.appointmentCapture,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  icon: Icons.dynamic_feed,
                  label: context.t.home.navigation.feed,
                  index: 0,
                  currentIndex: tabsRouter.activeIndex,
                  onTap: () => tabsRouter.setActiveIndex(0),
                ),
                const SizedBox(width: 40), // Space for FAB
                _buildNavItem(
                  context: context,
                  icon: Icons.person,
                  label: context.t.home.navigation.profile,
                  index: 1,
                  currentIndex: tabsRouter.activeIndex,
                  onTap: () => tabsRouter.setActiveIndex(1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == currentIndex;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
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
