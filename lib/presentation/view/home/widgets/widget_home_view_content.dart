import 'package:dairo/presentation/view/home/home_viewmodel.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_publication.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'widget_toolbar_home.dart';

class WidgetHomeViewContent extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, viewModel) => Column(
        children: [
          AppBarHome(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(8),
              itemBuilder: (context, position) => WidgetHubPublication(
                key: ValueKey(viewModel.viewData.publications[position]!.id),
                publication: viewModel.viewData.publications[position]!,
                onPublicationLikeClicked: viewModel.onPublicationLikeClicked,
                onUsersLikedScreenClicked: viewModel.onUsersLikedScreenClicked,
                onPublicationDetailsClicked:
                    viewModel.onPublicationDetailsClicked,
                user: viewModel.viewData
                    .users[viewModel.viewData.publications[position]!.userId],
                hub: viewModel.viewData
                    .hubs[viewModel.viewData.publications[position]!.hubId],
                onUserClicked: viewModel.onUserClicked,
                onHubClicked: viewModel.onHubClicked,
              ),
              separatorBuilder: (context, position) => Divider(
                height: 14,
              ),
              itemCount: viewModel.viewData.publications.length,
            ),
          ),
        ],
      );
}
