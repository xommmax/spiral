import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/repository/user_remote_repository.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/data/db/repository/user_local_repository.dart';
import 'package:dairo/domain/model/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteRepository _remote = locator<UserRemoteRepository>();
  final UserLocalRepository _local = locator<UserLocalRepository>();

  @override
  Stream<User?> getUser() =>
      _local.getUser().map((itemData) => User.fromItemData(itemData!));

  @override
  void refreshUser() => _remote.fetchUser().then(
      (response) => _local.updateUser(UserItemData.fromResponse(response!)));
}
