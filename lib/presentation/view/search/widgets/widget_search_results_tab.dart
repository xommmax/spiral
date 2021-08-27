import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/domain/model/user/user.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_list_item.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_list_item.dart';
import 'package:dairo/presentation/view/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetTopSearchResultsTab extends ViewModelWidget<SearchViewModel> {
  @override
  Widget build(BuildContext context, SearchViewModel viewModel) =>
      ListView.builder(
          itemCount: viewModel.topSearchResults.length,
          itemBuilder: (context, index) {
            var result = viewModel.topSearchResults[index];
            if (result is User)
              return WidgetProfileListItem(result,
                  onProfileListItemClicked: viewModel.onProfileClicked);
            else if (result is Hub)
              return WidgetHubListItem(result,
                  onOpenHubDetailsClicked: viewModel.onHubSelected);
            else
              throw ArgumentError(Strings.unableToGetSearchResults);
          });
}

class WidgetProfileSearchResultsTab extends ViewModelWidget<SearchViewModel> {
  @override
  Widget build(
          BuildContext context, SearchViewModel viewModel) =>
      ListView.builder(
          itemCount: viewModel.profileSearchResults.length,
          itemBuilder: (context, index) => WidgetProfileListItem(
              viewModel.profileSearchResults[index],
              onProfileListItemClicked: viewModel.onProfileClicked));
}

class WidgetHubSearchResultsTab extends ViewModelWidget<SearchViewModel> {
  @override
  Widget build(
          BuildContext context, SearchViewModel viewModel) =>
      ListView.builder(
          itemCount: viewModel.hubSearchResults.length,
          itemBuilder: (context, index) => WidgetHubListItem(
              viewModel.hubSearchResults[index],
              onOpenHubDetailsClicked: viewModel.onHubSelected));
}
