import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
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
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: viewModel.viewData.hub!.pictureUrl,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.white,
                  ),
                  onPressed: viewModel.onBackPressed,
                ),
              ),
              if (viewModel.isCurrentUser())
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 24,
                      color: AppColors.white,
                    ),
                    onPressed: viewModel.onSettingsPressed,
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
                              color: AppColors.buttonColor,
                              border: Border.all(
                                color: AppColors.buttonColor,
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
              Positioned(
                right: 16,
                bottom: -24,
                child: ElevatedButton(
                  child: Icon(Icons.message_outlined),
                  onPressed: viewModel.openDiscussion,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 80, 16),
            child: Text(
              viewModel.viewData.hub!.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkGray,
                fontSize: 14,
              ),
            ),
          ),
          Divider(
            height: 1,
            indent: 8,
            endIndent: 8,
            color: AppColors.lightGray,
          ),
        ],
      );
}
