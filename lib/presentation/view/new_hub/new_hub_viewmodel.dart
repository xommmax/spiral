import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'new_hub_viewdata.dart';

class NewHubViewModel extends BaseViewModel {
  final HubRepository _hubRepository = locator<HubRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _picker = ImagePicker();
  final NewHubViewData viewData = NewHubViewData();
  bool isPrivate = false;
  bool isDiscussionEnabled = true;
  int pageIndex = 0;
  Future<String>? hubPictureFuture;

  void onDonePressed() {
    if (isBusy) return;
    _onCreateHub();
  }

  void onNextPressed() {
    viewData.name = nameController.text.isNotEmpty ? nameController.text : null;
    viewData.description = descriptionController.text.isNotEmpty
        ? descriptionController.text
        : null;

    if (!_allDetailsSpecified()) return;

    if (viewData.pictureUrl != null) {
      LocalMediaFile picture = LocalMediaFile(
        id: null,
        originalFile: File(viewData.pictureUrl!),
        previewImage: File(viewData.pictureUrl!),
        type: MediaType.image,
      );
      hubPictureFuture = _hubRepository.uploadHubPicture(picture);
    }

    pageIndex = 1;
    notifyListeners();
  }

  void _onCreateHub() async {
    setBusy(true);
    notifyListeners();
    String? pictureUrl;
    if (hubPictureFuture != null) {
      pictureUrl = await hubPictureFuture;
    }
    try {
      Hub hub = await _hubRepository.createHub(
        name: viewData.name!,
        description: viewData.description,
        pictureUrl: pictureUrl,
        isPrivate: isPrivate,
        isDiscussionEnabled: isDiscussionEnabled,
      );
      _navigationService.back(result: hub);
    } catch (e) {
      AppSnackBar.showSnackBarError(e.toString());
    }
    setBusy(false);
  }

  bool _allDetailsSpecified() {
    if (viewData.name == null || viewData.name!.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.errorHubNameMustBeSpecified);
      return false;
    }
    return true;
  }

  onHubPictureSelected() async {
    PickedFile? pickedImage = await _getImage();
    if (pickedImage == null) return;
    File? croppedImage = await _cropImage(pickedImage.path);
    if (croppedImage == null) return;
    File compressedImage = await compressImage(croppedImage.path, 35);
    viewData.pictureUrl = compressedImage.path;
    notifyListeners();
  }

  Future<PickedFile?> _getImage() =>
      _picker.getImage(source: ImageSource.gallery);

  Future<File?> _cropImage(String imagePath) => ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatio: CropAspectRatio(
          ratioX: Dimens.hubPictureRatioX, ratioY: Dimens.hubPictureRatioY),
      androidUiSettings: AndroidUiSettings(
        activeControlsWidgetColor: AppColors.darkAccentColor,
      ),
      iosUiSettings: IOSUiSettings(
        rotateButtonsHidden: true,
      ));

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void onPrivateSwitchChanged(bool value) {
    isPrivate = value;
    notifyListeners();
  }

  void onDiscussionSwitchChanged(bool value) {
    isDiscussionEnabled = value;
    notifyListeners();
  }

  void onBackButtonPressed() {
    if (pageIndex == 0) {
      _navigationService.back();
    } else {
      pageIndex--;
      notifyListeners();
    }
  }
}
