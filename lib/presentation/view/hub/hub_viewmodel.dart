import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/hub/hub_viewdata.dart';
import 'package:dairo/presentation/view/hub/widgets/appbar_hub.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HubViewModel extends StreamViewModel<List<Publication>> {
  final Hub hub;
  final User user;

  HubViewModel({
    required this.hub,
    required this.user,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final HubViewData viewData = HubViewData();

  @override
  Stream<List<Publication>> get stream =>
      _publicationRepository.getHubPublications(hub.id);

  @override
  void onData(List<Publication>? data) => _onPublicationsRetrieved(data ?? []);

  @override
  void onError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetPublications);
    super.onError(error);
  }

  void _onPublicationsRetrieved(List<Publication> publications) =>
    viewData.publications = publications;

  void onCreatePublicationClicked() => _navigationService.navigateTo(
        Routes.newPublicationView,
        arguments: NewPublicationViewArguments(hubId: hub.id),
      );

  void onMenuItemClicked(HubMenuItem? item) {}

  void onPublicationLikeClicked(String publicationId, bool isLiked) =>
      _publicationRepository.sendLike(
        publicationId: publicationId,
        userId: user.id,
        isLiked: isLiked,
      );

  void onUsersLikedScreenClicked(String publicationId) async {
    List<String> userIds =
        await _publicationRepository.getUsersLiked(publicationId);
    return _navigationService.navigateTo(
      Routes.usersLikedView,
      arguments: UsersLikedViewArguments(userIds: userIds),
    );
  }

  void onPublicationDetailsClicked(Publication publication) =>
      _navigationService.navigateTo(
        Routes.publicationView,
        arguments: PublicationViewArguments(
          publicationId: publication.id,
          userId: publication.userId,
        ),
      );
}
