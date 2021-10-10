import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
import 'package:dairo/presentation/view/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubHeader extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AspectRatio(
                aspectRatio: Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x90000000),
                        Color(0x00000000),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0, 0.5],
                    ),
                  ),
                  child: getHubImageWidget(viewModel.viewData.hub!),
                ),
              ),
              Positioned(
                top: 4,
                left: 4,
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
                    primary: Color(0x60000000),
                  ),
                ),
              ),
              if (viewModel.isCurrentUser())
                Positioned(
                  top: 4,
                  right: 4,
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
                      primary: Color(0x60000000),
                    ),
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
                      decoration: viewModel.viewData.hub!.isFollow
                          ? BoxDecoration(
                              color: AppColors.lightAccentColor,
                              border: Border.all(
                                color: AppColors.gray,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )
                          : BoxDecoration(
                              border: Border.all(
                                color: AppColors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                      child: Text(
                        viewModel.viewData.hub!.isFollow
                            ? Strings.following
                            : Strings.follow,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 8,
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.viewData.hub?.name ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (viewModel.viewData.hub!.description != null)
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text(
                viewModel.viewData.hub!.description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.gray,
                  fontSize: 14,
                ),
              ),
            ),
          if (viewModel.viewData.hub!.description != null)
            Divider(
              height: 1,
              indent: 8,
              endIndent: 8,
              color: AppColors.lightGray,
            ),
        ],
      );
}
