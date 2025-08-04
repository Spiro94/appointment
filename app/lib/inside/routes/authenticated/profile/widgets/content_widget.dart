import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/profile/bloc.dart';
import '../../../../blocs/profile/event.dart';
import '../../../../blocs/profile/state.dart';

class Profile_ContentWidget extends StatelessWidget {
  const Profile_ContentWidget({required this.state, super.key});

  final Profile_State state;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
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
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(flex: 1),
        // Sign Out Button
        SizedBox(
          width: double.infinity,
          child: FButton(
            style: FButtonStyle.destructive(),
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
    );
  }
}
