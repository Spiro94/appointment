// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Appointment _$Model_AppointmentFromJson(Map<String, dynamic> json) =>
    Model_Appointment(
      id: json['id'] as String?,
      doctorName: json['doctor_name'] as String?,
      specialty: json['specialty'] as String?,
      date: const JsonKey_DateTimeConverter().fromJson(json['date'] as String?),
      time: const JsonKey_TimeConverter().fromJson(json['time'] as String?),
      location: json['location'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      appointmentType: const JsonKey_AppointmentTypeConverter().fromJson(
        json['appointment_type'] as String?,
      ),
      captureMethod: $enumDecodeNullable(
        _$ModelEnum_CaptureMethodEnumMap,
        json['capture_method'],
      ),
      instructions: json['instructions'] as String?,
      authorizationNumber: json['authorization_number'] as String?,
      notes: json['notes'] as String?,
      confidence: (json['confidence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Model_AppointmentToJson(
  Model_Appointment instance,
) => <String, dynamic>{
  'id': instance.id,
  'doctor_name': instance.doctorName,
  'specialty': instance.specialty,
  'date': const JsonKey_DateTimeConverter().toJson(instance.date),
  'time': const JsonKey_TimeConverter().toJson(instance.time),
  'location': instance.location,
  'address': instance.address,
  'phone': instance.phone,
  'appointment_type': const JsonKey_AppointmentTypeConverter().toJson(
    instance.appointmentType,
  ),
  'capture_method': _$ModelEnum_CaptureMethodEnumMap[instance.captureMethod],
  'instructions': instance.instructions,
  'authorization_number': instance.authorizationNumber,
  'notes': instance.notes,
  'confidence': instance.confidence,
};

const _$ModelEnum_CaptureMethodEnumMap = {
  ModelEnum_CaptureMethod.audio: 'audio',
  ModelEnum_CaptureMethod.image: 'image',
  ModelEnum_CaptureMethod.text: 'text',
};
