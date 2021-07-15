import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_grid.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetBaseProfileView<T extends BaseProfileViewModel>
    extends ViewModelWidget<T> {
  @override
  Widget build(BuildContext context, BaseProfileViewModel viewModel) => Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: InkWell(
              // onTap: ,
              child: Hero(
                tag: 'profilePhoto',
                child: WidgetProfilePhoto(
                  photoUrl: viewModel.getPhotoUrl(),
                  width: 120,
                  height: 120,
                ),
              ),
            ),
          ),
          Text(
            viewModel.viewData.user?.displayName ?? '',
            style: TextStyles.robotoBlack18,
          ),
          SizedBox(
            height: 50,
          ),
          WidgetHubGrid<T>()
        ],
      );
}
