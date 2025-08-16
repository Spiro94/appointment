import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../outside/repositories/families/repository.dart';
import '../base.dart';
import 'events.dart';
import 'state.dart';

class FamilySetup_Bloc extends Bloc_Base<FamilySetup_Event, FamilySetup_State> {
  FamilySetup_Bloc({required Families_Repository familiesRepository})
    : _familiesRepository = familiesRepository,
      super(const FamilySetup_State()) {
    on<FamilySetup_Event_CheckSetupStatus>(
      _onCheckSetupStatus,
      transformer: sequential(),
    );
    on<FamilySetup_Event_CreateFamily>(
      _onCreateFamily,
      transformer: sequential(),
    );
    on<FamilySetup_Event_JoinFamily>(_onJoinFamily, transformer: sequential());
    on<FamilySetup_Event_LoadFamily>(_onLoadFamily, transformer: sequential());
    on<FamilySetup_Event_LoadFamilyMembers>(
      _onLoadFamilyMembers,
      transformer: sequential(),
    );
    on<FamilySetup_Event_LeaveFamily>(
      _onLeaveFamily,
      transformer: sequential(),
    );
    on<FamilySetup_Event_UpdateDisplayName>(
      _onUpdateDisplayName,
      transformer: sequential(),
    );
  }

  final Families_Repository _familiesRepository;

  Future<void> _onCheckSetupStatus(
    FamilySetup_Event_CheckSetupStatus event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      emit(state.copyWith(status: FamilySetup_Status.loading, isLoading: true));

      final userProfile = await _familiesRepository.getCurrentUserProfile();

      if (userProfile == null) {
        emit(
          state.copyWith(
            status: FamilySetup_Status.setupRequired,
            isLoading: false,
          ),
        );
        return;
      }

      if (!userProfile.hasCompletedFamilySetup) {
        emit(
          state.copyWith(
            status: FamilySetup_Status.setupRequired,
            userProfile: userProfile,
            isLoading: false,
          ),
        );
        return;
      }

      // User has completed setup, load family if they have one
      emit(
        state.copyWith(
          status: FamilySetup_Status.setupCompleted,
          userProfile: userProfile,
          isLoading: false,
        ),
      );

      // Load family data if user is in a family
      if (userProfile.familyId != null) {
        add(FamilySetup_Event_LoadFamily());
      }
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: FamilySetup_Status.loadFamilyError,
          setErrorMessage: () => e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onCreateFamily(
    FamilySetup_Event_CreateFamily event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FamilySetup_Status.createFamilyInProgress,
          isLoading: true,
        ),
      );

      final family = await _familiesRepository.createFamily(
        familyName: event.familyName,
      );

      // Get updated user profile
      final userProfile = await _familiesRepository.getCurrentUserProfile();

      emit(
        state.copyWith(
          status: FamilySetup_Status.createFamilySuccess,
          family: family,
          userProfile: userProfile,
          isLoading: false,
          setErrorMessage: () => null,
        ),
      );

      // Load family members
      add(FamilySetup_Event_LoadFamilyMembers());
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: FamilySetup_Status.createFamilyError,
          setErrorMessage: () => e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onJoinFamily(
    FamilySetup_Event_JoinFamily event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FamilySetup_Status.joinFamilyInProgress,
          isLoading: true,
        ),
      );

      final family = await _familiesRepository.joinFamily(
        inviteCode: event.inviteCode,
      );

      // Get updated user profile
      final userProfile = await _familiesRepository.getCurrentUserProfile();

      emit(
        state.copyWith(
          status: FamilySetup_Status.joinFamilySuccess,
          family: family,
          userProfile: userProfile,
          isLoading: false,
          setErrorMessage: () => null,
        ),
      );

      // Load family members
      add(FamilySetup_Event_LoadFamilyMembers());
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: FamilySetup_Status.joinFamilyError,
          setErrorMessage: () => e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onLoadFamily(
    FamilySetup_Event_LoadFamily event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FamilySetup_Status.loadFamilyInProgress,
          isLoading: true,
        ),
      );

      final family = await _familiesRepository.getUserFamily();

      emit(
        state.copyWith(
          status: FamilySetup_Status.loadFamilySuccess,
          family: family,
          isLoading: false,
          setErrorMessage: () => null,
        ),
      );

      // Load family members if family exists
      if (family != null) {
        add(FamilySetup_Event_LoadFamilyMembers());
      }
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: FamilySetup_Status.loadFamilyError,
          setErrorMessage: () => e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onLoadFamilyMembers(
    FamilySetup_Event_LoadFamilyMembers event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      final familyMembers = await _familiesRepository.getFamilyMembers();

      emit(
        state.copyWith(
          familyMembers: familyMembers,
          setErrorMessage: () => null,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(state.copyWith(setErrorMessage: () => e.toString()));
    }
  }

  Future<void> _onLeaveFamily(
    FamilySetup_Event_LeaveFamily event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FamilySetup_Status.leaveFamilyInProgress,
          isLoading: true,
        ),
      );

      await _familiesRepository.leaveFamily();

      // Get updated user profile
      final userProfile = await _familiesRepository.getCurrentUserProfile();

      emit(
        state.copyWith(
          status: FamilySetup_Status.leaveFamilySuccess,
          userProfile: userProfile,
          family: null,
          familyMembers: const [],
          isLoading: false,
          setErrorMessage: () => null,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: FamilySetup_Status.leaveFamilyError,
          setErrorMessage: () => e.toString(),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onUpdateDisplayName(
    FamilySetup_Event_UpdateDisplayName event,
    Emitter<FamilySetup_State> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FamilySetup_Status.updateDisplayNameInProgress,
          isLoading: true,
        ),
      );

      await _familiesRepository.updateDisplayName(
        displayName: event.displayName,
      );

      // Get updated user profile
      final userProfile = await _familiesRepository.getCurrentUserProfile();

      emit(
        state.copyWith(
          status: FamilySetup_Status.updateDisplayNameSuccess,
          userProfile: userProfile,
          isLoading: false,
          setErrorMessage: () => null,
        ),
      );
    } catch (e, stackTrace) {
      log.warning('${event.runtimeType}: error', e, stackTrace);
      emit(
        state.copyWith(
          status: FamilySetup_Status.updateDisplayNameError,
          setErrorMessage: () => e.toString(),
          isLoading: false,
        ),
      );
    }
  }
}
