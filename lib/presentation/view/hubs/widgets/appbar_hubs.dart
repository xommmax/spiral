import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hubs/hubs_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarHubs extends ViewModelWidget<HubsViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, HubsViewModel viewModel) => AppBar(
        centerTitle: true,
        title: Text(
          Strings.hubs,
          style: TextStyles.white22Bold,
        ),
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
