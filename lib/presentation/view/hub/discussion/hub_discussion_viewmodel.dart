import 'package:dairo/app/locator.dart';
import 'package:dairo/domain/model/hub/discussion.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/repository/hub/hub_repository.dart';
import 'package:stacked/stacked.dart';

class HubDiscussionViewModel extends BaseViewModel {
  final Hub hub;
  HubDiscussion? discussion;
  final HubRepository _hubRepository = locator<HubRepository>();

  HubDiscussionViewModel({required this.hub}) {
    _getDiscussion();
  }

  void _getDiscussion() async {
    discussion = await _hubRepository.getHubDiscussion(hub.id);
    notifyListeners();
  }
}
