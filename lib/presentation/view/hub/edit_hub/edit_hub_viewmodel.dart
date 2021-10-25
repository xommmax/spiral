import 'dart:io';

import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/hub/edit_hub/edit_hub_view_data.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditHubViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final _picker = ImagePicker();
  final EditHubViewData viewData = EditHubViewData();
  final Hub hub;

  EditHubViewModel(Hub hub)
      : this.hub = hub,
        nameController = TextEditingController(text: hub.name),
        descriptionController = TextEditingController(text: hub.description) {
    viewData.pictureUrl = hub.pictureUrl;
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

  void onDonePressed() {
    _navigationService.back();
  }
}
