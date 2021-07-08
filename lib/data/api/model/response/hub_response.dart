import 'package:json_annotation/json_annotation.dart';

part 'hub_response.g.dart';

@JsonSerializable()
class HubResponse {
  final String id;
  final String name;
  final String pictureUrl;
  final String description;

  const HubResponse({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
  });

  factory HubResponse.fromJson(Map<String, dynamic> json) =>
      _$HubResponseFromJson(json);
}
