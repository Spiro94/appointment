import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

/// Model for structured appointment data
@JsonSerializable(fieldRename: FieldRename.snake)
class Model_Appointment extends Equatable {
  const Model_Appointment({
    this.doctorName,
    this.specialty,
    this.date,
    this.time,
    this.location,
    this.address,
    this.phone,
    this.appointmentType,
    this.instructions,
    this.authorizationNumber,
    this.notes,
    this.confidence,
  });

  final String? doctorName;
  final String? specialty;
  final String? date; // ISO format YYYY-MM-DD
  final String? time; // 24-hour format HH:MM
  final String? location;
  final String? address;
  final String? phone;
  final String? appointmentType;
  final String? instructions;
  final String? authorizationNumber;
  final String? notes;
  final int? confidence; // 0-100

  factory Model_Appointment.fromJson(Map<String, dynamic> json) =>
      _$Model_AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$Model_AppointmentToJson(this);

  @override
  List<Object?> get props => [
    doctorName,
    specialty,
    date,
    time,
    location,
    address,
    phone,
    appointmentType,
    instructions,
    authorizationNumber,
    notes,
    confidence,
  ];
}
