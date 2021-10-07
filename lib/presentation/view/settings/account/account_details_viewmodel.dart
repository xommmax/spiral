import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/settings/account/account_details_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountDetailsViewModel extends StreamViewModel<User?> {
  final UserRepository _userRepository = locator<UserRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final AccountDetailsViewData viewData = AccountDetailsViewData();
  final _picker = ImagePicker();

  @override
  Stream<User?> get stream => _userRepository.getCurrentUser();

  @override
  void onData(User? data) {
    if (data != null) {
      if (data.name != null) {
        viewData.nameController.text = data.name!;
      }
      if (data.username != null) {
        viewData.usernameController.text = data.username!;
      }
      if (data.description != null) {
        viewData.descriptionController.text = data.description!;
      }
    }
    super.onData(data);
  }

  @override
  void onError(error) {
    AppSnackBar.showSnackBarError(Strings.errorUnableToGetCurrentUser);
    super.onError(error);
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
      (result) {
        viewData.photoUrl = result?.path;
        viewData.isDataChanged = true;
        notifyListeners();
      },
    );
  }

  void onDoneClicked() async {
    setBusy(true);
    await _userRepository.updateUser(
      name: viewData.nameController.text,
      username: viewData.usernameController.text,
      photoURL: viewData.photoUrl,
      description: viewData.descriptionController.text,
    );
    setBusy(false);
    _navigationService.back(result: true);
  }

  void onNameChanged(String? name) {
    viewData.isDataChanged = name != data?.name;
    notifyListeners();
  }

  void onUsernameChanged(String? username) {
    viewData.isDataChanged = username != data?.username;
    notifyListeners();
  }

  void onDescriptionChanged(String? description) {
    viewData.isDataChanged = description != data?.description;
    notifyListeners();
  }
}
