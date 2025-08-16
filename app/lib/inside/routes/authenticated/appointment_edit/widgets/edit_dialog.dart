import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../../../../shared/models/appointment.dart';
import '../../../../../shared/models/enums/appointment_type.dart';
import '../../../../../shared/utils/snackbar_utils.dart';
import '../../../../blocs/appointment_edit/bloc.dart';
import '../../../../blocs/appointment_edit/events.dart';
import '../../../../blocs/appointment_edit/state.dart';

/// Sheet widget for editing appointment details
class AppointmentEdit_Sheet extends StatefulWidget {
  const AppointmentEdit_Sheet({super.key, this.initialData});

  final Model_Appointment? initialData;

  @override
  State<AppointmentEdit_Sheet> createState() => _AppointmentEdit_SheetState();
}

class _AppointmentEdit_SheetState extends State<AppointmentEdit_Sheet>
    with TickerProviderStateMixin {
  late final TextEditingController _doctorNameController;
  late final TextEditingController _specialtyController;
  late final FDateFieldController _dateController;
  late final TextEditingController _timeController;
  late final TextEditingController _locationController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;
  late final TextEditingController _instructionsController;
  late final TextEditingController _authorizationNumberController;
  late final TextEditingController _notesController;

  ModelEnum_AppointmentType? _selectedAppointmentType;
  FTime? _selectedTime;

  // Helper method to format FTime to string (HH:MM)
  String? _formatTime(FTime? time) {
    if (time == null) return null;
    return time
        .toString(); // FTime already has a toString() that returns HH:MM format
  }

  // Method to show time picker modal
  Future<void> _showTimePicker() async {
    // Create a controller for the modal time picker
    final timePickerController = FTimePickerController();

    // Set initial value if we have one
    if (_selectedTime != null) {
      timePickerController.value = _selectedTime!;
    }

    final result = await showFSheet<FTime?>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: 0.7,
      builder:
          (sheetContext) => SafeArea(
            top: false,
            child: Container(
              decoration: BoxDecoration(color: context.theme.colors.background),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Seleccionar Hora',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: FTimePicker(controller: timePickerController),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FButton(
                        style: FButtonStyle.outline(),
                        onPress: () => Navigator.of(sheetContext).pop(),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      FButton(
                        onPress: () {
                          Navigator.of(
                            sheetContext,
                          ).pop(timePickerController.value);
                        },
                        child: const Text('Seleccionar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );

    // Dispose the controller
    timePickerController.dispose();

    if (result != null) {
      setState(() {
        _selectedTime = result;
        // Update the time controller to display the selected time
        _timeController.text = _formatTime(result) ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize controllers with initial data if provided
    final initialData = widget.initialData;

    _doctorNameController = TextEditingController(
      text: initialData?.doctorName ?? '',
    );
    _specialtyController = TextEditingController(
      text: initialData?.specialty ?? '',
    );
    _dateController = FDateFieldController(vsync: this);
    if (initialData?.date != null) {
      _dateController.value = initialData!.date;
    }

    // Initialize time controller and selected time from initial data
    _timeController = TextEditingController();
    if (initialData?.time != null) {
      _selectedTime = initialData!.time;
      _timeController.text = _formatTime(_selectedTime) ?? '';
    }
    _locationController = TextEditingController(
      text: initialData?.location ?? '',
    );
    _addressController = TextEditingController(
      text: initialData?.address ?? '',
    );
    _phoneController = TextEditingController(text: initialData?.phone ?? '');
    _instructionsController = TextEditingController(
      text: initialData?.instructions ?? '',
    );
    _authorizationNumberController = TextEditingController(
      text: initialData?.authorizationNumber ?? '',
    );
    _notesController = TextEditingController(text: initialData?.notes ?? '');

    _selectedAppointmentType = initialData?.appointmentType;
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _specialtyController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _instructionsController.dispose();
    _authorizationNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Model_Appointment _createAppointmentData() {
    final currentState = context.read<AppointmentEdit_Bloc>().state;
    return Model_Appointment(
      id: currentState.appointmentId,
      doctorName:
          _doctorNameController.text.trim().isEmpty
              ? null
              : _doctorNameController.text.trim(),
      specialty:
          _specialtyController.text.trim().isEmpty
              ? null
              : _specialtyController.text.trim(),
      date: _dateController.value,
      time: _selectedTime,
      location:
          _locationController.text.trim().isEmpty
              ? null
              : _locationController.text.trim(),
      address:
          _addressController.text.trim().isEmpty
              ? null
              : _addressController.text.trim(),
      phone:
          _phoneController.text.trim().isEmpty
              ? null
              : _phoneController.text.trim(),
      appointmentType: _selectedAppointmentType,
      captureMethod: currentState.currentData?.captureMethod,
      instructions:
          _instructionsController.text.trim().isEmpty
              ? null
              : _instructionsController.text.trim(),
      authorizationNumber:
          _authorizationNumberController.text.trim().isEmpty
              ? null
              : _authorizationNumberController.text.trim(),
      notes:
          _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentEdit_Bloc, AppointmentEdit_State>(
      listener: (context, state) {
        if (state.isSaved) {
          Navigator.of(
            context,
          ).pop(true); // Return true to indicate successful save
        } else if (state.hasError && state.errorMessage != null) {
          SnackbarUtils.showFAlertSnackbar(
            context,
            text: state.errorMessage!,
            alertStyle: FAlertStyle.destructive(),
          );
        }
      },
      builder: (context, state) {
        return FScaffold(
          header: FHeader(
            title: const Text('Editar Cita'),
            suffixes: [
              FButton(
                style: FButtonStyle.outline(),
                onPress:
                    state.isSaving
                        ? null
                        : () {
                          context.read<AppointmentEdit_Bloc>().add(
                            const AppointmentEdit_Event_Cancel(),
                          );
                          Navigator.of(context).pop(false);
                        },
                child: const Text('Cancelar'),
              ),
              FButton(
                onPress:
                    state.isSaving
                        ? null
                        : () {
                          // Create appointment data from current form state
                          final appointmentData = _createAppointmentData();

                          // Update the bloc with current data and then save
                          context.read<AppointmentEdit_Bloc>().add(
                            AppointmentEdit_Event_UpdateData(
                              appointmentData: appointmentData,
                            ),
                          );

                          // Trigger save
                          context.read<AppointmentEdit_Bloc>().add(
                            const AppointmentEdit_Event_SaveChanges(),
                          );
                        },
                child:
                    state.isSaving
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Guardar'),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Doctor Name
                FTextField(
                  controller: _doctorNameController,
                  label: const Text('Doctor'),
                ),
                const SizedBox(height: 16),

                // Specialty
                FTextField(
                  controller: _specialtyController,
                  label: const Text('Especialidad'),
                ),
                const SizedBox(height: 16),

                // Date and Time in a row
                Row(
                  children: [
                    Expanded(
                      child: FDateField.calendar(
                        controller: _dateController,
                        label: const Text('Fecha'),
                        hint: 'Seleccionar fecha',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FTextField(
                        controller: _timeController,
                        label: const Text('Hora'),
                        hint: 'Seleccionar hora',
                        readOnly: true,
                        onTap: () async {
                          await _showTimePicker();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Location
                FTextField(
                  controller: _locationController,
                  label: const Text('Lugar'),
                ),
                const SizedBox(height: 16),

                // Address
                FTextField(
                  controller: _addressController,
                  label: const Text('Dirección'),
                ),
                const SizedBox(height: 16),

                // Phone and Appointment Type in a row
                Row(
                  children: [
                    Expanded(
                      child: FTextField(
                        controller: _phoneController,
                        label: const Text('Teléfono'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FSelect<ModelEnum_AppointmentType>(
                            label: const Text('Tipo de Cita'),
                            hint: 'Seleccionar tipo',
                            initialValue: _selectedAppointmentType,
                            format: (type) => type.name,
                            onChange: (ModelEnum_AppointmentType? newValue) {
                              setState(() {
                                _selectedAppointmentType = newValue;
                              });
                            },
                            children: [
                              for (final type
                                  in ModelEnum_AppointmentType.values)
                                FSelectItem(type.name, type),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Instructions
                FTextField(
                  controller: _instructionsController,
                  label: const Text('Instrucciones'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // Authorization Number
                FTextField(
                  controller: _authorizationNumberController,
                  label: const Text('Número de Autorización'),
                ),
                const SizedBox(height: 16),

                // Notes
                FTextField(
                  controller: _notesController,
                  label: const Text('Notas'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
