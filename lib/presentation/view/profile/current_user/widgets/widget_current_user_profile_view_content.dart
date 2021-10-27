import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/default_images.dart';
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
                        color: AppColors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: viewModel.onEditProfileClicked,
                          icon: Icon(
                            Icons.edit,
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: viewModel.onSettingsClicked,
                          icon: Icon(
                            Icons.settings,
                            color: AppColors.white,
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
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (viewModel.viewData.user?.description != null)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            viewModel.viewData.user!.description!,
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: viewModel.onUserHubsFollowingClicked,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${viewModel.viewData.user?.followingsCount ?? 0} followings',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: viewModel.onInviteFriendsClicked,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Invite Friends',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                WidgetCurrentUserHubGrid(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.darkestGray,
          onPressed: viewModel.onCreateButtonClicked,
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      );
}
