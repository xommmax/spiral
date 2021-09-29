import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/publication/publication_repository.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/enums.dart'
    as picker_enums;
import 'package:dairo/presentation/view/tools/media_picker_widget/src/media.dart'
    as picker_media;
import 'package:dairo/presentation/view/tools/media_picker_widget/src/media_picker.dart';
import 'package:dairo/presentation/view/tools/media_picker_widget/src/picker_decoration.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_compress/video_compress.dart';

import 'new_publication_viewdata.dart';

class NewPublicationViewModel extends BaseViewModel {
  static const String createHubItemValue = 'createHubItemValue';
  static const int maxMediaSize = 9;
  String? hubId;
  int mediaPreviewTypeIndex = 0;
  MediaViewType mediaViewType = MediaViewType.values[0];
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

  @override
  void dispose() {
    publicationTextController.dispose();
    super.dispose();
  }

  void onMediaPreviewTypeIndexChanged(int index) {
    mediaPreviewTypeIndex = index;
    mediaViewType = MediaViewType.values[index];
    notifyListeners();
  }

  void updateMediaList(List<picker_media.Media> pickerMedia) async {
    viewData.mediaFiles = [];

    for (picker_media.Media media in pickerMedia) {
      File previewImage;
      if (media.mediaType == picker_enums.MediaType.image)
        previewImage = await compressImage(media.file!.path, 25);
      else if (media.mediaType == picker_enums.MediaType.video)
        previewImage = await _getVideoThumbnail(media.file!.path);
      else
        throw ArgumentError();

      LocalMediaFile mediaFile = LocalMediaFile(
          id: media.id,
          originalFile: media.file!,
          previewImage: previewImage,
          type: media.mediaType!.toPubMediaType());

      viewData.mediaFiles.add(mediaFile);
      notifyListeners();
    }
  }

  Future<File> _getVideoThumbnail(String path) =>
      VideoCompress.getFileThumbnail(path);

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    currentMediaCarouselIndex = index;
    notifyListeners();
  }

  void removeMedia(int position) {
    viewData.mediaFiles.removeAt(position);
    if (currentMediaCarouselIndex > viewData.mediaFiles.length - 1 &&
        currentMediaCarouselIndex > 0) {
      currentMediaCarouselIndex = viewData.mediaFiles.length - 1;
    }
    notifyListeners();
  }

  void openMediaPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MediaPicker(
            mediaList:
                viewData.mediaFiles.map((e) => e.toPickerMedia()).toList(),
            onPick: (selectedList) {
              if (selectedList.length > NewPublicationViewModel.maxMediaSize) {
                AppSnackBar.showSnackBarError(Strings.errorLimitMaxMediaSize);
                return;
              }
              updateMediaList(selectedList);
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
            mediaCount: picker_enums.MediaCount.multiple,
            decoration: PickerDecoration(
              actionBarPosition: picker_enums.ActionBarPosition.top,
              albumTitleStyle: TextStyle(
                color: AppColors.black,
              ),
              albumTextStyle: TextStyle(
                color: AppColors.black,
              ),
              completeTextStyle: TextStyle(
                color: AppColors.black,
              ),
              completeButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.lightGray),
              ),
              cancelIcon: Icon(Icons.arrow_back),
              completeText: 'Done',
            ),
          );
        });
  }
}
