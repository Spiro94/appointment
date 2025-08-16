// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_FamilyAppointment _$Model_FamilyAppointmentFromJson(
  Map<String, dynamic> json,
) => Model_FamilyAppointment(
  appointment: Model_Appointment.fromJson(
    json['appointment'] as Map<String, dynamic>,
  ),
  userProfile: Model_FamilyAppointmentUserProfile.fromJson(
    json['user_profile'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$Model_FamilyAppointmentToJson(
  Model_FamilyAppointment instance,
) => <String, dynamic>{
  'appointment': instance.appointment,
  'user_profile': instance.userProfile,
};

Model_FamilyAppointmentUserProfile _$Model_FamilyAppointmentUserProfileFromJson(
  Map<String, dynamic> json,
) => Model_FamilyAppointmentUserProfile(
  id: json['id'] as String,
  displayName: json['display_name'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$Model_FamilyAppointmentUserProfileToJson(
  Model_FamilyAppointmentUserProfile instance,
) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'email': instance.email,
};
