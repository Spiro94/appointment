// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Appointment _$Model_AppointmentFromJson(Map<String, dynamic> json) =>
    Model_Appointment(
      doctorName: json['doctorName'] as String?,
      specialty: json['specialty'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      appointmentType: json['appointmentType'] as String?,
      instructions: json['instructions'] as String?,
      authorizationNumber: json['authorizationNumber'] as String?,
      notes: json['notes'] as String?,
      confidence: (json['confidence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Model_AppointmentToJson(Model_Appointment instance) =>
    <String, dynamic>{
      'doctorName': instance.doctorName,
      'specialty': instance.specialty,
      'date': instance.date,
      'time': instance.time,
      'location': instance.location,
      'address': instance.address,
      'phone': instance.phone,
      'appointmentType': instance.appointmentType,
      'instructions': instance.instructions,
      'authorizationNumber': instance.authorizationNumber,
      'notes': instance.notes,
      'confidence': instance.confidence,
    };
