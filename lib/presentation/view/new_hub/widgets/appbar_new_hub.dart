import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarNewHub extends ViewModelWidget<NewHubViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, NewHubViewModel viewModel) => AppBar(
        title: TextField(
          autofocus: true,
          style: TextStyles.toolbarTitle,
          controller: viewModel.nameController,
          decoration: new InputDecoration.collapsed(
            hintText: Strings.enterHubname,
            hintStyle: TextStyle(color: AppColors.gray),
          ),
        ),
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
