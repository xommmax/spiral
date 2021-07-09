import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'hub')
class HubItemData {
  @primaryKey
  final String id;
  final String name;
  final String pictureUrl;
  final String description;
  final String userId;

  const HubItemData({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
    required this.userId,
  });

  factory HubItemData.fromResponse(HubResponse response) => HubItemData(
        id: response.id,
        name: response.name,
        pictureUrl: response.pictureUrl,
        description: response.description,
        userId: response.userId,
      );
}
