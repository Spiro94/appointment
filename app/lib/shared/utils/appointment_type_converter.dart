import 'package:json_annotation/json_annotation.dart';

import '../models/enums/appointment_type.dart';

class JsonKey_AppointmentTypeConverter
    implements JsonConverter<ModelEnum_AppointmentType?, String?> {
  const JsonKey_AppointmentTypeConverter();

  @override
  ModelEnum_AppointmentType? fromJson(String? json) {
    if (json == null) return null;
    return ModelEnum_AppointmentType.values.firstWhere(
      (e) => e.key.toLowerCase() == json.toLowerCase(),
      orElse: () => ModelEnum_AppointmentType.otro,
    );
  }

  @override
  String? toJson(ModelEnum_AppointmentType? appointmentType) {
    return appointmentType?.key.toLowerCase();
  }
}
