import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubPublications extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) =>
      ListView.separated(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, position) => WidgetHubPublication(
          key: ValueKey(viewModel.viewData.publications[position].id),
          publication: viewModel.viewData.publications[position],
          onPublicationLikeClicked: viewModel.onPublicationLikeClicked,
          onUsersLikedScreenClicked: viewModel.onUsersLikedScreenClicked,
          onPublicationDetailsClicked: viewModel.onPublicationDetailsClicked,
          user: viewModel.viewData.user,
          hub: viewModel.viewData.hub,
          onUserClicked: viewModel.onUserClicked,
          onHubClicked: viewModel.onHubClicked,
        ),
        separatorBuilder: (context, position) => Divider(
          height: 14,
        ),
        itemCount: viewModel.viewData.publications.length,
      );
}
