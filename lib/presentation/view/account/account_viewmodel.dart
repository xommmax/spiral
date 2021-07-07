import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountViewModel extends StreamViewModel<User?> {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  User? user;

  @override
  Stream<User?> get stream => _userRepository.getUserStream().map(
        (event) => event.error != null
            ? AppSnackBar.showSnackBarError(Strings.errorUnableToGetCurrentUser)
            : event.data,
      );

  @override
  void onData(User? data) async {
    if (data != null) {
      user = data;
      notifyListeners();
    }
    super.onData(data);
  }

  createHub() => _navigationService.navigateTo(Routes.hubCreationView);

  @override
  void dispose() {
    super.dispose();
  }
}
