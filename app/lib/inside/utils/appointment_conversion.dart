import '../../shared/models/appointment.dart';

/// Utility functions for appointment conversions
class AppointmentConversion {
  /// Check if an appointment is in the future (upcoming)
  static bool isUpcoming(Model_Appointment appointment) {
    if (appointment.date == null) return false;

    try {
      final appointmentDate = appointment.date!;
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final appointmentDateOnly = DateTime(
        appointmentDate.year,
        appointmentDate.month,
        appointmentDate.day,
      );

      return appointmentDateOnly.isAfter(todayDate) ||
          appointmentDateOnly.isAtSameMomentAs(todayDate);
    } catch (e) {
      return false;
    }
  }
}
