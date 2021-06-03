

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends StreamViewModel {
    final UserRepository _userRepository = locator<UserRepository>();

    @override
    Stream<User?> get stream => _userRepository.getUser();


    @override
  void onError(error) {
    print(error);
    super.onError(error);
  }
}