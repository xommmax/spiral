import 'package:dairo/app/locator.dart';
import 'package:dairo/data/api/model/request/user_request.dart';
import 'package:dairo/data/api/model/response/user_response.dart';
import 'package:dairo/data/api/repository/user_remote_repository.dart';
import 'package:dairo/data/db/entity/user_item_data.dart';
import 'package:dairo/data/db/repository/user_local_repository.dart';
import 'package:dairo/domain/model/base/result.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteRepository _remote = locator<UserRemoteRepository>();
  final UserLocalRepository _local = locator<UserLocalRepository>();

  @override
  Future<Result<User?>> getUser() async {
    UserItemData? itemData = await _local.getUser();
    if (itemData != null) {
      return Result()..data = User.fromItemData(itemData);
    }
    return Result();
  }

  @override
  Stream<Result<User?>> getUserStream() =>
      _local.getUserStream().map((itemData) {
        if (itemData != null) {
          return Result()..data = User.fromItemData(itemData);
        }
        return Result();
      });

  @override
  Future<void> updateUser(User user) async {
    try {
      await _remote.updateUser(UserRequest.fromDomain(user));
      UserResponse? response = await _remote.fetchUser(user.uid);
      if (response != null) {
        _local.updateUser(UserItemData.fromResponse(response));
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  @override
  void deleteUser() => _local.deleteUser();
}
