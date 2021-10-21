import 'package:dairo/presentation/view/new_hub/widgets/new_hub_info.dart';
import 'package:dairo/presentation/view/new_hub/widgets/new_hub_options.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../new_hub_viewmodel.dart';
import 'appbar_new_hub.dart';

class WidgetNewHubViewContent extends ViewModelWidget<NewHubViewModel> {
  @override
  Widget build(BuildContext context, NewHubViewModel viewModel) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBarNewHub(),
          body: SafeArea(
              child: IndexedStack(
            children: [
              NewHubInfoWidget(),
              NewHubOptionsWidget(),
            ],
            index: viewModel.pageIndex,
          )),
        ),
      );
}
