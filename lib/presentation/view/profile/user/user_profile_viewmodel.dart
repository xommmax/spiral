import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';

class UserProfileViewModel extends BaseProfileViewModel {
  final String userId;
  final SupportRepository _supportRepository = locator<SupportRepository>();

  UserProfileViewModel(this.userId);

  @override
  Stream<User?> userStream() => userRepository.getUser(userId);

  @override
  Stream<List<Hub>> hubListStream() => hubRepository.getHubs(userId);

  onReport() {
    _supportRepository.reportUser(userId: userId, reason: "TODO");
    AppSnackBar.showSnackBarSuccess(Strings.reportSubmitted);
  }
}
