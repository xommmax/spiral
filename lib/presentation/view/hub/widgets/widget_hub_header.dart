import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
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
            children: [
              AspectRatio(
                aspectRatio: Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF000000),
                        Color(0x90000000),
                        Color(0x70000000),
                        Color(0x00000000),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.18, 0.21, 0.25],
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
              Positioned(
                top: 4,
                right: 4,
                child: viewModel.isCurrentUser()
                    ? IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 24,
                          color: AppColors.white,
                        ),
                        onPressed: viewModel.onSettingsPressed,
                      )
                    : InkWell(
                        onTap: viewModel.onFollowClicked,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 30,
                          ),
                          child: Text(
                            viewModel.viewData.hub!.isFollow
                                ? Strings.unfollow
                                : Strings.follow,
                            style: TextStyles.white16,
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              viewModel.viewData.hub?.name ?? '',
              style: TextStyles.black22Bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              viewModel.viewData.hub!.description,
              style: TextStyles.gray14,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: viewModel.onFollowersClicked,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(
                    viewModel.viewData.hub!.followersCount.toString(),
                    style: TextStyles.black18Bold,
                  ),
                  Text(
                    Strings.followers,
                    style: TextStyles.black14,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0,
            height: 24,
            color: AppColors.gray,
          ),
        ],
      );
}
