import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubPublications extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, position) => WidgetHubPublication(
          key: ValueKey(viewModel.viewData.publications[position].id),
          user: viewModel.viewData.user!,
          publication: viewModel.viewData.publications[position],
          onPublicationLikeClicked: viewModel.onPublicationLikeClicked,
          onUsersLikedScreenClicked: viewModel.onUsersLikedScreenClicked,
          onPublicationDetailsClicked: viewModel.onPublicationDetailsClicked,
        ),
        separatorBuilder: (context, position) => Divider(
          height: 14,
        ),
        itemCount: viewModel.viewData.publications.length,
      );
}
