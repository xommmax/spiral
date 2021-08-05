import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_list_item.dart';
import 'package:dairo/presentation/view/publication/users_liked/users_liked_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetUsersList extends ViewModelWidget<UsersLikedViewModel> {
  @override
  Widget build(BuildContext context, UsersLikedViewModel viewModel) =>
      viewModel.dataReady
          ? ListView.separated(
              itemBuilder: (context, index) => WidgetProfileListItem(
                viewModel.data![index],
                onProfileListItemClicked: viewModel.onProfileListItemClicked,
              ),
              separatorBuilder: (context, index) => Divider(
                height: 10,
              ),
              itemCount: viewModel.data!.length,
            )
          : ProgressBar(
              alignment: ProgressBarAlignment.Center,
            );
}
