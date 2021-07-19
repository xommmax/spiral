import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_publication_viewdata.dart';

class NewPublicationViewModel extends BaseViewModel {
  final String hubId;

  NewPublicationViewModel(this.hubId);

  final NavigationService _navigationService = locator<NavigationService>();
  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();

  final NewPublicationViewData viewData = NewPublicationViewData();
  final TextEditingController publicationTextController =
      TextEditingController();
  final _picker = ImagePicker();

  onDonePressed() {
    if (publicationTextController.text.isEmpty && viewData.mediaFiles.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.errorPublicationCannotBeEmpty);
      return;
    }
    _publicationRepository.createPublication(
      hubId: hubId,
      text: publicationTextController.text,
      mediaFiles: viewData.mediaFiles,
    );
    _navigationService.back(result: true);
  }

  onGallerySelected() =>
      _openMediaFile(RetrieveType.image, ImageSource.gallery);

  onCameraSelected() => _openMediaFile(RetrieveType.image, ImageSource.camera);

  onVideoCameraSelected() =>
      _openMediaFile(RetrieveType.video, ImageSource.camera);

  onVideoGallerySelected() =>
      _openMediaFile(RetrieveType.video, ImageSource.gallery);

  onMediaItemRemoveClicked(int position) {
    viewData.mediaFiles.removeAt(position);
    notifyListeners();
  }

  _openMediaFile(RetrieveType type, ImageSource source) async {
    switch (type) {
      case RetrieveType.image:
        {
          await _getImage(source);
          break;
        }
      case RetrieveType.video:
        {
          await _getVideo(source);
          break;
        }
    }
    notifyListeners();
  }

  _getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      await _picker
          .getImage(
        source: source,
      )
          .then((result) {
        if (result != null) {
          viewData.mediaFiles.add(
            MediaFile(
              path: result.path,
              type: MediaType.image,
            ),
          );
        }
      });
    } else {
      await _picker.getMultiImage().then((result) {
        if (result != null) {
          viewData.mediaFiles += result
              .map((file) => MediaFile(
                    path: file.path,
                    type: MediaType.image,
                  ))
              .toList();
        }
      });
    }
  }

  _getVideo(ImageSource source) async {
    await _picker
        .getVideo(
      source: source,
    )
        .then((result) {
      if (result != null) {
        viewData.mediaFiles.add(
          MediaFile(
            path: result.path,
            type: MediaType.video,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    publicationTextController.dispose();
    super.dispose();
  }
}
