import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../new_hub_viewmodel.dart';
import 'appbar_new_hub.dart';

class WidgetHubCreationViewContent
    extends ViewModelWidget<HubCreationViewModel> {
  @override
  Widget build(BuildContext context, HubCreationViewModel viewModel) =>
      Scaffold(
        appBar: AppBarHubCreation(),
        body: SafeArea(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
                child: InkWell(
                  onTap: viewModel.onHubPictureSelected,
                  child: viewModel.viewData.pictureUrl == null
                      ? Container(
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                          ),
                          color: AppColors.lightGray,
                        )
                      : Image.file(
                          File(viewModel.viewData.pictureUrl!),
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                    controller: viewModel.descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    decoration: new InputDecoration(
                        hintText: 'Hub description',
                        hintStyle: TextStyle(color: AppColors.gray))),
              ),
            ],
          ),
        ),
      );
}
