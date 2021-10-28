import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/default_images.dart';
import 'package:dairo/presentation/view/base/dialogs.dart';
import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class PublicationHeaderWidget extends ViewModelWidget<PublicationViewModel> {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: Row(
                  children: [
                    WidgetProfilePhoto(
                      photoUrl: viewModel.user?.photoURL,
                      radius: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      viewModel.user?.name ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: viewModel.onUserClicked,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(Strings.inWord,
                    style: TextStyle(
                      color: AppColors.white,
                    )),
              ),
              InkWell(
                child: Row(
                  children: [
                    WidgetHubPhoto(
                      photoUrl: viewModel.hub?.pictureUrl,
                      radius: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      viewModel.hub?.name ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: viewModel.onHubClicked,
              ),
            ],
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.more_vert, color: AppColors.white),
            ),
            onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => OptionsBottomSheet(
                      onReport: viewModel.isCurrentUserPublication()
                          ? null
                          : () => viewModel.onReport(),
                      onDelete: viewModel.isCurrentUserPublication()
                          ? () => viewModel.onDelete()
                          : null,
                    )),
          ),
        ],
      ),
    );
  }
}
