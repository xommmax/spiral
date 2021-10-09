import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/settings/contact/support/support_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:validators/validators.dart';

class SupportViewModel extends BaseViewModel {
  final SupportRepository _supportRepository = locator<SupportRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final SupportViewData viewData = SupportViewData();

  void onSubmitMessageClicked() async {
    if (viewData.emailController.text.isEmpty &&
        viewData.questionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.pleaseFillInInputForm);
      return;
    }
    if (viewData.emailController.text.isEmpty ||
        !isEmail(viewData.emailController.text)) {
      AppSnackBar.showSnackBarError(Strings.enterCorrectEmail);
      return;
    }
    if (viewData.questionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.subjectCannotBeEmpty);
      return;
    }
    setBusy(true);
    try {
      await _supportRepository.sendContactRequest(
        type: 'question',
        email: viewData.emailController.text,
        description: viewData.questionController.text,
      );
      _navigationService.back(result: true);
    } catch (_) {
      AppSnackBar.showSnackBarError(Strings.errorSomethingWentWrong);
    }
    setBusy(false);
  }
}
