import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../explore_viewmodel.dart';

class WidgetExploreViewContent extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, viewModel) => Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Text("Explore tab"),
          ),
        ),
      );
}
