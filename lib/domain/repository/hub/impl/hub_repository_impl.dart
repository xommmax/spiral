import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/repository/hub_remote_repository.dart';
import 'package:dairo/data/db/entity/hub_item_data.dart';
import 'package:dairo/data/db/repository/hub_local_repository.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HubRepository)
class HubRepositoryImpl implements HubRepository {
  final HubRemoteRepository _remote = locator<HubRemoteRepository>();
  final HubLocalRepository _local = locator<HubLocalRepository>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> createHub(Hub hub) async {
    final String? userId = _auth.currentUser?.uid;
    if (userId == null) throw UnauthorizedException();

    await _remote.createHub(hub.toRequest(userId), File(hub.pictureUrl));
  }

  @override
  void refreshHubs({String? userId}) => _remote.listenRemoteHubs(userId ?? _auth.currentUser!.uid).listen(
        (remoteHubs) => _local.addHubs(remoteHubs
        .map((response) => HubItemData.fromResponse(response))
        .toList()),
  );

  @override
  Stream<List<Hub>> getUserHubsStream({String? userId}) => _local
      .getUserHubsStream(userId ?? _auth.currentUser!.uid)
      .map((itemDataList) =>
          itemDataList.map((itemData) => Hub.fromItemData(itemData)).toList());
}
