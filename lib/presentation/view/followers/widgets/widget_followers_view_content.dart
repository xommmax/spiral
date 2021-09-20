import 'package:dairo/presentation/view/followers/followers_viewmodel.dart';
import 'package:dairo/presentation/view/followers/widgets/widget_followers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'widget_followers_appbar.dart';

class WidgetFollowersViewContent extends ViewModelWidget<FollowersViewModel> {
  @override
  Widget build(BuildContext context, FollowersViewModel viewModel) => Scaffold(
        appBar: WidgetFollowersAppBar(),
        body: SafeArea(
          bottom: false,
          child: WidgetFollowersList(),
        ),
      );
}
