import 'dart:async';
import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/like_publication_request.dart';
import 'package:dairo/data/api/model/request/publication_request.dart';
import 'package:dairo/data/api/model/response/publication_response.dart';
import 'package:dairo/data/api/repository/publication_remote_repository.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:dairo/data/db/repository/publication_local_repository.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PublicationRepository)
class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationRemoteRepository _remote =
      locator<PublicationRemoteRepository>();
  final PublicationLocalRepository _local =
      locator<PublicationLocalRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  @override
  Future<void> createPublication({
    required String hubId,
    String? text,
    List<MediaFile>? mediaFiles,
  }) async {
    _userRepository.checkAndGetCurrentUserId();
    var media = mediaFiles?.map((e) => File(e.path)).toList();
    PublicationRequest request = PublicationRequest(
      hubId: hubId,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    PublicationResponse response =
        await _remote.createPublication(request, media);
    await _local.addPublication(PublicationItemData.fromResponse(response));
  }

  Stream<List<Publication>> getHubPublications(String hubId) {
    Stream<List<Publication>> stream = _local.getHubPublications(hubId).map(
        (itemData) =>
            itemData.map((e) => Publication.fromItemData(e)).toList());

    _remote.fetchPublications(hubId).then((response) {
      var itemData =
          response.map((e) => PublicationItemData.fromResponse(e)).toList();
      _local.addPublications(itemData);
    });
    return stream;
  }

  @override
  Future<void> sendLike({
    required String publicationId,
    required String userId,
    required bool isLiked,
  }) =>
      _remote
          .sendLike(
            LikePublicationRequest(
              publicationId: publicationId,
              userId: userId,
              isLiked: isLiked,
            ),
          )
          .then(
            (PublicationResponse response) => _local.addPublication(
              PublicationItemData.fromResponse(response),
            ),
          );
}
