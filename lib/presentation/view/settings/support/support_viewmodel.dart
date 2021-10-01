import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/settings/support/support_viewdata.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SupportViewModel extends BaseViewModel {
  final SupportRepository _supportRepository = locator<SupportRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final SupportViewData viewData = SupportViewData();

  void onSubmitMessageClicked() async {
    if (viewData.subjectController.text.isEmpty &&
        viewData.descriptionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.pleaseFillInInputForm);
      return;
    }
    if (viewData.subjectController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.subjectCannotBeEmpty);
      return;
    }
    if (viewData.descriptionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.descriptionCannotBeEmpty);
      return;
    }
    setBusy(true);
    try {
      await _supportRepository.sendSupportRequest(
        subject: viewData.subjectController.text,
        description: viewData.descriptionController.text,
      );
      _navigationService.back(result: true);
    } catch (_) {
      AppSnackBar.showSnackBarError(Strings.errorSomethingWentWrong);
    }
    setBusy(false);
  }
}
