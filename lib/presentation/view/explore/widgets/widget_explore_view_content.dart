import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../explore_viewmodel.dart';

class WidgetExploreViewContent extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.explore),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Explore tab"),
      ),
    );
  }
}
