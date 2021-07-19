import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class UserProfileViewModel extends BaseProfileViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final String userId;

  UserProfileViewModel(this.userId);

  @override
  Stream<User?> userStream() => userRepository.getUser(userId);

  @override
  Stream<List<Hub>> hubListStream() => hubRepository.getUserHubs(userId);
}
