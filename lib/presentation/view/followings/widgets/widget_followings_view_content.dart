import 'package:dairo/presentation/view/followings/followings_viewmodel.dart';
import 'package:dairo/presentation/view/followings/widgets/widget_followings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'widget_followings_appbar.dart';

class WidgetFollowingsViewContent extends ViewModelWidget<FollowingsViewModel> {
  @override
  Widget build(BuildContext context, FollowingsViewModel viewModel) => Scaffold(
        appBar: WidgetFollowingsAppBar(),
        body: SafeArea(
          bottom: false,
          child: WidgetFollowingsList(),
        ),
      );
}
