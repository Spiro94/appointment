import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/bottom_navigation.dart';

@RoutePage()
class Home_Page extends StatelessWidget implements AutoRouteWrapper {
  const Home_Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const Home_BottomNavigation();
  }
}
