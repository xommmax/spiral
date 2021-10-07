import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/current_user/widgets/widget_current_user_hub_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetCurrentUserProfileViewContent
    extends ViewModelWidget<CurrentUserProfileViewModel> {
  @override
  Widget build(BuildContext context, CurrentUserProfileViewModel viewModel) =>
      Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: viewModel.onBackPressed,
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: viewModel.onEditProfileClicked,
                          icon: Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: viewModel.onSettingsClicked,
                          icon: Icon(
                            Icons.settings,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'profilePhoto',
                        child: WidgetProfilePhoto(
                          photoUrl: viewModel.getPhotoUrl(),
                          radius: 70,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        viewModel.viewData.user?.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 36,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (viewModel.viewData.user?.description != null)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            viewModel.viewData.user!.description!,
                            style: TextStyle(
                              color: AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: viewModel.onUserHubsFollowingClicked,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '${viewModel.viewData.user?.followingsCount ?? 0} followings',
                            style: TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetCurrentUserHubGrid(),
              ],
            ),
          ),
        ),
      );
}
