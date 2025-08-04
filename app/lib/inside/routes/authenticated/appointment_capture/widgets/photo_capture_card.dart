import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../blocs/appointment_capture/bloc.dart';
import '../../../../blocs/appointment_capture/events.dart';

/// Card widget for photo capture method
class AppointmentCapture_PhotoCaptureCard extends StatelessWidget {
  const AppointmentCapture_PhotoCaptureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: FTappable(
        onPress: () => _handlePhotoCapture(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 32,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tomar Foto',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fotografía la orden médica o documento',
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

  Future<void> _handlePhotoCapture(BuildContext context) async {
    try {
      // Show source selection dialog
      final source = await _showImageSourceDialog(context);
      if (source == null) return;

      // Check camera permission if needed
      if (source == ImageSource.camera) {
        final permission = await Permission.camera.status;
        if (permission.isDenied) {
          final result = await Permission.camera.request();
          if (result.isDenied) {
            _showPermissionDeniedDialog(context, 'cámara');
            return;
          }
        }
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null && context.mounted) {
        final imageBytes = await File(image.path).readAsBytes();
        context.read<AppointmentCapture_Bloc>().add(
          AppointmentCapture_Event_CaptureFromImage(imageBytes: imageBytes),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackbar(context, 'Error al capturar imagen: $e');
      }
    }
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) {
    return showFDialog<ImageSource>(
      context: context,
      builder:
          (fContext, style, animation) => FDialog(
            title: const Text('Seleccionar fuente'),
            body: const Text('¿Cómo deseas obtener la imagen?'),
            actions: [
              FButton(
                onPress: () => Navigator.of(context).pop(ImageSource.gallery),
                child: const Text('Galería'),
              ),
              FButton(
                onPress: () => Navigator.of(context).pop(ImageSource.camera),
                child: const Text('Cámara'),
              ),
              const SizedBox(height: 16),
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );
  }

  void _showPermissionDeniedDialog(BuildContext context, String permission) {
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Permiso necesario'),
            content: Text(
              'Necesitamos acceso a la $permission para esta funcionalidad. '
              'Por favor, habilítelo en la configuración de la aplicación.',
            ),
            actions: [
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => Navigator.of(context).pop(),
                child: const Text('Entendido'),
              ),
              FButton(
                onPress: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                child: const Text('Abrir configuración'),
              ),
            ],
          ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
