import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/search/search_viewmodel.dart';
import 'package:dairo/presentation/view/search/widgets/widget_search_results_tab.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetSearchViewContent extends ViewModelWidget<SearchViewModel> {
  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.black),
          title: TextField(
            autofocus: true,
            textInputAction: TextInputAction.search,
            onSubmitted: viewModel.onSearchSubmitted,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            controller: viewModel.searchTextController,
            decoration: new InputDecoration.collapsed(
                hintText: Strings.search,
                hintStyle: TextStyle(color: AppColors.gray)),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: Strings.top),
              Tab(text: Strings.accounts),
              Tab(text: Strings.hubs),
            ],
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.gray,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            WidgetTopSearchResultsTab(),
            WidgetProfileSearchResultsTab(),
            WidgetHubSearchResultsTab(),
          ],
        ),
      ),
    );
  }
}
