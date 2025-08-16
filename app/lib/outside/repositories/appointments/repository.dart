import '../../../shared/models/ai_models.dart';
import '../../../shared/models/appointment.dart';
import '../../../shared/models/family_appointment.dart';
import '../../client_providers/supabase/client_provider.dart';
import '../../effect_providers/all.dart';
import '../base.dart';

/// Repository for handling appointments data persistence
class Appointments_Repository extends Repository_Base {
  Appointments_Repository({
    required this.supabaseClientProvider,
    required this.effectProviders,
  });

  final Supabase_ClientProvider supabaseClientProvider;
  final EffectProviders_All effectProviders;

  @override
  Future<void> init() async {
    log.fine('Appointments Repository initialized');
  }

  /// Save appointment data from AI capture to the database
  Future<Model_Appointment> saveAppointment({
    required Model_AI_AppointmentData appointmentData,
    required String captureMethod,
    String? rawText,
  }) async {
    try {
      log.info('Saving appointment to database');

      // Get current user ID
      final userId = supabaseClientProvider.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Convert AI appointment data to database format
      final appointmentMap = {
        'user_id': userId,
        'doctor_name': appointmentData.doctorName,
        'specialty': appointmentData.specialty,
        'date': appointmentData.date,
        'time': appointmentData.time,
        'location': appointmentData.location,
        'address': appointmentData.address,
        'phone': appointmentData.phone,
        'appointment_type': _mapAppointmentType(
          appointmentData.appointmentType,
        ),
        'instructions': appointmentData.instructions,
        'authorization_number': appointmentData.authorizationNumber,
        'notes': appointmentData.notes,
        'confidence': appointmentData.confidence,
        'capture_method': captureMethod,
        'raw_text': rawText,
        'status': 'scheduled',
      };

      final response =
          await supabaseClientProvider.client
              .from('appointments')
              .insert(appointmentMap)
              .select()
              .single();

      log.info('Appointment saved successfully with ID: ${response['id']}');

      // Convert back to Model_Appointment
      return Model_Appointment.fromJson(response);
    } catch (e) {
      log.severe('Error saving appointment: $e');
      rethrow;
    }
  }

  /// Get all appointments for the current user
  Future<List<Model_Appointment>> getUserAppointments() async {
    try {
      log.info('Fetching user appointments');

      final response = await supabaseClientProvider.client
          .from('appointments')
          .select()
          .filter('deleted_at', 'is', null)
          .order('date', ascending: true)
          .order('time', ascending: true);

      log.info('Retrieved ${response.length} appointments');

      return response.map<Model_Appointment>((appointment) {
        return Model_Appointment.fromJson(appointment);
      }).toList();
    } catch (e) {
      log.severe('Error fetching appointments: $e');
      rethrow;
    }
  }

  /// Get future appointments for the current user (from today onwards)
  Future<List<Model_Appointment>> getFutureAppointments() async {
    try {
      log.info('Fetching future appointments');

      final today = DateTime.now().toIso8601String().split('T')[0];

      final response = await supabaseClientProvider.client
          .from('appointments')
          .select()
          .filter('deleted_at', 'is', null)
          .gte('date', today)
          .order('date', ascending: true)
          .order('time', ascending: true);

      log.info('Retrieved ${response.length} future appointments');

      return response.map<Model_Appointment>((appointment) {
        return Model_Appointment.fromJson(appointment);
      }).toList();
    } catch (e) {
      log.severe('Error fetching future appointments: $e');
      rethrow;
    }
  }

  /// Get past appointments for the current user (before today)
  Future<List<Model_Appointment>> getPastAppointments() async {
    try {
      log.info('Fetching past appointments');

      final today = DateTime.now().toIso8601String().split('T')[0];

      final response = await supabaseClientProvider.client
          .from('appointments')
          .select()
          .filter('deleted_at', 'is', null)
          .lt('date', today)
          .order('date', ascending: false)
          .order('time', ascending: false);

      log.info('Retrieved ${response.length} past appointments');

      return response.map<Model_Appointment>((appointment) {
        return Model_Appointment.fromJson(appointment);
      }).toList();
    } catch (e) {
      log.severe('Error fetching past appointments: $e');
      rethrow;
    }
  }

