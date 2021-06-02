import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

abstract class StandardBaseView<T extends BaseViewModel>
    extends StatelessWidget {
  final T viewModel;
  final Color? backgroundColor;

  StandardBaseView(this.viewModel, {this.backgroundColor});

  Widget getContent(BuildContext context);

  PreferredSizeWidget? getAppBar(BuildContext context) => null;

  @override
  Widget build(BuildContext context) => ViewModelBuilder.nonReactive(
        builder: (context, viewModel, child) => _getTheme(context),
        viewModelBuilder: () => viewModel,
      );

  Widget _getTheme(BuildContext context) => Theme(
        data: Theme.of(context),
        child: _getScaffold(context),
      );

  Widget _getScaffold(BuildContext context) => Scaffold(
        appBar: getAppBar(context),
        body: getContent(context),
        backgroundColor: _getThemeColor(context),
      );

  Color _getThemeColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).backgroundColor;
}
