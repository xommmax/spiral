import 'package:json_annotation/json_annotation.dart';

part 'hub_request.g.dart';

@JsonSerializable()
class HubRequest {
  final String name;
  final String pictureUrl;
  final String description;

  const HubRequest(
      {required this.name,
      required this.pictureUrl,
      required this.description});

  Map<String, dynamic> toJson() => _$HubRequestToJson(this);
}
