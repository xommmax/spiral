import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/analytics/analytics_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AnalyticsRepository _analyticsRepository =
      locator<AnalyticsRepository>();
  int previousTab = -1;

  onFabPressed() =>
      _navigationService.navigateTo(Routes.newPubHubSelectionView);

  @override
  void setIndex(int value) {
    if (previousTab == -1 || previousTab != value) {
      previousTab = value;
      _sendCurrentTabToAnalytics(value);
    }
    super.setIndex(value);
  }

  void _sendCurrentTabToAnalytics(int value) {
    final currentTabName = value == 0 ? '/home-view' : '/explore-view';
    _analyticsRepository.setCurrentScreen(
      screenName: currentTabName,
    );
  }
}
