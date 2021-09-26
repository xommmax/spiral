import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/explore/explore_repository.dart';
import 'package:dairo/presentation/view/explore/explore_viewdata.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ExploreViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ExploreRepository _exploreRepository = locator<ExploreRepository>();
  final ExploreViewData viewData = ExploreViewData();

  ExploreViewModel() {
    getExplorePublications();
  }

  getExplorePublications() async {
    viewData.explorePublications =
        await _exploreRepository.getExplorePublications();
    notifyListeners();
  }

  onSearchPressed() => _navigationService.navigateTo(Routes.searchView);

  onPublicationClicked(Publication publication) {
    _navigationService.navigateTo(
      Routes.publicationView,
      arguments: PublicationViewArguments(
        publicationId: publication.id,
        userId: publication.userId,
        hubId: publication.hubId,
      ),
    );
  }
}
