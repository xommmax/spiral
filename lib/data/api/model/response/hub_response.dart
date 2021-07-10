import 'package:json_annotation/json_annotation.dart';

part 'hub_response.g.dart';

@JsonSerializable()
class HubResponse {
  final String id;
  final String name;
  final String pictureUrl;
  final String description;
  final String userId;

  const HubResponse({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
    required this.userId,
  });

  factory HubResponse.fromJson(
    String id,
    Map<String, dynamic> json,
  ) {
    json['id'] = id;
    return _$HubResponseFromJson(json);
  }
}
