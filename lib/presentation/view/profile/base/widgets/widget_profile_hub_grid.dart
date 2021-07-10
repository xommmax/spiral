import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetProfileHubGrid extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    if (viewModel.viewData.hubList.isEmpty) return _buildEmptyState();
    return _buildGrid(viewModel);
  }

  _buildGrid(ProfileViewModel viewModel) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: viewModel.viewData.hubList
            .map((hub) => _buildHub(hub, viewModel))
            .toList(),
      );

  Widget _buildHub(Hub hub, ProfileViewModel viewModel) => GestureDetector(
        onTap: () => viewModel.onHubClicked(hub.id),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: hub.pictureUrl,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(hub.name),
            ],
          ),
        ),
      );

  _buildEmptyState() => Center(
        child: Text(Strings.no_hubs),
      );
}
