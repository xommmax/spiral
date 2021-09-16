import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/users/users_viewdata.dart';
import 'package:dairo/presentation/view/users/users_viewmodel.dart';
import 'package:dairo/presentation/view/users/widgets/widget_users_view_content.dart';
import 'package:flutter/widgets.dart';

class UsersView extends StandardBaseView<UsersViewModel> {
  UsersView({
    required List<String> userIds,
    required UsersType type,
  }) : super(
          UsersViewModel(
            userIds: userIds,
            type: type,
          ),
          routeName: Routes.usersView,
        );

  @override
  Widget getContent(BuildContext context) => WidgetUsersViewContent();
}
