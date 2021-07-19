import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

abstract class StandardBaseView<T extends BaseViewModel>
    extends StatelessWidget {
  final T viewModel;

  StandardBaseView(this.viewModel);

  Widget getContent(BuildContext context);

  @override
  Widget build(BuildContext context) => ViewModelBuilder.nonReactive(
        builder: (context, viewModel, child) => getContent(context),
        viewModelBuilder: () => viewModel,
      );
}
