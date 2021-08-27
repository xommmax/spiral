import 'package:dairo/presentation/view/hubs/hubs_viewmodel.dart';
import 'package:dairo/presentation/view/hubs/widgets/widget_hubs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'appbar_hubs.dart';

class WidgetHubsViewContent extends ViewModelWidget<HubsViewModel> {
  @override
  Widget build(BuildContext context, HubsViewModel viewModel) => Scaffold(
        appBar: AppBarHubs(),
        body: SafeArea(
          bottom: false,
          child: WidgetHubsList(),
        ),
      );
}
