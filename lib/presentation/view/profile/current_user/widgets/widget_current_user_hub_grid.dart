import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_preview.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetCurrentUserHubGrid
    extends ViewModelWidget<CurrentUserProfileViewModel> {
  @override
  Widget build(BuildContext context, CurrentUserProfileViewModel viewModel) {
    double width = MediaQuery.of(context).size.width / 2;
    double height =
        (width - WidgetHubPreview.paddingLeft - WidgetHubPreview.paddingRight) /
                Dimens.hubPictureRatioX *
                Dimens.hubPictureRatioY +
            WidgetHubPreview.paddingTop +
            WidgetHubPreview.paddingBottom +
            WidgetHubPreview.textHeight;
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 1,
      childAspectRatio: width / height,
      children: viewModel.viewData.hubs
          .map(
            (hub) => InkWell(
              onTap: () => viewModel.onOpenHubClicked(hub),
              child: WidgetHubPreview(hub),
            ),
          )
          .toList(),
    );
  }
}
