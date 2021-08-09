import 'package:dairo/presentation/view/publication/publication_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppBarPublication extends ViewModelWidget<PublicationViewModel>
    implements ObstructingPreferredSizeWidget {
  @override
  Widget build(BuildContext context, PublicationViewModel viewModel) => AppBar(
        automaticallyImplyLeading: true,
      );

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}