import 'package:dairo/presentation/view/base/widget_route_changes_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

abstract class StandardBaseView<T extends BaseViewModel>
    extends StatelessWidget {
  final T viewModel;
  final String? routeName;

  StandardBaseView(
    this.viewModel, {
    required this.routeName,
  });

  Widget getContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final content = ViewModelBuilder.nonReactive(
      builder: (context, viewModel, child) => getContent(context),
      viewModelBuilder: () => viewModel,
    );

    return routeName != null
        ? WidgetRouteChangesTracker(routeName: routeName!, child: content)
        : content;
  }
}
