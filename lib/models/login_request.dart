import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(
  disallowUnrecognizedKeys: true,
  ignoreUnannotated: true,
  includeIfNull: false,
  createFactory: false, // Will not generate fromJSON
)
class LoginRequestModel {
  @JsonKey(disallowNullValue: true, includeFromJson: false, required: true)
  final String enrollmentNo;

  @JsonKey(disallowNullValue: true, includeFromJson: false, required: true)
  final String email;

  @JsonKey(disallowNullValue: true, includeFromJson: false, required: true)
  final String phone;

  @JsonKey(disallowNullValue: true, includeFromJson: false, required: true)
  final String password;

  LoginRequestModel({
    required this.enrollmentNo,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
