import 'package:equatable/equatable.dart';
import 'package:forui/forui.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/appointment_type_converter.dart';
import '../utils/date_time_converter.dart';
import '../utils/time_converter.dart';
import 'enums/appointment_type.dart';
import 'enums/capture_method.dart';

part 'appointment.g.dart';

/// Model for structured appointment data
@JsonSerializable(fieldRename: FieldRename.snake)
class Model_Appointment extends Equatable {
  const Model_Appointment({
    this.id,
    this.doctorName,
    this.specialty,
    this.date,
    this.time,
    this.location,
    this.address,
    this.phone,
    this.appointmentType,
    this.captureMethod,
    this.instructions,
    this.authorizationNumber,
    this.notes,
    this.confidence,
  });

  final String? id;
  final String? doctorName;
  final String? specialty;
  @JsonKey_DateTimeConverter()
  final DateTime? date; // ISO format YYYY-MM-DD
  @JsonKey_TimeConverter()
  final FTime? time; // 24-hour format using FTime
  final String? location;
  final String? address;
  final String? phone;
  @JsonKey_AppointmentTypeConverter()
  final ModelEnum_AppointmentType? appointmentType;
  final ModelEnum_CaptureMethod? captureMethod;
  final String? instructions;
  final String? authorizationNumber;
  final String? notes;
  final int? confidence; // 0-100

  factory Model_Appointment.fromJson(Map<String, dynamic> json) =>
      _$Model_AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AppointmentToJson(this);

  @override
  List<Object?> get props => [
    id,
    doctorName,
    specialty,
    date,
    time,
    location,
    address,
    phone,
    appointmentType,
    captureMethod,
    instructions,
    authorizationNumber,
    notes,
    confidence,
  ];
}
