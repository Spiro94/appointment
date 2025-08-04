import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../blocs/profile/bloc.dart';
import '../../../blocs/profile/state.dart';
import 'widgets/content_widget.dart';

/// Page for user profile and account management
@RoutePage()
class Profile_Page extends StatelessWidget {
  const Profile_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text(
          'Perfil',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      child: BlocBuilder<Profile_Bloc, Profile_State>(
        builder: (context, state) {
          return Profile_ContentWidget(state: state);
        },
      ),
    );
  }
}
