import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_base_profile_hub_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetBaseProfileView<T extends BaseProfileViewModel>
    extends ViewModelWidget<T> {
  @override
  Widget build(BuildContext context, BaseProfileViewModel viewModel) => Column(
        children: [
          if (viewModel.user?.photoURL != null)
            Image.network(viewModel.user!.photoURL!),
          WidgetBaseProfileHubGrid<T>()
        ],
      );
}
