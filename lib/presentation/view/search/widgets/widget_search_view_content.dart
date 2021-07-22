import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/search/search_viewmodel.dart';
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
          title: TextField(
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            controller: viewModel.searchTextController,
            decoration: new InputDecoration.collapsed(
                hintText: 'Enter Hubname',
                hintStyle: TextStyle(color: AppColors.gray)),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: Strings.top),
              Tab(text: Strings.accounts),
              Tab(text: Strings.hubs),
            ],
            labelColor: AppColors.black,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: AppColors.primaryColor),
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.flight, size: 350),
            Icon(Icons.flight, size: 350),
            Icon(Icons.flight, size: 350),
          ],
        ),
      ),
    );
  }
}
