import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/publication/media.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
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

  void onDonePressed() async {
    if (isBusy) return;
    viewData.name = nameController.text;
    viewData.description = descriptionController.text;

    if (!_allDetailsSpecified()) return;
    _onCreateHub();
    _navigationService.back();
  }

  void _onCreateHub() async {
    setBusy(true);
    notifyListeners();
    try {
      await _hubRepository.createHub(
        name: viewData.name!,
        description: viewData.description!,
        picture: MediaFile(
          path: viewData.pictureUrl!,
          type: MediaType.image,
        ),
        isPrivate: false,
      );
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
    if (viewData.pictureUrl == null) {
      AppSnackBar.showSnackBarError(Strings.errorHubPictureMustBeSpecified);
      return false;
    }
    if (viewData.description == null || viewData.description!.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.errorHubDescMustBeSpecified);
      return false;
    }
    return true;
  }

  onHubPictureSelected() async {
    PickedFile? pickedImage = await _getImage();
    if (pickedImage == null) return;
    File? croppedImage = await _cropImage(pickedImage.path);
    if (croppedImage == null) return;

    viewData.pictureUrl = croppedImage.path;
    notifyListeners();
  }

  Future<PickedFile?> _getImage() =>
      _picker.getImage(source: ImageSource.gallery);

  Future<File?> _cropImage(String imagePath) => ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatio: CropAspectRatio(
          ratioX: Dimens.hubPictureRatioX, ratioY: Dimens.hubPictureRatioY),
      androidUiSettings: AndroidUiSettings(
        activeControlsWidgetColor: AppColors.primaryColor,
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
}
