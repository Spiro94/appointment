import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';

/// Card widget for text input method
class AppointmentCapture_TextInputCard extends StatelessWidget {
  const AppointmentCapture_TextInputCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: FTappable(
        onPress: () => _handleTextInput(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.edit,
                  size: 32,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Escribir',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Escribe los detalles de la cita',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTextInput(BuildContext context) {
    showFDialog<void>(
      context: context,
      builder:
          (fContext, style, animation) => BlocProvider.value(
            value: context.read<AppointmentCapture_Bloc>(),
            child: const AppointmentCapture_TextInputDialog(),
          ),
    );
  }
}

/// Dialog widget for text input
class AppointmentCapture_TextInputDialog extends StatefulWidget {
  const AppointmentCapture_TextInputDialog({super.key});

  @override
  State<AppointmentCapture_TextInputDialog> createState() =>
      _AppointmentCapture_TextInputDialogState();
}

class _AppointmentCapture_TextInputDialogState
    extends State<AppointmentCapture_TextInputDialog> {
  final TextEditingController _textController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: const Text('Escribir detalles de la cita'),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Escribe los detalles de tu cita médica (fecha, hora, doctor, etc.):',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FTextField(
              controller: _textController,
              maxLines: 6,
              autofocus: true,
              hint:
                  'Ejemplo: Cita con el Dr. García el próximo martes 15 de marzo a las 3:00 PM en el consultorio de cardiología...',
            ),
          ],
        ),
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline(),
          onPress: _isProcessing ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FButton(
          onPress: _isProcessing ? null : _handleSubmit,
          child:
              _isProcessing
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Procesar'),
        ),
      ],
    );
  }

  void _handleSubmit() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      _showErrorSnackbar('Por favor, escribe algunos detalles de la cita');
      return;
    }

    if (text.length < 10) {
      _showErrorSnackbar('Por favor, proporciona más detalles sobre la cita');
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      context.read<AppointmentCapture_Bloc>().add(
        AppointmentCapture_Event_CaptureFromText(text: text),
      );

      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showErrorSnackbar('Error al procesar el texto: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
