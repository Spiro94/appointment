import 'package:json_annotation/json_annotation.dart';

class JsonKey_DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const JsonKey_DateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null) return null;
    return DateTime.parse(json).toLocal();
  }

  @override
  String? toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.toUtc().toIso8601String();
  }
}
