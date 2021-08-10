import 'package:dairo/presentation/view/explore/explore_viewmodel.dart';
import 'package:dairo/presentation/view/explore/widgets/widget_explore_publication.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetExploreGrid extends ViewModelWidget<ExploreViewModel> {
  @override
  Widget build(context, viewModel) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      children: viewModel.viewData.explorePublications
          .map((publication) => WidgetExplorePublication(
              publication: publication,
              onPublicationClicked: viewModel.onPublicationClicked))
          .toList(),
    );
  }
}
