import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_preview.dart';
import 'package:dairo/presentation/view/profile/current_user/current_user_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetCurrentUserHubGrid
    extends ViewModelWidget<CurrentUserProfileViewModel> {
  @override
  Widget build(BuildContext context, CurrentUserProfileViewModel viewModel) =>
      GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        childAspectRatio: 16 / 13,
        children: viewModel.viewData.hubs
            .map(
              (hub) => InkWell(
                onTap: () => viewModel.onOpenHubClicked(hub),
                child: WidgetHubPreview(hub),
              ),
            )
            .toList()
          ..insert(
            0,
            InkWell(
              onTap: () => viewModel.onCreateHubClicked(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.all(15),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
      );
}
