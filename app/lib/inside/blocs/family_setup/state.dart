import 'package:equatable/equatable.dart';

import '../../../shared/models/family.dart';

enum FamilySetup_Status {
  idle,
  loading,
  setupRequired,
  setupCompleted,
  createFamilyInProgress,
  createFamilySuccess,
  createFamilyError,
  joinFamilyInProgress,
  joinFamilySuccess,
  joinFamilyError,
  loadFamilyInProgress,
  loadFamilySuccess,
  loadFamilyError,
  leaveFamilyInProgress,
  leaveFamilySuccess,
  leaveFamilyError,
  updateDisplayNameInProgress,
  updateDisplayNameSuccess,
  updateDisplayNameError,
}

class FamilySetup_State extends Equatable {
  const FamilySetup_State({
    this.status = FamilySetup_Status.idle,
    this.userProfile,
    this.family,
    this.familyMembers = const [],
    this.errorMessage,
    this.isLoading = false,
  });

  final FamilySetup_Status status;
  final Model_UserProfile? userProfile;
  final Model_Family? family;
  final List<Model_UserProfile> familyMembers;
  final String? errorMessage;
  final bool isLoading;

  bool get needsSetup =>
      userProfile == null || !userProfile!.hasCompletedFamilySetup;

  bool get hasFamily => userProfile?.familyId != null;

  FamilySetup_State copyWith({
    FamilySetup_Status? status,
    Model_UserProfile? userProfile,
    Model_Family? family,
    List<Model_UserProfile>? familyMembers,
    String? Function()? setErrorMessage,
    bool? isLoading,
  }) {
    return FamilySetup_State(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      family: family ?? this.family,
      familyMembers: familyMembers ?? this.familyMembers,
      errorMessage: setErrorMessage != null ? setErrorMessage() : errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    status,
    userProfile,
    family,
    familyMembers,
    errorMessage,
    isLoading,
  ];
}
