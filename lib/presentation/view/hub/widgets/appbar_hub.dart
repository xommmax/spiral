import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarHub extends ViewModelWidget<HubViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            viewModel.viewData.hub?.name ?? '',
            style: TextStyles.toolbarTitle,
          ),
          actions: [
            IconButton(
              onPressed: viewModel.onSettingsClicked,
              icon: Icon(
                Icons.settings,
              ),
            ),
          ]);

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
