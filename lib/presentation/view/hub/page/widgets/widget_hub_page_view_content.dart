import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../hub_page_viewmodel.dart';

class WidgetHubViewContent extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => Scaffold(
        body: SafeArea(child: Container()),
      );
}
