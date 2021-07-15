import 'dart:async';
import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/repository/publication_remote_repository.dart';
import 'package:dairo/data/db/entity/publication_item_data.dart';
import 'package:dairo/data/db/repository/publication_local_repository.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PublicationRepository)
class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationRemoteRepository _remote =
      locator<PublicationRemoteRepository>();
  final PublicationLocalRepository _local =
      locator<PublicationLocalRepository>();

  @override
  Future<void> createPublication(Publication publication) =>
      _remote.sendPublication(
        publication.toRequest(),
        publication.mediaFiles.map((media) => File(media.path)).toList(),
      );

  @override
  StreamSubscription subscribeToCurrentUserHubPublications(String hubId) =>
      _remote.listenRemotePublications(hubId).listen(
            (remotePublications) => _local.addPublications(remotePublications
            .map((response) => PublicationItemData.fromResponse(response))
            .toList()),
      );

  @override
  Stream<List<Publication>> getUserPublicationsStream(String hubId) => _local
      .getUserPublicationsStream(
        hubId,
      )
      .map((itemDataList) => itemDataList
          .map((itemData) => Publication.fromItemData(itemData))
          .toList());
}
