import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/explore/explore_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetToolBarExplore extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, ExploreViewModel viewModel) => InkWell(
        onTap: viewModel.onSearchPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: AppColors.lightGray,
            ),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Text(Strings.search, style: TextStyles.robotoGray16),
              ],
            ),
          ),
        ),
      );
}
