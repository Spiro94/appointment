// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Family _$Model_FamilyFromJson(Map<String, dynamic> json) => Model_Family(
  id: json['id'] as String,
  name: json['name'] as String,
  inviteCode: json['invite_code'] as String,
  ownerId: json['owner_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$Model_FamilyToJson(Model_Family instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'invite_code': instance.inviteCode,
      'owner_id': instance.ownerId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

Model_UserProfile _$Model_UserProfileFromJson(Map<String, dynamic> json) =>
    Model_UserProfile(
      id: json['id'] as String,
      familyId: json['family_id'] as String?,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      hasCompletedFamilySetup: json['has_completed_family_setup'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$Model_UserProfileToJson(Model_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'family_id': instance.familyId,
      'email': instance.email,
      'display_name': instance.displayName,
      'has_completed_family_setup': instance.hasCompletedFamilySetup,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
