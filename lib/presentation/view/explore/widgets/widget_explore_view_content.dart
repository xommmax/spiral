import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_toolbar_explore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../explore_viewmodel.dart';

class WidgetExploreViewContent extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, viewModel) => Column(children: [
        WidgetToolBarExplore(),
        Flexible(
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children: List.generate(
                40,
                (index) => Container(
                      color: AppColors.gray,
                    )),
          ),
        ),
      ]);
}
