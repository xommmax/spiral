import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../hub_creation_viewmodel.dart';

class WidgetHubCreationViewContent
    extends ViewModelWidget<HubCreationViewModel> {
  @override
  Widget build(BuildContext context, HubCreationViewModel viewModel) =>
      Scaffold(
        body: SafeArea(child: Container()),
      );
}
