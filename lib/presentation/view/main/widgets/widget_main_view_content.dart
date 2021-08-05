import 'package:dairo/domain/model/main/main_tab.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/dimens.dart';
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
            children: [
              HomeView(),
              ExploreView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 6,
          shape: CircularNotchedRectangle(),
          color: AppColors.primaryColor,
          child: Container(
            height: Dimens.bottomBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: mainTabs
                  .map<Widget>(
                    (tab) => IconButton(
                      icon: Icon(tab.icon),
                      color: AppColors.white,
                      iconSize: 30,
                      onPressed: () => viewModel.setIndex(tab.index),
                    ),
                  )
                  .toList()
                    ..insert(
                      (mainTabs.length ~/ 2),
                      SizedBox(width: 50),
                    ),
            ),
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
