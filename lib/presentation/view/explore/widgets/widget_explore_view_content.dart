import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/explore/explore_viewmodel.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_explore_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetExploreViewContent extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(BuildContext context, viewModel) => CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.white,
            leading: Icon(Icons.search),
            iconTheme: IconThemeData(color: AppColors.black),
            title: TextField(
              readOnly: true,
              onTap: viewModel.onSearchPressed,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              decoration: new InputDecoration.collapsed(
                hintText: Strings.search,
                hintStyle: TextStyle(color: AppColors.gray),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Popular hubs",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              WidgetExploreHubCarousel(),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Popular publications",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              WidgetExplorePublicationsGrid(),
            ]),
          ),
        ],
      );
}
