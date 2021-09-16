import 'package:dairo/app/analytics.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/model/publication/publication.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_publication_viewdata.dart';

class NewPublicationViewModel extends BaseViewModel {
  static const String createHubItemValue = 'createHubItemValue';
  String? hubId;

  NewPublicationViewModel(this.hubId) {
    if (hubId == null) {
      _getHubs();
    }
  }

  final NavigationService _navigationService = locator<NavigationService>();
  final PublicationRepository _publicationRepository =
      locator<PublicationRepository>();
  final HubRepository _hubRepository = locator<HubRepository>();

  final NewPublicationViewData viewData = NewPublicationViewData();
  final TextEditingController publicationTextController =
      TextEditingController();
  final _picker = ImagePicker();

  List<Hub> hubs = [];

  Future<void> _getHubs() =>
      _hubRepository.getCurrentUserHubs().first.then((hubs) {
        this.hubs = hubs;
        notifyListeners();
      });

  void onDonePressed() async {
    if (publicationTextController.text.isEmpty && viewData.mediaFiles.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.errorPublicationCannotBeEmpty);
      return;
    }

    _publicationRepository
        .createPublication(
      hubId: hubId!,
      text: publicationTextController.text,
      mediaFiles: viewData.mediaFiles,
    );

    await Future.delayed(
      Duration(seconds: 1),
      () async => _navigationService.back(result: true),
    );
  }

  void onHubSelected(String? hubId) {
    if (hubId == createHubItemValue) {
      _navigationService.navigateTo(Routes.newHubView)?.then((result) {
        if (result != null && result is String) {
          _getHubs();
        }
      });
      return;
    }
    this.hubId = hubId;
    onDonePressed();
  }

  void onGallerySelected() =>
      _openMediaFile(RetrieveType.image, ImageSource.gallery);

  void onCameraSelected() =>
      _openMediaFile(RetrieveType.image, ImageSource.camera);

  void onVideoCameraSelected() =>
      _openMediaFile(RetrieveType.video, ImageSource.camera);

  void onVideoGallerySelected() =>
      _openMediaFile(RetrieveType.video, ImageSource.gallery);

  void onMediaItemRemoveClicked(int position) {
    viewData.mediaFiles.removeAt(position);
    notifyListeners();
  }

  void _openMediaFile(RetrieveType type, ImageSource source) async {
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
          .then(
        (result) {
          if (result != null) {
            viewData.mediaFiles.add(
              MediaFile(
                path: result.path,
                type: MediaType.image,
              ),
            );
          }
        },
      );
    } else {
      await _picker.getMultiImage().then(
        (result) {
          if (result != null) {
            viewData.mediaFiles += result
                .map((file) => MediaFile(
                      path: file.path,
                      type: MediaType.image,
                    ))
                .toList();
          }
        },
      );
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
