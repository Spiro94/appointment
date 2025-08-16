import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@JsonSerializable()
class Model_Family extends Equatable {
  const Model_Family({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  @JsonKey(name: 'invite_code')
  final String inviteCode;
  @JsonKey(name: 'owner_id')
  final String ownerId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  factory Model_Family.fromJson(Map<String, dynamic> json) =>
      _$Model_FamilyFromJson(json);

  Map<String, dynamic> toJson() => _$Model_FamilyToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    inviteCode,
    ownerId,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class Model_UserProfile extends Equatable {
  const Model_UserProfile({
    required this.id,
    this.familyId,
    this.email,
    this.displayName,
    required this.hasCompletedFamilySetup,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  @JsonKey(name: 'family_id')
  final String? familyId;
  final String? email;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'has_completed_family_setup')
  final bool hasCompletedFamilySetup;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  factory Model_UserProfile.fromJson(Map<String, dynamic> json) =>
      _$Model_UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$Model_UserProfileToJson(this);

  Model_UserProfile copyWith({
    String? id,
    String? familyId,
    String? email,
    String? displayName,
    bool? hasCompletedFamilySetup,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Model_UserProfile(
      id: id ?? this.id,
      familyId: familyId ?? this.familyId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      hasCompletedFamilySetup:
          hasCompletedFamilySetup ?? this.hasCompletedFamilySetup,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    familyId,
    email,
    displayName,
    hasCompletedFamilySetup,
    createdAt,
    updatedAt,
  ];
}
