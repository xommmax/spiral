import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/new_publication/new_publication_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarNewPublication extends ViewModelWidget<NewPublicationViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, NewPublicationViewModel viewModel) =>
      AppBar(
        title: Text(
          Strings.newPublication,
          style: TextStyles.robotoWhiteBold22,
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
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
