import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:stacked/stacked.dart';

abstract class BaseProfileViewModel extends MultipleStreamViewModel {
  final UserRepository _userRepository = locator<UserRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();
  User? user;
  List<Hub>? hubList;

  @override
  Map<String, StreamData> get streamsMap => {
        _UserStreamKey: StreamData<User?>(userStream(), onData: _onUserData),
        _HubListStreamKey:
            StreamData<List<Hub>?>(hubListStream(), onData: _obHubListData),
      };

  Stream<User?> userStream() => _userRepository.getCurrentUserStream();

  Stream<List<Hub>> hubListStream() => _hubRepository.getUserHubListStream();

  _onUserData(User? data) => user = data;

  _obHubListData(List<Hub> data) => hubList = data;
}

const String _UserStreamKey = 'userStream';
const String _HubListStreamKey = 'hubListStream';
