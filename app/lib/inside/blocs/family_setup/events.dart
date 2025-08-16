abstract class FamilySetup_Event {}

class FamilySetup_Event_CheckSetupStatus extends FamilySetup_Event {}

class FamilySetup_Event_CreateFamily extends FamilySetup_Event {
  FamilySetup_Event_CreateFamily({required this.familyName});
  final String familyName;
}

class FamilySetup_Event_JoinFamily extends FamilySetup_Event {
  FamilySetup_Event_JoinFamily({required this.inviteCode});
  final String inviteCode;
}

class FamilySetup_Event_LoadFamily extends FamilySetup_Event {}

class FamilySetup_Event_LoadFamilyMembers extends FamilySetup_Event {}

class FamilySetup_Event_LeaveFamily extends FamilySetup_Event {}

class FamilySetup_Event_UpdateDisplayName extends FamilySetup_Event {
  FamilySetup_Event_UpdateDisplayName({required this.displayName});
  final String displayName;
}
