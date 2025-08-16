import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../../shared/utils/snackbar_utils.dart';
import '../../../../blocs/family_setup/bloc.dart';
import '../../../../blocs/family_setup/events.dart';
import '../../../../blocs/family_setup/state.dart';

class Profile_FamilyProfileWidget extends StatelessWidget {
  const Profile_FamilyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilySetup_Bloc, FamilySetup_State>(
      builder: (context, state) {
        if (!state.hasFamily || state.family == null) {
          return const SizedBox.shrink();
        }

        final family = state.family!;
        final userProfile = state.userProfile;
        final isOwner = userProfile?.id == family.ownerId;

        return Column(
          children: [
            // Family Info Section
            FCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        size: 24,
                        color: context.theme.colors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              family.name,
                              style: context.theme.typography.lg.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Código: ${family.inviteCode}',
                              style: context.theme.typography.sm.copyWith(
                                color: context.theme.colors.mutedForeground,
                              ),
                            ),
                            if (isOwner)
                              Text(
                                'Administrador',
                                style: context.theme.typography.xs.copyWith(
                                  color: context.theme.colors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Family Members Section
                  if (state.familyMembers.isNotEmpty) ...[
                    Text(
                      'Miembros de la Familia',
                      style: context.theme.typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...state.familyMembers.map((member) {
                      final isCurrentUser = member.id == userProfile?.id;
                      final isMemberOwner = member.id == family.ownerId;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isCurrentUser
                                  ? context.theme.colors.primary.withOpacity(
                                    0.1,
                                  )
                                  : context.theme.colors.muted,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: context.theme.colors.primary,
                              child: Text(
                                (member.displayName?.isNotEmpty == true
                                        ? member.displayName![0]
                                        : member.email?[0] ?? 'U')
                                    .toUpperCase(),
                                style: context.theme.typography.sm.copyWith(
                                  color: context.theme.colors.primaryForeground,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.displayName?.isNotEmpty == true
                                        ? member.displayName!
                                        : member.email ?? 'Usuario',
                                    style: context.theme.typography.sm.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (member.email != null &&
                                      member.displayName?.isNotEmpty == true)
                                    Text(
                                      member.email!,
                                      style: context.theme.typography.xs
                                          .copyWith(
                                            color:
                                                context
                                                    .theme
                                                    .colors
                                                    .mutedForeground,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            if (isMemberOwner)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: context.theme.colors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Admin',
                                  style: context.theme.typography.xs.copyWith(
                                    color:
                                        context.theme.colors.primaryForeground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else if (isCurrentUser)
                              Text(
                                'Tú',
                                style: context.theme.typography.xs.copyWith(
                                  color: context.theme.colors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Actions Section
            FCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Configuración de Familia',
                    style: context.theme.typography.base.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Share invite code button
                  FButton(
                    style: FButtonStyle.outline(),
                    onPress: () => _shareInviteCode(context, family.inviteCode),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share, size: 16),
                        SizedBox(width: 8),
                        Text('Compartir Código de Invitación'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Leave family button (only if not owner)
                  if (!isOwner)
                    FButton(
                      style: FButtonStyle.outline(),
                      onPress: () => _showLeaveDialog(context),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.exit_to_app, size: 16),
                          SizedBox(width: 8),
                          Text('Abandonar Familia'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _shareInviteCode(BuildContext context, String inviteCode) {
    // Copy to clipboard
    // You could also use share_plus package here
    SnackbarUtils.showFAlertSnackbar(
      context,
      text: 'Código copiado: $inviteCode',
      backgroundColor: context.theme.scaffoldStyle.backgroundColor,
    );
  }

  void _showLeaveDialog(BuildContext context) {
    showFDialog<void>(
      context: context,
      builder:
          (context, style, animation) => FDialog(
            title: const Text('Abandonar Familia'),
            body: const Text(
              '¿Estás seguro de que quieres abandonar esta familia? Esta acción no se puede deshacer.',
            ),
            actions: [
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              FButton(
                onPress: () {
                  Navigator.of(context).pop();
                  context.read<FamilySetup_Bloc>().add(
                    FamilySetup_Event_LeaveFamily(),
                  );
                },
                child: const Text('Abandonar'),
              ),
            ],
          ),
    );
  }
}
