import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../../shared/utils/snackbar_utils.dart';
import '../../../../blocs/family_setup/bloc.dart';
import '../../../../blocs/family_setup/events.dart';
import '../../../../blocs/family_setup/state.dart';

class Profile_FamilyWidget extends StatelessWidget {
  const Profile_FamilyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilySetup_Bloc, FamilySetup_State>(
      builder: (context, state) {
        if (state.family == null) {
          return const SizedBox.shrink();
        }

        final family = state.family!;
        final userProfile = state.userProfile;
        final isOwner = userProfile?.id == family.ownerId;

        return FCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.family_restroom,
                    color: context.theme.colors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Mi Familia',
                    style: context.theme.typography.lg.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isOwner) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.theme.colors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Admin',
                        style: context.theme.typography.xs.copyWith(
                          color: context.theme.colors.primaryForeground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 16),

              // Family name
              Text(
                family.name,
                style: context.theme.typography.base.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              // Invite code section
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Código de Invitación',
                          style: context.theme.typography.sm.copyWith(
                            color: context.theme.colors.mutedForeground,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.colors.muted,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            family.inviteCode,
                            style: context.theme.typography.base.copyWith(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  FButton(
                    style: FButtonStyle.outline(),
                    onPress: () {
                      Clipboard.setData(ClipboardData(text: family.inviteCode));
                      SnackbarUtils.showFAlertSnackbar(
                        context,
                        text: 'Código copiado al portapapeles',
                        backgroundColor:
                            context.theme.scaffoldStyle.backgroundColor,
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy, size: 16),
                        SizedBox(width: 4),
                        Text('Copiar'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Family members count
              if (state.familyMembers.isNotEmpty) ...[
                Text(
                  'Miembros (${state.familyMembers.length})',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ...state.familyMembers.map((member) {
                  final isCurrentUser = member.id == userProfile?.id;
                  final isMemberOwner = member.id == family.ownerId;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: context.theme.colors.mutedForeground,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            member.displayName ??
                                member.email?.split('@').first ??
                                'Usuario',
                            style: context.theme.typography.sm.copyWith(
                              fontWeight:
                                  isCurrentUser
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (isMemberOwner)
                          Text(
                            'Admin',
                            style: context.theme.typography.xs.copyWith(
                              color: context.theme.colors.mutedForeground,
                            ),
                          ),
                        if (isCurrentUser)
                          Text(
                            '(Tú)',
                            style: context.theme.typography.xs.copyWith(
                              color: context.theme.colors.mutedForeground,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],

              // Leave family button (only if not owner)
              if (!isOwner)
                FButton(
                  style: FButtonStyle.destructive(),
                  onPress: () {
                    _showLeaveFamilyDialog(context);
                  },
                  child: const Text('Salir de la Familia'),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showLeaveFamilyDialog(BuildContext context) {
    showFDialog<void>(
      context: context,
      builder:
          (dialogContext, style, animation) => FDialog(
            title: const Text('Salir de la Familia'),
            body: const Text(
              '¿Estás seguro que quieres salir de esta familia? Tendrás que unirte nuevamente usando el código de invitación.',
            ),
            actions: [
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancelar'),
              ),
              FButton(
                style: FButtonStyle.destructive(),
                onPress: () {
                  Navigator.of(dialogContext).pop();
                  context.read<FamilySetup_Bloc>().add(
                    FamilySetup_Event_LeaveFamily(),
                  );
                },
                child: const Text('Salir'),
              ),
            ],
          ),
    );
  }
}
