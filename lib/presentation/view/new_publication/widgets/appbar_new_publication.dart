import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
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
          style: TextStyles.toolbarTitle,
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: viewModel.onDonePressed,
          ),
        ],
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
