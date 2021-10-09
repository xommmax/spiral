import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SuggestionViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController suggestionController = TextEditingController();
  final SupportRepository _supportRepository = locator<SupportRepository>();

  void onSubmitMessageClicked() async {
    if (suggestionController.text.isEmpty) {
      AppSnackBar.showSnackBarError(Strings.subjectCannotBeEmpty);
      return;
    }
    setBusy(true);
    try {
      await _supportRepository.sendContactRequest(
        type: 'suggestion',
        description: suggestionController.text,
      );
      _navigationService.back(result: true);
    } catch (_) {
      AppSnackBar.showSnackBarError(Strings.errorSomethingWentWrong);
    }
    setBusy(false);
  }
}
