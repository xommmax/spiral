import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/account/widgets/widget_account_hub_grid.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../account_viewmodel.dart';

class WidgetAccountViewContent extends ViewModelWidget<AccountViewModel> {
  @override
  Widget build(BuildContext context, AccountViewModel viewModel) => Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            if (viewModel.user != null)
              Image.network(viewModel.user!.photoURL!),
            WidgetAccountHubGrid()
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.createHub,
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
        ),
      );
}
