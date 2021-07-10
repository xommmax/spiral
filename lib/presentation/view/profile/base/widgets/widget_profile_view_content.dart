import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/profile/base/profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_hub_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetProfileViewContent extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(
            viewModel.viewData.user?.displayName ?? '',
            style: TextStyles.robotoWhiteBold22,
          ),
          backgroundColor: AppColors.primaryColor,
          actions: [
            IconButton(
                onPressed: viewModel.onSettingsClicked,
                icon: Icon(Icons.settings))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (viewModel.viewData.user?.photoURL != null)
                Image.network(viewModel.viewData.user!.photoURL!),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8),
                child: WidgetProfileHubGrid(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.onCreateHubClicked,
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
        ),
      );
}
