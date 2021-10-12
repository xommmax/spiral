import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/base/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../new_hub_viewmodel.dart';
import 'appbar_new_hub.dart';

class WidgetNewHubViewContent extends ViewModelWidget<NewHubViewModel> {
  @override
  Widget build(BuildContext context, NewHubViewModel viewModel) => Scaffold(
        appBar: AppBarNewHub(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio:
                          Dimens.hubPictureRatioX / Dimens.hubPictureRatioY,
                      child: Container(
                        child: viewModel.viewData.pictureUrl == null
                            ? Image.asset(
                                'assets/images/default_hub_cover.png',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(viewModel.viewData.pictureUrl!),
                                fit: BoxFit.cover,
                              ),
                        color: AppColors.white,
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xAA000000),
                              Color(0x60000000),
                              Color(0x00000000),
                              Color(0x00000000),
                              Color(0x80000000),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0, 0.25, 0.5, 0.8, 1],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: viewModel.onHubPictureSelected,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined),
                              Text(
                                Strings.changeHubCover,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 12,
                                      color: AppColors.darkGray,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 20,
                      right: 0,
                      child: TextField(
                        autofocus: true,
                        controller: viewModel.nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: new InputDecoration.collapsed(
                          hintText: Strings.enterHubname,
                          hintStyle: TextStyle(
                              color: AppColors.white.withOpacity(0.5)),
                        ),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 12,
                              color: AppColors.shadowGray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: viewModel.descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 150,
                    decoration:
                        CustomInputDecoration.withHint(Strings.whatHubAbout),
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
