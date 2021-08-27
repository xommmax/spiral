import 'package:dairo/presentation/view/users/users_viewmodel.dart';
import 'package:dairo/presentation/view/users/widgets/widget_users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_users.dart';

class WidgetUsersViewContent extends ViewModelWidget<UsersViewModel> {
  @override
  Widget build(BuildContext context, UsersViewModel viewModel) => Scaffold(
        appBar: AppBarUsers(),
        body: SafeArea(
          bottom: false,
          child: WidgetUsersList(),
        ),
      );
}
