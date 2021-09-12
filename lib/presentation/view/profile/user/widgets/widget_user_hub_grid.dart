import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_preview.dart';
import 'package:dairo/presentation/view/profile/user/user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetUserHubGrid extends ViewModelWidget<UserProfileViewModel> {
  @override
  Widget build(BuildContext context, UserProfileViewModel viewModel) {
    final hubs = viewModel.viewData.hubs;
    if (hubs.isEmpty) return _buildEmptyState();
    return _buildGrid(viewModel);
  }

  _buildGrid(UserProfileViewModel viewModel) => GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        childAspectRatio: 16 / 13,
        children: viewModel.viewData.hubs
            .map(
              (hub) => InkWell(
                onTap: () => viewModel.onOpenHubClicked(hub),
                child: WidgetHubPreview(hub),
              ),
            )
            .toList(),
      );

  _buildEmptyState() => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Text(Strings.no_user_hubs),
        ),
      );
}
