import 'dart:async';

import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/details/auth_details_view_data.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@LazySingleton()
class AuthDetailsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserRepository _userRepository = locator<UserRepository>();
  final AuthDetailsViewData viewData = AuthDetailsViewData();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final bioController = TextEditingController();
  final _picker = ImagePicker();
  User? user;
  late final StreamSubscription? authStateChangesSubscription;

  AuthDetailsViewModel() {
    authStateChangesSubscription =
        FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      user = firebaseUser;
      viewData.name = user?.displayName;
      if (viewData.name != null) nameController.text = viewData.name!;
      viewData.defaultPhotoUrl = user?.photoURL;
      notifyListeners();
    });
  }

  void onNameNextClicked() {
    if (nameController.text.isEmpty) {
      AppSnackBar.showSnackBarError("Name cannot be empty");
    } else {
      viewData.name = nameController.text;
      _navigationService.navigateTo(Routes.authDetailsAgeView);
    }
  }

  void onAgeNextClicked() {
    if (ageController.text.isEmpty) {
      AppSnackBar.showSnackBarError("Please enter your age");
      return;
    }
    final age = int.parse(ageController.text);
    if (age < 16) {
      AppSnackBar.showSnackBarError("We cannot create profile for you");
    } else if (age > 200) {
      AppSnackBar.showSnackBarError("Invalid value for age");
    } else {
      viewData.age = int.parse(ageController.text);
      _navigationService.navigateTo(Routes.authDetailsPictureView);
    }
  }

  void onBioNextClicked() {
    if (isBusy) return;
    setBusy(true);
    if (bioController.text.isEmpty) {
      AppSnackBar.showSnackBarError("Please enter your bio");
      setBusy(false);
    } else {
      viewData.bio = bioController.text;
      createUser();
    }
  }

  void onBioSkipClicked() {
    if (isBusy) return;
    setBusy(true);
    createUser();
  }

  void onChangeAvatarClicked() {
    AppDialog.showChoiceDialog(
      title: Strings.updatePhoto,
      description: Strings.chooseSource,
      choices: [Strings.gallery, Strings.camera],
      onConfirm: _onSelectPhoto,
    );
  }

  Future<void> _onSelectPhoto(String source) {
    ImageSource imageSource;
    if (source == Strings.gallery)
      imageSource = ImageSource.gallery;
    else if (source == Strings.camera)
      imageSource = ImageSource.camera;
    else
      throw ArgumentError();
    return _picker
        .getImage(
      source: imageSource,
    )
        .then(
      (result) async {
        if (result == null) return;
        viewData.photoUrl = (await compressImage(result.path, 25)).path;
        notifyListeners();
      },
    );
  }

  void createUser() async {
    await _userRepository
        .saveUser(
      id: user!.uid,
      name: viewData.name!,
      age: viewData.age!,
      photoURL: viewData.photoUrl,
      defaultPhotoUrl: viewData.defaultPhotoUrl,
      phoneNumber: user!.phoneNumber,
      email: user!.email,
      description: viewData.bio,
    )
        .then((value) {
      setBusy(false);
      _navigationService.clearStackAndShow(Routes.mainView);
    }).catchError((onError) {
      setBusy(false);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    bioController.dispose();
    authStateChangesSubscription?.cancel();
    super.dispose();
  }
}
