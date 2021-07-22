import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
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
        centerTitle: false,
        title: Text(
          viewModel.hub.name,
          style: TextStyles.toolbarTitle,
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: 28,
              icon: InkWell(
                child: Icon(
                  Icons.more_vert_outlined,
                  color: AppColors.white,
                ),
              ),
              onChanged: viewModel.onMenuItemClicked,
              items: [
                DropdownMenuItem(
                  value: HubMenuItem.DeleteHub,
                  child: Text(
                    Strings.deleteHub,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
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

enum HubMenuItem { DeleteHub }
