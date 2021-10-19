import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_preview.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class WidgetCurrentUserHubGrid
    extends ViewModelWidget<CurrentUserProfileViewModel> {
  @override
  Widget build(BuildContext context, CurrentUserProfileViewModel viewModel) {
    final hubs = viewModel.viewData.hubs;
    if (hubs.isEmpty) {
      return _buildEmptyState();
    } else {
      return _buildGrid(context, viewModel);
    }
  }

  Widget _buildGrid(
      BuildContext context, CurrentUserProfileViewModel viewModel) {
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

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.only(top: 64),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/images/onboarding/showcase.svg",
            height: 175.0,
          ),
          SizedBox(height: 32),
          Text(
            "You don't have any hubs yet.\nLet's create some!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
