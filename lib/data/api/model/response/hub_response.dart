import 'package:json_annotation/json_annotation.dart';

part 'hub_response.g.dart';

@JsonSerializable()
class HubResponse {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String? pictureUrl;
  final int createdAt;
  final int followersCount;
  final bool isFollow;
  final bool isPrivate;
  final bool isDiscussionEnabled;
  final int orderIndex;

  HubResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.createdAt,
    required this.followersCount,
    required this.isFollow,
    required this.orderIndex,
    required this.isPrivate,
    required this.isDiscussionEnabled,
  });

  factory HubResponse.fromJson(
    Map<String, dynamic>? json, {
    required String id,
    required bool isFollow,
  }) {
    json = json ?? {};
    json['id'] = id;
    json['isFollow'] = isFollow;
    json['followersCount'] ??= 0;
    return _$HubResponseFromJson(json);
  }

  @override
  String toString() {
    return 'HubResponse{id: $id, userId: $userId, name: $name, description: $description, pictureUrl: $pictureUrl, createdAt: $createdAt, followersCount: $followersCount, isFollow: $isFollow, isPrivate: $isPrivate, isDiscussionEnabled: $isDiscussionEnabled, orderIndex: $orderIndex}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HubResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          description == other.description &&
          pictureUrl == other.pictureUrl &&
          createdAt == other.createdAt &&
          followersCount == other.followersCount &&
          isFollow == other.isFollow &&
          isPrivate == other.isPrivate &&
          isDiscussionEnabled == other.isDiscussionEnabled &&
          orderIndex == other.orderIndex;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      pictureUrl.hashCode ^
      createdAt.hashCode ^
      followersCount.hashCode ^
      isFollow.hashCode ^
      isPrivate.hashCode ^
      isDiscussionEnabled.hashCode ^
      orderIndex.hashCode;
}
