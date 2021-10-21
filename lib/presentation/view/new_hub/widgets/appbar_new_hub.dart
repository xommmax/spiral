import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/progress.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarNewHub extends ViewModelWidget<NewHubViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, NewHubViewModel viewModel) => AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: viewModel.onBackButtonPressed,
        ),
        title: Text(Strings.newHub, style: TextStyles.toolbarTitle),
        actions: [
          !viewModel.isBusy
              ? IconButton(
                  onPressed: viewModel.pageIndex == 0
                      ? viewModel.onNextPressed
                      : viewModel.onDonePressed,
                  icon: viewModel.pageIndex == 0
                      ? Icon(Icons.arrow_forward)
                      : Icon(Icons.done),
                )
              : ActionProgressBar(),
        ],
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
