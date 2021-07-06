import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/hub/creation/hub_creation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarHubCreation extends ViewModelWidget<HubCreationViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, HubCreationViewModel viewModel) => AppBar(
        title: TextField(
          style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          controller: viewModel.nameController,
          decoration: new InputDecoration.collapsed(
              hintText: 'Enter Hubname',
              hintStyle: TextStyle(color: AppColors.gray)),
        ),
        actions: [
          Visibility(
            visible: !viewModel.isBusy,
            child: GestureDetector(
              onTap: viewModel.onDonePressed,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.check,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
