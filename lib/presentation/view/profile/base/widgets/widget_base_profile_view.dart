import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_grid.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetBaseProfileView<T extends BaseProfileViewModel>
    extends ViewModelWidget<T> {
  @override
  Widget build(BuildContext context, BaseProfileViewModel viewModel) => Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: InkWell(
              // onTap: ,
              child: Hero(
                tag: 'profilePhoto',
                child: WidgetProfilePhoto(
                  photoUrl: viewModel.getPhotoUrl(),
                  width: 120,
                  height: 120,
                ),
              ),
            ),
          ),
          Text(
            viewModel.viewData.user?.name ?? '',
            style: TextStyles.black18,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Text(
            viewModel.viewData.user?.description ?? '',
            style: TextStyles.gray16,
          ),
          viewModel.viewData.user?.followingsCount != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: viewModel.viewData.user!.followingsCount! > 0
                      ? viewModel.onUserHubsFollowingClicked
                      : null,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${viewModel.viewData.user!.followingsCount.toString()} ${Strings.followings}',
                      style: TextStyles.black14,
                    ),
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 40,
          ),
          WidgetHubGrid<T>()
        ],
      );
}
