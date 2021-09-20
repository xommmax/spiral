import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowersViewModel extends StreamViewModel<List<User>> {
  final List<String> userIds;
  final FollowersType type;

  FollowersViewModel({
    required this.userIds,
    required this.type,
  });

  final UserRepository _usersRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Stream<List<User>> get stream => _usersRepository.getUsers(userIds);

  void onProfileListItemClicked(User user) {
    _navigationService.navigateTo(Routes.userProfileView,
        arguments: UserProfileViewArguments(userId: user.id));
  }

  @override
  void onError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetFollowers);
    super.onError(error);
  }
}
