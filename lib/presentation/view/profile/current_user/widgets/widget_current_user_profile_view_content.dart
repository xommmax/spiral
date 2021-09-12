import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
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
        appBar: AppBar(
          title: Text(Strings.myShowcase, style: TextStyles.toolbarTitle),
          actions: [
            IconButton(
              onPressed: viewModel.onSettingsClicked,
              icon: Icon(
                Icons.settings,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'profilePhoto',
                        child: WidgetProfilePhoto(
                          photoUrl: viewModel.getPhotoUrl(),
                          width: 120,
                          height: 120,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        viewModel.viewData.user?.name ?? '',
                        style: TextStyles.black22Bold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        viewModel.viewData.user?.description ?? '',
                        style: TextStyles.gray14,
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: viewModel.onUserHubsFollowingClicked,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                '${viewModel.viewData.user?.followingsCount ?? 0}',
                                style: TextStyles.black18Bold,
                              ),
                              Text(
                                Strings.followings,
                                style: TextStyles.black14,
                              ),
                            ],
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
