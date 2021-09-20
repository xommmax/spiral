import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/followers/followers_viewdata.dart';
import 'package:dairo/presentation/view/followers/followers_viewmodel.dart';
import 'package:dairo/presentation/view/followers/widgets/widget_followers_view_content.dart';
import 'package:flutter/widgets.dart';

class FollowersView extends StandardBaseView<FollowersViewModel> {
  FollowersView({
    required List<String> userIds,
    required FollowersType type,
  }) : super(
          FollowersViewModel(
            userIds: userIds,
            type: type,
          ),
          routeName: Routes.followersView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetFollowersViewContent();
}
