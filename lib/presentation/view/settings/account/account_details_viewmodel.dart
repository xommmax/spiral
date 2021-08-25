import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/settings/account/account_details_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class AccountDetailsViewModel extends StreamViewModel<User?> {
  final UserRepository _userRepository = locator<UserRepository>();

  final AccountDetailsViewData viewData = AccountDetailsViewData();
  final _picker = ImagePicker();

  @override
  Stream<User?> get stream => _userRepository.getCurrentUser();

  @override
  void onData(User? data) {
    if (data != null) {
      if(data.name != null) {
        viewData.nameController.text = data.name!;
      }
      if(data.username != null) {
        viewData.usernameController.text = data.username!;
      }
      if(data.description != null) {
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

  void onChangeAvatarClicked() => AppDialog.showConfirmationDialog(
        title: Strings.chooseSource,
        confirmText: Strings.gallery,
        cancelText: Strings.camera,
        onConfirm: (isConfirm) => _onSelectPhoto(
            isConfirm ? ImageSource.gallery : ImageSource.camera),
      );

  Future<void> _onSelectPhoto(ImageSource source) => _picker
          .getImage(
        source: source,
      )
          .then(
        (result) {
          viewData.photoUrl = result?.path;
          notifyListeners();
        },
      );

  void onDoneClicked() async {
    setBusy(true);
    await _userRepository.updateUser(
      name: viewData.nameController.text,
      username: viewData.usernameController.text,
      photoURL: viewData.photoUrl,
      description: viewData.descriptionController.text,
    );
    setBusy(false);
    AppSnackBar.showSnackBarSuccess(Strings.accountUpdatedSuccessfully);
  }
}
