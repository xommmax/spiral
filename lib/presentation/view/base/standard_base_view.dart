import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

abstract class StandardBaseView<T extends BaseViewModel>
    extends StatelessWidget {
  StandardBaseView();

  Widget getContent(BuildContext context);

  T getViewModel();

  @override
  Widget build(BuildContext context) => ViewModelBuilder.nonReactive(
        builder: (context, viewModel, child) => getContent(context),
        viewModelBuilder: getViewModel,
      );
}
