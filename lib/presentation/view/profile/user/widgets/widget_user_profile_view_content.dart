import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/default_images.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/profile/user/user_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/user/widgets/widget_user_hub_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetUserProfileViewContent
    extends ViewModelWidget<UserProfileViewModel> {
  @override
  Widget build(BuildContext context, UserProfileViewModel viewModel) =>
      Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: AppColors.white,
                            ),
                            onPressed: () => showCupertinoModalPopup(
                                context: context,
                                builder: (context) => OptionsBottomSheet(
                                      onReport: viewModel.onReport,
                                      onBlock: viewModel.onBlock,
                                    )),
                          ),
                        ],
                      ),
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
                    ],
                  ),
                ),
                (viewModel.isUserBlocked != null && (viewModel.isUserBlocked!))
                    ? Text(
                        "User is blocked",
                        style: TextStyle(fontSize: 20),
                      )
                    : WidgetUserHubGrid(),
              ],
            ),
          ),
        ),
      );
}
