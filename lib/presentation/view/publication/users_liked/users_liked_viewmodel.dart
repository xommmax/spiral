import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';

class UsersLikedViewModel extends StreamViewModel<List<User>> {
  final List<String> userIds;

  UsersLikedViewModel({required this.userIds});

  final UserRepository _getUsersInteractor = locator<UserRepository>();

 @override
  Stream<List<User>> get stream => _getUsersInteractor.getUsers(userIds);

  @override
  void onError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetUsers);
    super.onError(error);
  }
}
