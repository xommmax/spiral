import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:dairo/presentation/view/publication/users_liked/users_liked_viewmodel.dart';
import 'package:dairo/presentation/view/publication/users_liked/widgets/widget_users_liked_view_content.dart';
import 'package:flutter/widgets.dart';

class UsersLikedView extends StandardBaseView<UsersLikedViewModel> {
  UsersLikedView({
    required List<String> userIds,
  }) : super(
          UsersLikedViewModel(
            userIds: userIds,
          ),
        );

  @override
  Widget getContent(BuildContext context) => WidgetUsersLikedViewContent();
}
