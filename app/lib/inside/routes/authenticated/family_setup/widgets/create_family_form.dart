import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/family_setup/bloc.dart';
import '../../../../blocs/family_setup/events.dart';
import '../../../../blocs/family_setup/state.dart';

class FamilySetup_CreateFamilyForm extends StatefulWidget {
  const FamilySetup_CreateFamilyForm({super.key});

  @override
  State<FamilySetup_CreateFamilyForm> createState() =>
      _FamilySetup_CreateFamilyFormState();
}

class _FamilySetup_CreateFamilyFormState
    extends State<FamilySetup_CreateFamilyForm> {
  final _formKey = GlobalKey<FormState>();
  final _familyNameController = TextEditingController();
  bool _hasSubmittedBefore = false;

  @override
  void dispose() {
    _familyNameController.dispose();
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
      FamilySetup_Event_CreateFamily(
        familyName: _familyNameController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilySetup_Bloc, FamilySetup_State>(
      builder: (context, state) {
        final isLoading =
            state.status == FamilySetup_Status.createFamilyInProgress;

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
                  'Crear Nueva Familia',
                  style: context.theme.typography.lg.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea una nueva familia y comparte el código de invitación con otros miembros.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 16),

                FTextFormField(
                  controller: _familyNameController,
                  label: const Text('Nombre de la Familia'),
                  hint: 'Ej: Familia García',
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El nombre de la familia es requerido';
                    }
                    if (value.trim().length < 2) {
                      return 'El nombre debe tener al menos 2 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                FButton(
                  onPress: isLoading ? null : _submitForm,
                  style: FButtonStyle.primary(),
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
                              Text('Creando...'),
                            ],
                          )
                          : const Text('Crear Familia'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
