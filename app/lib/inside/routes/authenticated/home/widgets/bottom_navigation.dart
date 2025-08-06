import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../router.dart';
import '../../appointment_capture/page.dart';

class Home_BottomNavigation extends StatefulWidget {
  const Home_BottomNavigation({super.key});

  @override
  State<Home_BottomNavigation> createState() => _Home_BottomNavigationState();
}

class _Home_BottomNavigationState extends State<Home_BottomNavigation> {
  final routes = [const Feed_Route(), const Profile_Route()];

  final iconList = [FIcons.house, FIcons.user];
  final activeIconList = [FIcons.house, FIcons.user];
  final routeNameList = ['Inicio', 'Perfil'];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: routes,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: context.theme.colors.primary,
            onPressed: () => _showAppointmentCaptureDialog(context),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            backgroundColor: context.theme.colors.secondary,
            itemCount: routes.length,
            height: 70,
            gapLocation: GapLocation.center,
            tabBuilder: (index, isActive) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconList[index],
                    size: 24,
                    color:
                        isActive ? context.theme.colors.primary : Colors.black,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      routeNameList[index],
                      maxLines: 1,
                      style: TextStyle(
                        color:
                            isActive
                                ? context.theme.colors.primary
                                : Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
            activeIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
          ),
        );
      },
    );
  }

  void _showAppointmentCaptureDialog(BuildContext context) {
    showFSheet<void>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: 0.7,
      builder:
          (dialogContext) => BlocProvider(
            create:
                (context) => AppointmentCapture_Bloc(
                  aiRepository: context.read(),
                  appointmentsRepository: context.read(),
                ),
            child: const AppointmentCapture_Page(),
          ),
    );
  }
}
