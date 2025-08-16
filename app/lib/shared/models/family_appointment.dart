import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appointment.dart';

part 'family_appointment.g.dart';

/// Model for appointments with family member information
/// This extends the basic appointment model to include information about
/// which family member the appointment belongs to
@JsonSerializable(fieldRename: FieldRename.snake)
class Model_FamilyAppointment extends Equatable {
  const Model_FamilyAppointment({
    required this.appointment,
    required this.userProfile,
  });

  /// The appointment data
  final Model_Appointment appointment;

  /// Information about the family member who owns this appointment
  final Model_FamilyAppointmentUserProfile userProfile;

  factory Model_FamilyAppointment.fromJson(Map<String, dynamic> json) =>
      _$Model_FamilyAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$Model_FamilyAppointmentToJson(this);

  @override
  List<Object?> get props => [appointment, userProfile];
}

/// User profile information for family appointments
@JsonSerializable(fieldRename: FieldRename.snake)
class Model_FamilyAppointmentUserProfile extends Equatable {
  const Model_FamilyAppointmentUserProfile({
    required this.id,
    this.displayName,
    this.email,
  });

  final String id;
  final String? displayName;
  final String? email;

  /// Get the display name or fallback to email or ID
  String get name => displayName ?? email ?? id;

  factory Model_FamilyAppointmentUserProfile.fromJson(
    Map<String, dynamic> json,
  ) => _$Model_FamilyAppointmentUserProfileFromJson(json);

  Map<String, dynamic> toJson() =>
      _$Model_FamilyAppointmentUserProfileToJson(this);

  @override
  List<Object?> get props => [id, displayName, email];
}
