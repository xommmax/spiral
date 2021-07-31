import 'package:dairo/presentation/view/publication/users_liked/users_liked_viewmodel.dart';
import 'package:dairo/presentation/view/publication/users_liked/widgets/widget_users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_users_liked.dart';

class WidgetUsersLikedViewContent extends ViewModelWidget<UsersLikedViewModel> {
  @override
  Widget build(BuildContext context, UsersLikedViewModel viewModel) => Scaffold(
        appBar: AppBarUsersLiked(),
        body: SafeArea(
          bottom: false,
          child: WidgetUsersList(),
        ),
      );
}
