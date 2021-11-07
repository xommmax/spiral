import 'package:carousel_slider/carousel_controller.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/explore/explore_repository.dart';
import 'package:dairo/presentation/view/explore/explore_viewdata.dart';
import 'package:dairo/presentation/view/main/main_nav_service.dart';
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@LazySingleton()
class ExploreViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ExploreRepository _exploreRepository = locator<ExploreRepository>();
  final ExploreViewData viewData = ExploreViewData();
  final CarouselController popularHubsCarouselController = CarouselController();
  final MainNavService mainNavService = locator<MainNavService>();

  ExploreViewModel() {
    mainNavService.exploreClickCallback = fetchExploreData;
    fetchExploreData();
  }

  void fetchExploreData() {
    getPopularHubs();
    getPopularPublications();
    getRecentPublications();
  }

  getPopularHubs() async {
    viewData.popularHubs = await _exploreRepository.getExploreHubs();
    for (int i = 0; i < viewData.popularHubs.length; i++) {
      Hub hub = viewData.popularHubs[i];
      viewData.popularHubsMediaPreviews
          .add(await _exploreRepository.getExploreHubMediaPreviews(hub.id));
    }
    try {
      popularHubsCarouselController.jumpToPage(1);
    } catch (e) {}
    notifyListeners();
  }

  getPopularPublications() async {
    viewData.popularPublications =
        await _exploreRepository.getExplorePublications();
    viewData.popularPublicationsTextControllers
        .forEach((controller) => controller.dispose());
    viewData.popularPublicationsTextControllers = [];
    viewData.popularPublications.forEach((publication) => viewData
        .popularPublicationsTextControllers
        .add(initTextController(publication)));
    notifyListeners();
  }

  getRecentPublications() async {
    viewData.recentPublications =
        await _exploreRepository.getRecentPublications();
    viewData.recentPublicationsTextControllers
        .forEach((controller) => controller.dispose());
    viewData.recentPublicationsTextControllers = [];
    viewData.recentPublications.forEach((publication) => viewData
        .recentPublicationsTextControllers
        .add(initTextController(publication)));
    notifyListeners();
  }

  onSearchPressed() => _navigationService.navigateTo(Routes.searchView);

  void onPublicationClicked(Publication publication) {
    _navigationService.navigateTo(
      Routes.publicationView,
      arguments: PublicationViewArguments(publicationId: publication.id),
    );
  }

  void onHubClicked(Hub hub) {
    _navigationService.navigateTo(
      Routes.hubView,
      arguments: HubViewArguments(
        hubId: hub.id,
        userId: hub.userId,
      ),
    );
  }

  @override
  void dispose() {
    viewData.popularPublicationsTextControllers
        .forEach((controller) => controller.dispose());
    viewData.recentPublicationsTextControllers
        .forEach((controller) => controller.dispose());
    super.dispose();
  }
}
