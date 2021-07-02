import 'package:dairo/app/locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_publication_viewdata.dart';

class NewPublicationViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final NewPublicationViewData viewData = NewPublicationViewData();

  final _picker = ImagePicker();

  onDonePressed() {
    //TODO: Implement data sending into Firestore
  }

  onGallerySelected() => _openPicker(ImageSource.gallery);

  onCameraSelected() => _openPicker(ImageSource.camera);

  onItemRemoveClicked(int position) {
    viewData.imagesList.removeAt(position);
    notifyListeners();
  }

  _openPicker(ImageSource source) async {
    if (source == ImageSource.camera) {
      await _picker
          .getImage(
            source: source,
          )
          .then((result) =>
              viewData.imagesList += result != null ? [result.path] : []);
    } else {
      await _picker.getMultiImage().then(
            (result) => viewData.imagesList +=
                result?.map((file) => file.path).toList() ?? [],
          );
    }
    notifyListeners();
    _navigationService.back();
  }
}
