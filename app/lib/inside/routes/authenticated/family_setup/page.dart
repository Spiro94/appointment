import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../shared/utils/snackbar_utils.dart';
import '../../../blocs/family_setup/bloc.dart';
import '../../../blocs/family_setup/state.dart';
import '../../router.dart';
import 'widgets/create_family_form.dart';
import 'widgets/join_family_form.dart';
import 'widgets/loading_widget.dart';

@RoutePage()
class FamilySetup_Page extends StatelessWidget {
  const FamilySetup_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: const FHeader(title: Text('Configurar Familia')),
      child: BlocConsumer<FamilySetup_Bloc, FamilySetup_State>(
        listener: (context, state) {
          if (state.status == FamilySetup_Status.createFamilySuccess ||
              state.status == FamilySetup_Status.joinFamilySuccess) {
            // Family setup completed, navigate to home
            context.router.navigate(const Home_Route());
          }

          // Show error messages
          if (state.errorMessage != null &&
              (state.status == FamilySetup_Status.createFamilyError ||
                  state.status == FamilySetup_Status.joinFamilyError)) {
            SnackbarUtils.showFAlertSnackbar(
              context,
              text: state.errorMessage!,
              alertStyle: FAlertStyle.destructive(),
              backgroundColor: context.theme.scaffoldStyle.backgroundColor,
            );
          }
        },
        builder: (context, state) {
          if (state.status == FamilySetup_Status.loading) {
            return const FamilySetup_LoadingWidget();
          }

          if (state.status == FamilySetup_Status.setupCompleted) {
            // Setup is complete, navigate to home
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.router.navigate(const Home_Route());
            });
            return const FamilySetup_LoadingWidget();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome message
                  FCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Bienvenido!',
                          style: context.theme.typography.xl2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Para usar la aplicación, necesitas pertenecer a una familia. Puedes crear una nueva familia o unirte a una existente usando un código de invitación.',
                          style: context.theme.typography.base,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Create family section
                  const FamilySetup_CreateFamilyForm(),

                  const SizedBox(height: 24),

                  // Divider with "OR"
                  Row(
                    children: [
                      const Expanded(child: FDivider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'O',
                          style: context.theme.typography.sm.copyWith(
                            color: context.theme.colors.mutedForeground,
                          ),
                        ),
                      ),
                      const Expanded(child: FDivider()),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Join family section
                  const FamilySetup_JoinFamilyForm(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