  /// Get appointments for a specific date
  Future<List<Model_Appointment>> getAppointmentsByDate(String date) async {
    try {
      log.info('Fetching appointments for date: $date');

      final response = await supabaseClientProvider.client
          .from('appointments')
          .select()
          .eq('date', date)
          .filter('deleted_at', 'is', null)
          .order('time', ascending: true);

      log.info('Retrieved ${response.length} appointments for $date');

      return response.map<Model_Appointment>((appointment) {
        return Model_Appointment.fromJson(appointment);
      }).toList();
    } catch (e) {
      log.severe('Error fetching appointments by date: $e');
      rethrow;
    }
  }

  /// Update an appointment
  Future<Model_Appointment> updateAppointment({
    required String appointmentId,
    required Model_Appointment appointmentData,
  }) async {
    try {
      log.info('Updating appointment with ID: $appointmentId');

      final response =
          await supabaseClientProvider.client
              .from('appointments')
              .update(appointmentData.toJson())
              .eq('id', appointmentId)
              .select()
              .single();

      log.info('Appointment updated successfully');

      return Model_Appointment.fromJson(response);
    } catch (e) {
      log.severe('Error updating appointment: $e');
      rethrow;
    }
  }

  /// Soft delete an appointment
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      log.info('Deleting appointment with ID: $appointmentId');

      await supabaseClientProvider.client
          .from('appointments')
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('id', appointmentId);

      log.info('Appointment deleted successfully');
    } catch (e) {
      log.severe('Error deleting appointment: $e');
      rethrow;
    }
  }

  /// Get appointments for all family members with user profile information
  /// This method returns appointments with additional user information for displaying
  /// which family member the appointment belongs to
  Future<List<Model_FamilyAppointment>>
  getFamilyAppointmentsWithUserInfo() async {
    try {
      log.info('Fetching family appointments with user info');

      final response = await supabaseClientProvider.client
          .from('appointments')
          .select('''
            *,
            user_profiles!inner (
              id,
              display_name,
              email
            )
          ''')
          .filter('deleted_at', 'is', null)
          .order('date', ascending: true)
          .order('time', ascending: true);

      log.info('Retrieved ${response.length} family appointments');

      return response.map<Model_FamilyAppointment>((item) {
        // Extract appointment data (all fields except user_profiles)
        final appointmentData = Map<String, dynamic>.from(item);
        appointmentData.remove('user_profiles');

        // Extract user profile data
        final userProfileData = item['user_profiles'] as Map<String, dynamic>;

        return Model_FamilyAppointment(
          appointment: Model_Appointment.fromJson(appointmentData),
          userProfile: Model_FamilyAppointmentUserProfile.fromJson(
            userProfileData,
          ),
        );
      }).toList();
    } catch (e) {
      log.severe('Error fetching family appointments: $e');
      rethrow;
    }
  }

  /// Map appointment type string to enum value for database
  String? _mapAppointmentType(String? appointmentType) {
    if (appointmentType == null) return null;

    final type = appointmentType.toLowerCase();

    if (type.contains('consulta') || type.contains('general')) {
      return 'consulta_general';
    } else if (type.contains('control')) {
      return 'control';
    } else if (type.contains('procedimiento')) {
      return 'procedimiento';
    } else if (type.contains('cirugia') || type.contains('cirugía')) {
      return 'cirugia';
    } else if (type.contains('terapia')) {
      return 'terapia';
    } else if (type.contains('examen')) {
      return 'examen';
    } else {
      return 'otro';
    }
  }
}
