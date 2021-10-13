import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/discussion.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:dairo/domain/repository/support/support_repository.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HubDiscussionViewModel extends BaseViewModel {
  final Hub hub;
  HubDiscussion? discussion;
  final HubRepository _hubRepository = locator<HubRepository>();
  final SupportRepository _supportRepository = locator<SupportRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  HubDiscussionViewModel({required this.hub}) {
    _getDiscussion();
  }

  void _getDiscussion() async {
    discussion = await _hubRepository.getHubDiscussion(hub.id);
    notifyListeners();
  }

  void onReport(types.Message message) {
    _supportRepository.reportMessage(messageId: message.id, reason: "TODO");
    AppDialog.showInformDialog(
        title: Strings.reported, description: Strings.reportedPublicationDesc);
  }

  void onAvatarPressed(types.User user) =>
      _navigationService.navigateTo(Routes.userProfileView,
          arguments: UserProfileViewArguments(userId: user.id));
}
