import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/followings/widgets/widget_followings_view_content.dart';
import 'package:flutter/widgets.dart';

import 'followings_viewmodel.dart';

class FollowingsView extends StandardBaseView<FollowingsViewModel> {
  FollowingsView({
    required List<String> userIds,
  }) : super(
          FollowingsViewModel(
            hubIds: userIds,
          ),
          routeName: Routes.followingsView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetFollowingsViewContent();
}
