import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/repository/user/user_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/settings/support/support_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';

class SupportViewModel extends BaseViewModel {
  final UserRepository _userRepository = locator<UserRepository>();

  final SupportViewData viewData = SupportViewData();

  void onSubmitMessageClicked() async {
    if(viewData.subjectController.text.isEmpty && viewData.descriptionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.pleaseFillInInputForm);
      return;
    }
    if(viewData.subjectController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.subjectCannotBeEmpty);
      return;
    }
    if(viewData.descriptionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.descriptionCannotBeEmpty);
      return;
    }
    setBusy(true);
    await _userRepository.sendSupportRequest(
      subject: viewData.subjectController.text,
      description: viewData.descriptionController.text,
    );
    setBusy(false);
    AppSnackBar.showSnackBarSuccess(Strings.messageSuccessfullySent);
  }
}
