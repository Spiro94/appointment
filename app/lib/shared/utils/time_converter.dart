import 'package:forui/forui.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonKey_TimeConverter implements JsonConverter<FTime?, String?> {
  const JsonKey_TimeConverter();

  @override
  FTime? fromJson(String? json) {
    if (json == null) return null;

    try {
      final parts = json.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
          return FTime(hour, minute);
        }
      }
    } catch (e) {
      // Invalid time format, return null
    }

    return null;
  }

  @override
  String? toJson(FTime? time) {
    if (time == null) return null;
    return time.toString(); // FTime.toString() returns HH:MM format
  }
}
