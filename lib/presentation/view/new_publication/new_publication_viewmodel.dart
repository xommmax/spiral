import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart' as media;
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/enums.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/media.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_publication_viewdata.dart';

class NewPublicationViewModel extends BaseViewModel {
  static const String createHubItemValue = 'createHubItemValue';
  static const int maxMediaSize = 9;
  String? hubId;
  int mediaPreviewTypeIndex = 0;
  List<Media> mediaList = [];
  media.MediaViewType mediaViewType = media.MediaViewType.values[0];
  int currentMediaCarouselIndex = 0;
  final CarouselController buttonCarouselController = CarouselController();

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

    _publicationRepository.createPublication(
      hubId: hubId!,
      text: publicationTextController.text,
      mediaFiles: viewData.mediaFiles,
      viewType: mediaViewType,
    );

    _navigationService.back(result: true);
  }

  void onHubSelected(String? hubId) {
    if (hubId == createHubItemValue) {
      _navigationService.navigateTo(Routes.newHubView)?.then((result) {
        if (result != null && result is String) {
          this.hubId = result;
          onDonePressed();
        }
      });
      return;
    }
    this.hubId = hubId;
    onDonePressed();
  }

  void onMediaItemRemoveClicked(int position) {
    viewData.mediaFiles.removeAt(position);
    notifyListeners();
  }

  @override
  void dispose() {
    publicationTextController.dispose();
    super.dispose();
  }

  void onMediaPreviewTypeIndexChanged(int index) {
    mediaPreviewTypeIndex = index;
    mediaViewType = media.MediaViewType.values[index];
    notifyListeners();
  }

  void updateMediaList(List<Media> mediaList) {
    this.mediaList = mediaList;
    viewData.mediaFiles = mediaList.map((file) {
      String path = file.file!.path;
      media.MediaType mediaType = file.mediaType == MediaType.image
          ? media.MediaType.image
          : media.MediaType.video;
      return media.MediaFile(path: path, type: mediaType);
    }).toList();
    notifyListeners();
  }

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    currentMediaCarouselIndex = index;
    notifyListeners();
  }

  void removeMedia(int position) {
    mediaList.removeAt(position);
    viewData.mediaFiles.removeAt(position);
    if (currentMediaCarouselIndex > mediaList.length - 1 &&
        currentMediaCarouselIndex > 0) {
      currentMediaCarouselIndex = mediaList.length - 1;
    }
    notifyListeners();
  }
}
