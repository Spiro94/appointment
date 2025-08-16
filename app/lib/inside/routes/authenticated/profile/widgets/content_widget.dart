import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/profile/bloc.dart';
import '../../../../blocs/profile/event.dart';
import '../../../../blocs/profile/state.dart';
import 'family_profile_widget.dart';

class Profile_ContentWidget extends StatelessWidget {
  const Profile_ContentWidget({required this.state, super.key});

  final Profile_State state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Section
          FCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: context.theme.colors.primary,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: context.theme.colors.primaryForeground,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.isLoading)
                          const CircularProgressIndicator.adaptive()
                        else
                          Text(
                            state.userName,
                            style: context.theme.typography.lg.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Family Profile Section
          const Profile_FamilyProfileWidget(),

          const Spacer(),

          // Sign Out Button
          SizedBox(
            width: double.infinity,
            child: FButton(
              style: FButtonStyle.primary(),
              onPress:
                  state.isLoading
                      ? null
                      : () {
                        context.read<Profile_Bloc>().add(
                          const Profile_Event_SignOut(),
                        );
                      },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text('Cerrar sesión'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
