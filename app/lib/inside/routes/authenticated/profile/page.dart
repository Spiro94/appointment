import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../outside/repositories/auth/repository.dart';
import '../../../blocs/profile/bloc.dart';
import '../../../blocs/profile/state.dart';
import 'widgets/content_widget.dart';

/// Page for user profile and account management
@RoutePage()
class Profile_Page extends StatelessWidget implements AutoRouteWrapper {
  const Profile_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<Profile_Bloc, Profile_State>(
          builder: (context, state) {
            return Profile_ContentWidget(state: state);
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              Profile_Bloc(authRepository: context.read<Auth_Repository>()),
      child: this,
    );
  }
}
