import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';

class HubViewModel extends StreamViewModel<List<Publication>> {
  final String hubId;

  HubViewModel({
    required this.hubId,
  });

  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();

  @override
  void initialise() {
    _publicationRepository.refreshPublications(hubId);
    super.initialise();
  }

  @override
  Stream<List<Publication>> get stream =>
      _publicationRepository.getUserPublicationsStream(hubId);

  @override
  void onData(List<Publication>? data) {
    print('publications received: $data');
  }

  @override
  void onError(error) {
    AppSnackBar.showSnackBarError(Strings.unableToGetPublications);
    super.onError(error);
  }
}
