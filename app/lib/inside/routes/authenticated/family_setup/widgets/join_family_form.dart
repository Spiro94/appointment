import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../../shared/utils/text_formatters.dart';
import '../../../../blocs/family_setup/bloc.dart';
import '../../../../blocs/family_setup/events.dart';
import '../../../../blocs/family_setup/state.dart';

class FamilySetup_JoinFamilyForm extends StatefulWidget {
  const FamilySetup_JoinFamilyForm({super.key});

  @override
  State<FamilySetup_JoinFamilyForm> createState() =>
      _FamilySetup_JoinFamilyFormState();
}

class _FamilySetup_JoinFamilyFormState
    extends State<FamilySetup_JoinFamilyForm> {
  final _formKey = GlobalKey<FormState>();
  final _inviteCodeController = TextEditingController();
  bool _hasSubmittedBefore = false;

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _hasSubmittedBefore = true;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<FamilySetup_Bloc>().add(
      FamilySetup_Event_JoinFamily(
        inviteCode: _inviteCodeController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilySetup_Bloc, FamilySetup_State>(
      builder: (context, state) {
        final isLoading =
            state.status == FamilySetup_Status.joinFamilyInProgress;

        return FCard(
          child: Form(
            key: _formKey,
            autovalidateMode:
                _hasSubmittedBefore
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Unirse a una Familia',
                  style: context.theme.typography.lg.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ingresa el código de invitación de 6 caracteres para unirte a una familia existente.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 16),

                FTextFormField(
                  controller: _inviteCodeController,
                  label: const Text('Código de Invitación'),
                  hint: 'ABCDEF',
                  enabled: !isLoading,
                  maxLength: 6,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El código de invitación es requerido';
                    }
                    if (value.trim().length != 6) {
                      return 'El código debe tener exactamente 6 caracteres';
                    }
                    if (!RegExp(
                      r'^[A-Z0-9]{6}$',
                    ).hasMatch(value.trim().toUpperCase())) {
                      return 'El código solo puede contener letras y números';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                FButton(
                  onPress: isLoading ? null : _submitForm,
                  style: FButtonStyle.outline(),
                  child:
                      isLoading
                          ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text('Uniéndose...'),
                            ],
                          )
                          : const Text('Unirse a Familia'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
