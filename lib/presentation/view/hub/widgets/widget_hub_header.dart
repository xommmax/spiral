import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
import 'package:dairo/presentation/view/tools/global_variables.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubHeader extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => SliverAppBar(
        backgroundColor: AppColors.darkAccentColor,
        expandedHeight: getScreenWidth(context) / Dimens.hubPictureRatio,
        pinned: true,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: AppColors.white,
            ),
            onPressed: viewModel.onBackPressed,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(8),
              primary: AppColors.darkAccentColor.withOpacity(0.3),
            ),
          ),
        ),
        title: Visibility(
          child: Text(
            viewModel.viewData.hub?.name ?? '',
            style: TextStyles.toolbarTitle,
          ),
          visible: viewModel.showAppBarTitle,
        ),
        actions: [
          if (viewModel.isCurrentUser())
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Icon(
                  Icons.edit,
                  size: 24,
                  color: AppColors.white,
                ),
                onPressed: viewModel.onEditHubClicked,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(8),
                  primary: AppColors.darkAccentColor.withOpacity(0.3),
                ),
              ),
            ),
          if (viewModel.isCurrentUser())
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                child: Icon(
                  Icons.settings,
                  size: 24,
                  color: AppColors.white,
                ),
                onPressed: viewModel.onSettingsPressed,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(8),
                  primary: AppColors.darkAccentColor.withOpacity(0.3),
                ),
              ),
            ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            clipBehavior: Clip.none,
            children: [
              AspectRatio(
                aspectRatio: Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xAA000000),
                        Color(0x60000000),
                        Color(0x00000000),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0, 0.25, 0.5],
                    ),
                  ),
                  child: getHubImageWidget(viewModel.viewData.hub!),
                ),
              ),
              if (!viewModel.isCurrentUser())
                Positioned(
                  bottom: 12,
                  right: 16,
                  child: InkWell(
                    onTap: viewModel.onFollowClicked,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        viewModel.viewData.hub!.isFollow
                            ? Strings.following
                            : Strings.follow,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: viewModel.viewData.hub!.isFollow
                              ? FontWeight.w400
                              : FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 20,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.viewData.hub?.name ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 12,
                            color: AppColors.darkGray,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: viewModel.onFollowersClicked,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '${viewModel.viewData.hub!.followersCount.toString()} followers',
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
            ],
          ),
        ),
      );
}
