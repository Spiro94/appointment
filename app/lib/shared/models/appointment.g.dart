// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Appointment _$Model_AppointmentFromJson(Map<String, dynamic> json) =>
    Model_Appointment(
      doctorName: json['doctor_name'] as String?,
      specialty: json['specialty'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      appointmentType: json['appointment_type'] as String?,
      instructions: json['instructions'] as String?,
      authorizationNumber: json['authorization_number'] as String?,
      notes: json['notes'] as String?,
      confidence: (json['confidence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Model_AppointmentToJson(Model_Appointment instance) =>
    <String, dynamic>{
      'doctor_name': instance.doctorName,
      'specialty': instance.specialty,
      'date': instance.date,
      'time': instance.time,
      'location': instance.location,
      'address': instance.address,
      'phone': instance.phone,
      'appointment_type': instance.appointmentType,
      'instructions': instance.instructions,
      'authorization_number': instance.authorizationNumber,
      'notes': instance.notes,
      'confidence': instance.confidence,
    };
