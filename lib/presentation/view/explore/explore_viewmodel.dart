import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/explore/explore_repository.dart';
import 'package:dairo/presentation/view/explore/explore_viewdata.dart';
import 'package:dairo/presentation/view/tools/publication_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@LazySingleton()
class ExploreViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ExploreRepository _exploreRepository = locator<ExploreRepository>();
  final ExploreViewData viewData = ExploreViewData();

  ExploreViewModel() {
    getExplorePublications();
    getExploreHubs();
  }

  getExplorePublications() async {
    viewData.explorePublications =
        await _exploreRepository.getExplorePublications();
    viewData.textControllers.forEach((controller) => controller.dispose());
    viewData.textControllers = [];
    viewData.explorePublications.forEach((publication) =>
        viewData.textControllers.add(initTextController(publication)));
    notifyListeners();
  }

  getExploreHubs() async {
    viewData.exploreHubs = await _exploreRepository.getExploreHubs();
    for (int i = 0; i < viewData.exploreHubs.length; i++) {
      Hub hub = viewData.exploreHubs[i];
      viewData.exploreHubMediaPreviews
          .add(await _exploreRepository.getExploreHubMediaPreviews(hub.id));
    }
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
    viewData.textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
