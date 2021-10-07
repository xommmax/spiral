import 'package:dairo/app/router.router.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/hub/discussion/hub_discussion_viewmodel.dart';
import 'package:dairo/presentation/view/hub/discussion/widgets/hub_discussion_view_content.dart';
import 'package:flutter/widgets.dart';

class HubDiscussionView extends StandardBaseView<HubDiscussionViewModel> {
  @override
  Widget getContent(BuildContext context) => HubDiscussionViewContent();

  HubDiscussionView({required Hub hub})
      : super(
          HubDiscussionViewModel(hub: hub),
          routeName: Routes.hubDiscussionView,
        );
}
