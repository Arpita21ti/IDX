// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['Authorization'],
    requiredKeys: const ['Authorization'],
    disallowNullValues: const ['Authorization'],
  );
  return LoginResponseModel(
    authorization: json['Authorization'] as String,
  );
}
