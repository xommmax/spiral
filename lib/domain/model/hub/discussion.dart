class HubDiscussion {
  final int? createdAt;
  final String id;
  final String? imageUrl;
  final String? name;
  final int? updatedAt;

  const HubDiscussion({
    required this.id,
    this.createdAt,
    this.imageUrl,
    this.name,
    this.updatedAt,
  });

  HubDiscussion.fromJson(Map json, String id)
      : this.createdAt = json['createdAt']?.millisecondsSinceEpoch,
        this.id = id,
        this.updatedAt = json['updatedAt']?.millisecondsSinceEpoch,
        this.imageUrl = json['imageUrl'] as String?,
        this.name = json['name'] as String?;
}
