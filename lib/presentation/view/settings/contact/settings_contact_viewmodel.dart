import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/tools/snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsContactViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void onSupportItemClicked() {
    _navigationService.navigateTo(Routes.supportView)?.then((result) {
      if (result != null && result is bool && result) {
        AppSnackBar.showSnackBarSuccess(Strings.contactRequestSuccessfullySent);
      }
    });
  }

  void onSuggestionItemClicked() {
    _navigationService.navigateTo(Routes.suggestionView)?.then((result) {
      if (result != null && result is bool && result) {
        AppSnackBar.showSnackBarSuccess(Strings.contactRequestSuccessfullySent);
      }
    });
  }

  void onReportBugItemClicked() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@spiralapp.site',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Report a bug',
        'body': '[ Please describe the problem and attach the screenshots]'
      }),
    );

    launch(emailLaunchUri.toString());
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
