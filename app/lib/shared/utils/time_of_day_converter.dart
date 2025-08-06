import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

class JsonKey_TimeOfDayConverter implements JsonConverter<TimeOfDay?, String?> {
  const JsonKey_TimeOfDayConverter();

  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) return null;

    try {
      final parts = json.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
          return TimeOfDay(hour: hour, minute: minute);
        }
      }
    } catch (e) {
      // Invalid time format, return null
    }

    return null;
  }

  @override
  String? toJson(TimeOfDay? time) {
    if (time == null) return null;
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
