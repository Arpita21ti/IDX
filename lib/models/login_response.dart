import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(
  disallowUnrecognizedKeys: true,
  ignoreUnannotated: true,
  includeIfNull: false,
  createToJson: false, // Will not generate toJSON
)
class LoginResponseModel {
  @JsonKey(
    disallowNullValue: true,
    includeToJson: false,
    required: true,
    name: 'Authorization',
  )
  final String authorization;

  //  CAn add fields if required further.

  LoginResponseModel({
    required this.authorization,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
