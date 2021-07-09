import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/profile/base/profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_hub_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetProfileViewContent extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) => Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            if (viewModel.user != null)
              Image.network(viewModel.user!.photoURL!),
            WidgetProfileHubGrid()
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.createHub,
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
        ),
      );
}
