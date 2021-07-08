import 'package:json_annotation/json_annotation.dart';

part 'hub_request.g.dart';

@JsonSerializable()
class HubRequest {
  final String userId;
  final String name;
  String? pictureUrl;
  final String description;

  HubRequest({
    required this.userId,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => _$HubRequestToJson(this);
}
