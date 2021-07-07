import 'package:dairo/data/api/model/response/hub_response.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'hub')
class HubItemData {
  @primaryKey
  final String id;
  final String name;
  final String pictureUrl;
  final String description;

  const HubItemData({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
  });

  factory HubItemData.fromResponse(HubResponse response) => HubItemData(
        id: response.id,
        name: response.name,
        pictureUrl: response.pictureUrl,
        description: response.description,
      );
}
