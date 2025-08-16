import '../../../shared/models/family.dart';
import '../../client_providers/supabase/client_provider.dart';
import '../../effect_providers/all.dart';
import '../base.dart';

/// Repository for handling family and user profile data persistence
class Families_Repository extends Repository_Base {
  Families_Repository({
    required this.supabaseClientProvider,
    required this.effectProviders,
  });

  final Supabase_ClientProvider supabaseClientProvider;
  final EffectProviders_All effectProviders;

  @override
  Future<void> init() async {
    log.fine('Families Repository initialized');
  }

  /// Get current user's profile
  Future<Model_UserProfile?> getCurrentUserProfile() async {
    try {
      log.info('Fetching current user profile');

      final userId = supabaseClientProvider.client.auth.currentUser?.id;
      if (userId == null) {
        log.warning('User not authenticated');
        return null;
      }

      final response =
          await supabaseClientProvider.client
              .from('user_profiles')
              .select()
              .eq('id', userId)
              .maybeSingle();

      if (response == null) {
        log.info('User profile not found');
        return null;
      }

      log.info('Retrieved user profile');
      return Model_UserProfile.fromJson(response);
    } catch (e) {
      log.severe('Error fetching user profile: $e');
      rethrow;
    }
  }

  /// Create a new family
  Future<Model_Family> createFamily({required String familyName}) async {
    try {
      log.info('Creating new family: $familyName');

      final userId = supabaseClientProvider.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Generate unique invite code
      final inviteCodeResponse = await supabaseClientProvider.client
          .rpc<String>('generate_family_invite_code');

      final inviteCode = inviteCodeResponse;

      // Create the family
      final familyResponse =
          await supabaseClientProvider.client
              .from('families')
              .insert({
                'name': familyName.trim(),
                'invite_code': inviteCode,
                'owner_id': userId,
              })
              .select()
              .single();

      final family = Model_Family.fromJson(familyResponse);

      // Update user profile to join the family and mark setup as complete
      await _updateUserProfile(
        familyId: family.id,
        hasCompletedFamilySetup: true,
      );

      log.info('Family created successfully with ID: ${family.id}');
      return family;
    } catch (e) {
      log.severe('Error creating family: $e');
      rethrow;
    }
  }

  /// Join a family using invite code
  Future<Model_Family> joinFamily({required String inviteCode}) async {
    try {
      log.info('Joining family with invite code: $inviteCode');

      final userId = supabaseClientProvider.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Find family by invite code
      final familyResponse =
          await supabaseClientProvider.client
              .from('families')
              .select()
              .eq('invite_code', inviteCode.toUpperCase())
              .maybeSingle();

      if (familyResponse == null) {
        throw Exception('Invalid invite code');
      }

      final family = Model_Family.fromJson(familyResponse);

      // Update user profile to join the family and mark setup as complete
      await _updateUserProfile(
        familyId: family.id,
        hasCompletedFamilySetup: true,
      );

      log.info('Successfully joined family: ${family.name}');
      return family;
    } catch (e) {
      log.severe('Error joining family: $e');
      rethrow;
    }
  }

  /// Get current user's family
  Future<Model_Family?> getUserFamily() async {
    try {
      log.info('Fetching user family');

      final userProfile = await getCurrentUserProfile();
      if (userProfile?.familyId == null) {
        log.info('User is not in a family');
        return null;
      }

      final familyResponse =
          await supabaseClientProvider.client
              .from('families')
              .select()
              .eq('id', userProfile!.familyId!)
              .single();

      log.info('Retrieved user family');
      return Model_Family.fromJson(familyResponse);
    } catch (e) {
      log.severe('Error fetching user family: $e');
      rethrow;
    }
  }

  /// Get all family members (user profiles)
  Future<List<Model_UserProfile>> getFamilyMembers() async {
    try {
      log.info('Fetching family members');

      final userProfile = await getCurrentUserProfile();
      if (userProfile?.familyId == null) {
        log.info('User is not in a family');
        return [];
      }

      final response = await supabaseClientProvider.client
          .from('user_profiles')
          .select()
          .eq('family_id', userProfile!.familyId!)
          .order('created_at', ascending: true);

      log.info('Retrieved ${response.length} family members');
      return response
          .map<Model_UserProfile>(
            (profile) => Model_UserProfile.fromJson(profile),
          )
          .toList();
    } catch (e) {
      log.severe('Error fetching family members: $e');
      rethrow;
    }
  }

  /// Leave current family
  Future<void> leaveFamily() async {
    try {
      log.info('Leaving current family');

      await _updateUserProfile(familyId: null, hasCompletedFamilySetup: false);

      log.info('Successfully left family');
    } catch (e) {
      log.severe('Error leaving family: $e');
      rethrow;
    }
  }

  /// Update user profile display name
  Future<void> updateDisplayName({required String displayName}) async {
    try {
      log.info('Updating display name');

      final userId = supabaseClientProvider.client.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await supabaseClientProvider.client
          .from('user_profiles')
          .update({'display_name': displayName.trim()})
          .eq('id', userId);

      log.info('Display name updated successfully');
    } catch (e) {
      log.severe('Error updating display name: $e');
      rethrow;
    }
  }

  /// Mark family setup as complete
  Future<void> completeFamilySetup() async {
    try {
      log.info('Marking family setup as complete');

      await _updateUserProfile(hasCompletedFamilySetup: true);

      log.info('Family setup marked as complete');
    } catch (e) {
      log.severe('Error completing family setup: $e');
      rethrow;
    }
  }

  /// Private helper to update user profile
  Future<void> _updateUserProfile({
    String? familyId,
    bool? hasCompletedFamilySetup,
  }) async {
    final userId = supabaseClientProvider.client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final updateData = <String, dynamic>{};
    if (familyId != null) {
      updateData['family_id'] = familyId;
    }
    if (hasCompletedFamilySetup != null) {
      updateData['has_completed_family_setup'] = hasCompletedFamilySetup;
    }

    await supabaseClientProvider.client
        .from('user_profiles')
        .update(updateData)
        .eq('id', userId);
  }
}
