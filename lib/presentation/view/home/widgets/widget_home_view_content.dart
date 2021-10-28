import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/home/home_viewmodel.dart';
import 'package:dairo/presentation/view/publication/publication_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'widget_toolbar_home.dart';

class WidgetHomeViewContent extends ViewModelWidget<HomeViewModel> {
  final Function() goToExplore;

  WidgetHomeViewContent(this.goToExplore);

  @override
  Widget build(BuildContext context, viewModel) => Column(
        children: [
          AppBarHome(),
          (viewModel.viewData.publicationIds.length == 0)
              ? _buildEmptyState()
              : Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 8),
                    itemBuilder: (context, position) {
                      final publicationId =
                          viewModel.viewData.publicationIds[position];
                      return PublicationView(
                        publicationId,
                        isPreview: true,
                      );
                    },
                    separatorBuilder: (context, position) =>
                        Divider(height: 14),
                    itemCount: viewModel.viewData.publicationIds.length,
                  ),
                ),
        ],
      );

  _buildEmptyState() => Expanded(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 56),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Welcome to Spiral",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 24),
              Text(
                Strings.emptyHomeDesc,
                style: TextStyle(
                  color: AppColors.lightGray,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: goToExplore,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.lightAccentColor),
                ),
                child: Text("Go to Explore",
                    style: TextStyle(color: AppColors.white)),
              ),
            ]),
          ),
        ),
      );
}
