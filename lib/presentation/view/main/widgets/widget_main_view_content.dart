import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/explore/explore_view.dart';
import 'package:dairo/presentation/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../main_viewmodel.dart';

class WidgetMainViewContent extends ViewModelWidget<MainViewModel> {
  @override
  Widget build(BuildContext context, MainViewModel viewModel) => Scaffold(
        extendBody: true,
        body: SafeArea(
          child: IndexedStack(
            index: viewModel.currentIndex,
            children: [HomeView(), ExploreView()],
          ),
          bottom: false,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 0,
          color: AppColors.primaryColor,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: AppColors.primaryColor.withAlpha(0),
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.setIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: AppColors.gray,
            selectedItemColor: AppColors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: Strings.home,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: Strings.explore),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.onFabPressed,
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
          // elevation: 0,
        ),
      );
}
