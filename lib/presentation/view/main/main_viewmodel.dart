import 'package:dairo/app/analytics.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final AnalyticsRepository _analyticsRepository = locator<AnalyticsRepository>();
  int previousTab = -1;

  onFabPressed() async {
    if (_userRepository.isCurrentUserExist()) {
      _navigationService.navigateTo(Routes.newPublicationView);
    } else {
      _navigationService.navigateTo(Routes.authView)?.then((result) {
        if (result != null && result is bool && result) {
          _navigationService.navigateTo(Routes.newPublicationView);
        }
      });
    }
  }

  @override
  void setIndex(int value) {
    if (previousTab == -1 || previousTab != value) {
      previousTab = value;
      _sendCurrentTabToAnalytics(value);
    }
    super.setIndex(value);
  }

  void _sendCurrentTabToAnalytics(int value) {
    final currentTabName = value == 0 ? Routes.homeView : Routes.exploreView;
    _analyticsRepository.setCurrentScreen(
      screenName: currentTabName,
    );
  }
}
